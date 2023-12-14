#include "malloc.h"

typedef struct header
{
    struct header* next;
    struct header* prev;
    uint64_t size;
    int alloc; // 1 if allocated by malloc/realloc; 0 if free
    struct header* next_alloc_block;
}header __attribute__((aligned(8)));


#define HEADER_SIZE ((uint64_t) sizeof(header))
#define CANARY_SIZE ((uint64_t) sizeof(canary_value))
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT - 1)) & ~(ALIGNMENT - 1))

// Free list pointer
static header* free_list = NULL;

// Heap start pointer
static void* heap_start = NULL;
// Keep track of current heap location
void* program_break = NULL;

// List of all allocated blocks
header* malloc_list;

size_t canary_value = 1844674407370955161;

// Adds a free memory block to the beginning of the free list
void push_free_block(header* free_block)
{
    // List is not empty
    if (free_list != NULL)
    {
        // Remember old list head
        header* old_head = free_list;
        // Attach new free block as list head
        free_block->next = old_head;
        old_head->prev = free_block;
        free_block->prev = NULL;
        free_list = free_block;
    }
    else
    {
        free_list = free_block;
        free_block->prev = NULL;
        free_block->next = NULL;
    }
    // Reset "alloc" flag to 0 (free)
    free_block->alloc = 0;
}

// Push an allocated memory block to top of the malloc_list
void push_malloc_block(header* malloc_block)
{
    // List is not empty
    if (malloc_list != NULL)
    {
        // Remember old list head
        header* old_head = malloc_list;
        // Attach new free block as list head
        malloc_block->next_alloc_block = old_head;
        malloc_list = malloc_block;
    }
    else
    {
        malloc_list = malloc_block;
    }
}

// [First-fit strategy] Finds a free memory block suitable to hold sz + sizeof(header)
header* find_free_block(uint64_t sz){
    header* temp = free_list;
    while (temp != NULL)
    {
        if (temp->size >= sz)
        {
            return temp;
        }
        // Move to next memory block
        temp = temp->next;
    }
    return NULL;
}

// Reconnect free_list after a free block is partitioned
void reconnect_free_list(header* old_free_block)
{
    // Free block on both ends
    if(old_free_block->prev != NULL && old_free_block->next != NULL)
    {
        old_free_block->prev->next = old_free_block->next;
        old_free_block->next->prev = old_free_block->prev;
    }
    // First block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next != NULL)
    {
        free_list = old_free_block->next;
        old_free_block->next->prev = NULL;
    }
    // Last block on free_list
    else if(old_free_block->prev != NULL && old_free_block->next == NULL)
    {
        old_free_block->prev->next = NULL;
    }
    // Only block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next == NULL)
    {
        free_list = NULL;
    }
}

// Initialize header of a memory block that's about to be returned to user
void block_init(header* free_block)
{
    free_block->next = NULL;
    free_block->prev = NULL;
    free_block->next_alloc_block = NULL;
    free_block->alloc = 1;
}

/**
 * Set canary value in an allocated memory block
 * @mem_block assumed to be pointer to mem_block header
*/
void set_canary(intptr_t mem_block){
    // Get canary location
    intptr_t block_size = (intptr_t)(((header*) mem_block)->size);
    intptr_t canary_location = mem_block + block_size - ((intptr_t)(sizeof(canary_value)));
    // Set canary value
    memcpy(((void*)canary_location), &canary_value, sizeof(canary_value));
}

/**
 * Ensure overflow canary is intact
 * @memblock assumed to be a pointer to mem_block payload
*/
int check_canary(intptr_t mem_block)
{
    // Get canary location
    header* head = (header*)(mem_block - ((intptr_t) HEADER_SIZE));
    intptr_t block_size = (intptr_t)(head->size);
    intptr_t canary_location = (intptr_t)head + block_size - ((intptr_t)(sizeof(canary_value)));
    // Compare canary value
    size_t overflow_canary;
    memcpy(&overflow_canary, ((void*) canary_location), sizeof(canary_value));
    if(canary_value != overflow_canary)
    {
        return 0;
    }

    return 1;
}

// Merge two sorted sub arrays
void merge(header** ptr_array, header* left_array[], int left_size, header* right_array[], int right_size)
{
    int i = 0, j = 0, k = 0;
    while (i < left_size && j < right_size)
    {
        if (left_array[i]->size < right_array[j]->size)
        {
            ptr_array[k++] = right_array[j++];
        }
        else
        {
            ptr_array[k++] = left_array[i++];
        }
    }
    while (i < left_size)
    {
        ptr_array[k++] = left_array[i++];

    }
    while (j < right_size)
    {
        ptr_array[k++] = right_array[j++];
    }
    
}

// Merge sort function
void merge_sort(header** ptr_array, int size)
{
    // Base case
    if (size < 2)
    {
        return;
    }
    int middle = size/2;
    header* left_array[middle];
    header* right_array[size - middle];
    // Populate left and right sub-arrays
    for (int i = 0; i < middle; i++)
    {
        left_array[i] = ptr_array[i];
    }
    for (int j = middle; j < size; j++)
    {
        right_array[j - middle] = ptr_array[j];
    }
    // Recursively sort left and right sub-arrays
    merge_sort(left_array, middle);
    merge_sort(right_array, (size - middle));
    // Merge sorted sub-arrays back to original array
    merge(ptr_array, left_array, middle, right_array, (size - middle));
}

// free(ptr)
// the free funtion frees the memory space pointed to by ptr, which must have been returned
// by a previous call to malloc or realloc, or if free has already been called before, then
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void *firstbyte) {
    // Corner cases: NULL pointer passed
    if (firstbyte == NULL)
    {
        return;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) firstbyte) - ((intptr_t)HEADER_SIZE));
    // Ensure memory block was previously allocated
    if(head->alloc == 1)
    {
        // Push memory block into free_list
        push_free_block(head);
        head->alloc = 0;
    }
    return;
}


// malloc(sz):
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void *malloc(uint64_t numbytes) {
    // Coner case
    if (numbytes == 0)
    {
        return NULL;
    }
    // Compute size of memory to allocate
    uint64_t mem_alloc = (uint64_t)(((intptr_t) numbytes) + ((intptr_t) HEADER_SIZE) + ((intptr_t) sizeof(canary_value)));
    // Search for a suitable memory block to assign
    header* free_block = find_free_block(mem_alloc);
    // Initial malloc: free_list is empty
    if (free_block  == NULL)
    {
        // Expand heap by: 100-byte block + requested bytes + HEADER_SIZE
        void* ret = sbrk(mem_alloc);
        if (ret == ((void*)-1))
        {
            return NULL;
        }
        // 8-align address returned by sbrk()
        ret = (void*)(ALIGN((intptr_t)ret));
        // Set Heap_start
        if(free_list == NULL)
        {
            heap_start = ret;
        }
        // Update program break location
        program_break = ret;
        // Set size of memory block
        ((header*) ret)->size = mem_alloc;
        // Assign free memory block
        free_block = ((header*) ret);
    }
    else
    {
        // Remove block from free_list
        reconnect_free_list(free_block);
    }
    // Partition NOT required
    if ((free_block->size - mem_alloc) <= HEADER_SIZE)
    {
        // No update to block size
        block_init(free_block);
        // Set canary value
        set_canary((intptr_t) free_block);
        // Add block to malloc_list
        push_malloc_block(free_block);
        // Get payload pointer
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
    
        return ret;
    }
    // Partition required
    else
    {
        // Resize the orginal "free block" header 
        intptr_t new_free_block = (((intptr_t) free_block) + mem_alloc);
        // Ensure "new_free_block" is page-aligned
        header* new_free_block_align = (header*)(ALIGN(new_free_block));
        // Update size of new_free_block
        uint64_t new_free_block_align_size = free_block->size - mem_alloc - (((intptr_t)new_free_block_align) - new_free_block);
        new_free_block_align->size = new_free_block_align_size;
        // Update assigned "free block" (to be returned)
        block_init(free_block);
        // Push "new_free_block"
        push_free_block(new_free_block_align);
        free_block->size = mem_alloc;
        // Set canary value
        set_canary((intptr_t) free_block);
        // Add block to malloc_list
        push_malloc_block(free_block);
        // Get payload pointer
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));

        
        return ret;
    }
    return NULL;
}

// calloc(num, sz):
// allocates memory of an array of num elements of size sz bytes each and returns a pointer 
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz) {
    // Calculate total memory to be allocated
    uint64_t total_memory = num * sz;
    // Request for memory
    void* new_memory_block = malloc(total_memory);
    // Error while allocating memory
    if (new_memory_block == NULL)
    {
        return NULL;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) new_memory_block) - ((intptr_t) HEADER_SIZE));
    // Zero out the memory
    memset(new_memory_block, 0, ((size_t)total_memory));
    // Check for overflow***
    if(check_canary((intptr_t) new_memory_block) == 0)
    {
        // free memory that was malloc'd
        return NULL;
    }
    return new_memory_block;
}

// realloc(ptr, sz)
// realloc changes the size of the memory block pointed to by ptr to size bytes.
// the contents will be unchanged in the range from the start of the region up to the
// minimum of the old and new sizes
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz) {
    // Corner case: ptr is NULL, ptr provided but sz is 0
    if (ptr == NULL)
    {
        return malloc(sz);
    }
    if (ptr && (sz == 0))
    {
        free(ptr);
        return NULL;
    }
    // Get head of memory block
    header* head = (header*)(((intptr_t) ptr) - ((intptr_t) HEADER_SIZE));
    
    // Allocate new, larger/smaller memory
    void* ret = malloc(sz);
    if (ret == ((void*) -1))
    {
        // Error while allocating new memory block
        return NULL;
    }
    // Transfer data from old mem block to new mem block
    memcpy(ret, ptr, ((size_t) head->size));
    // Push old block to free_list
    free((header*) ptr);
        
    return ret;
}

/**
 * Invariant: no two unallocated blocks are adjacent in the heap
 * 1. No merge if blocks on either side are allocated
 * 2. Merge with right block if it's free
 * 3. Merge with left block if it's free
 * 4. Merge with both left and right blocks if both are free
*/
void defrag() {

}
// heap_info_struct
// will be used by the heap_info function to store relevant data
// num_allocs: store current number of allocations
// ptr_array: pointer to an array of pointers of each allocation.
//			each pointer should be a currently alloc'd pointer
//			size of array should be equal to num_allocs
//			list should be sorted by size of allocation
// size_array: pointer to an array of size of each allocation
//		size_array[i] should hold the size of allocation for ptr_array[i]
//		should be sorted in descending order
// free_space: size of free space
// largest_free_chunk: size of the largest free chunk

// heap_info(info)
// set the appropriate values in the heap_info_struct passed
// the malloc library will be responsible for alloc'ing size_array and 
// ptr_array
// the user, i.e. the process will be responsible for freeing these allocations
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info) {
    int debug = 0;
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
    // Find "largest_free_chunk", "free_space" from free_list
    header* temp = free_list;
    while (temp != NULL)
    {
        // Ensure block is free
        if (temp->alloc == 0)
        {
            free_space += temp->size;
            if (temp->size > ((uint64_t)largest_free_chunk))
            {
                largest_free_chunk = temp->size;
            }
        }
        temp = temp->next;
    }
    // Find "num_allocs" from malloc_list
    temp = malloc_list;
    while (temp != NULL)
    {
        // Ensure block has not been freed
        if (temp->alloc == 1)
        {
            num_allocs ++;
        }
        temp = temp->next_alloc_block;
    }
    // Create ptr_array (list of pointers to memory block headers)
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
    if (ptr_array == NULL)
    {
        return -1;
    }
    int count = 0;
    // Reinitialize "temp"
    temp = malloc_list;
    while (temp != NULL && (count < num_allocs))
    {
        // Ensure block has not been freed
        if (temp->alloc == 1)
        {
            ptr_array[count] = temp;
            count += 1;
        }
        temp = temp->next_alloc_block;
    }
    // Sort ptr_array in descending order
    merge_sort(ptr_array, num_allocs);
    // Create "size_array"
    long* size_array = malloc(sizeof(long) * num_allocs);
    if (size_array == NULL)
    {
        return -1;
    }
    for(int i = 0; i < num_allocs; i++)
    {
        size_array[i] = (long)ptr_array[i]->size;
    }
    // Assign values to heap_info_struct
    info->num_allocs = num_allocs;
    info->size_array = size_array;
    info->ptr_array = (void**)ptr_array;
    info->free_space = free_space;
    info->largest_free_chunk = largest_free_chunk;
    return 0;
}
