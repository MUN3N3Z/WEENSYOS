
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 3f 30 10 00       	mov    $0x10303f,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 f1 1f 00 00 	mov    %rax,0x1ff1(%rip)        # 102010 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 d5 1f 00 00 	mov    %rax,0x1fd5(%rip)        # 102008 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 a5 09 00 00       	call   1009e1 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 53 03 00 00       	call   1003b7 <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <push_free_block>:

// Adds a free memory block to the beginning of the free list
void push_free_block(header* free_block)
{
    // List is not empty
    if (free_list != NULL)
  100071:	48 8b 05 b8 1f 00 00 	mov    0x1fb8(%rip),%rax        # 102030 <free_list>
  100078:	48 85 c0             	test   %rax,%rax
  10007b:	74 1e                	je     10009b <push_free_block+0x2a>
    {
        // Remember old list head
        header* old_head = free_list;
        // Attach new free block as list head
        free_block->next = old_head;
  10007d:	48 89 07             	mov    %rax,(%rdi)
        old_head->prev = free_block;
  100080:	48 89 78 08          	mov    %rdi,0x8(%rax)
        free_block->prev = NULL;
  100084:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10008b:	00 
        free_list = free_block;
  10008c:	48 89 3d 9d 1f 00 00 	mov    %rdi,0x1f9d(%rip)        # 102030 <free_list>
        free_list = free_block;
        free_block->prev = NULL;
        free_block->next = NULL;
    }
    // Reset "alloc" flag to 0 (free)
    free_block->alloc = 0;
  100093:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
}
  10009a:	c3                   	ret    
        free_list = free_block;
  10009b:	48 89 3d 8e 1f 00 00 	mov    %rdi,0x1f8e(%rip)        # 102030 <free_list>
        free_block->prev = NULL;
  1000a2:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1000a9:	00 
        free_block->next = NULL;
  1000aa:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
  1000b1:	eb e0                	jmp    100093 <push_free_block+0x22>

00000000001000b3 <push_malloc_block>:

// Push an allocated memory block to top of the malloc_list
void push_malloc_block(header* malloc_block)
{
    // List is not empty
    if (malloc_list != NULL)
  1000b3:	48 8b 05 5e 1f 00 00 	mov    0x1f5e(%rip),%rax        # 102018 <malloc_list>
  1000ba:	48 85 c0             	test   %rax,%rax
  1000bd:	74 04                	je     1000c3 <push_malloc_block+0x10>
    {
        // Remember old list head
        header* old_head = malloc_list;
        // Attach new free block as list head
        malloc_block->next_alloc_block = old_head;
  1000bf:	48 89 47 20          	mov    %rax,0x20(%rdi)
        malloc_list = malloc_block;
  1000c3:	48 89 3d 4e 1f 00 00 	mov    %rdi,0x1f4e(%rip)        # 102018 <malloc_list>
    }
    else
    {
        malloc_list = malloc_block;
    }
}
  1000ca:	c3                   	ret    

00000000001000cb <find_free_block>:

// [First-fit strategy] Finds a free memory block suitable to hold sz + sizeof(header)
header* find_free_block(uint64_t sz){
    header* temp = free_list;
  1000cb:	48 8b 05 5e 1f 00 00 	mov    0x1f5e(%rip),%rax        # 102030 <free_list>
    while (temp != NULL)
  1000d2:	48 85 c0             	test   %rax,%rax
  1000d5:	74 0e                	je     1000e5 <find_free_block+0x1a>
    {
        if (temp->size >= sz)
  1000d7:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  1000db:	73 08                	jae    1000e5 <find_free_block+0x1a>
        {
            return temp;
        }
        // Move to next memory block
        temp = temp->next;
  1000dd:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  1000e0:	48 85 c0             	test   %rax,%rax
  1000e3:	75 f2                	jne    1000d7 <find_free_block+0xc>
    }
    return NULL;
}
  1000e5:	c3                   	ret    

00000000001000e6 <reconnect_free_list>:

// Reconnect free_list after a free block is partitioned
void reconnect_free_list(header* old_free_block)
{
    // Free block on both ends
    if(old_free_block->prev != NULL && old_free_block->next != NULL)
  1000e6:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000ea:	48 85 c0             	test   %rax,%rax
  1000ed:	74 14                	je     100103 <reconnect_free_list+0x1d>
  1000ef:	48 8b 17             	mov    (%rdi),%rdx
  1000f2:	48 85 d2             	test   %rdx,%rdx
  1000f5:	74 24                	je     10011b <reconnect_free_list+0x35>
    {
        old_free_block->prev->next = old_free_block->next;
  1000f7:	48 89 10             	mov    %rdx,(%rax)
        old_free_block->next->prev = old_free_block->prev;
  1000fa:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000fe:	48 89 42 08          	mov    %rax,0x8(%rdx)
  100102:	c3                   	ret    
    }
    // First block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next != NULL)
  100103:	48 8b 07             	mov    (%rdi),%rax
  100106:	48 85 c0             	test   %rax,%rax
  100109:	74 18                	je     100123 <reconnect_free_list+0x3d>
    {
        free_list = old_free_block->next;
  10010b:	48 89 05 1e 1f 00 00 	mov    %rax,0x1f1e(%rip)        # 102030 <free_list>
        old_free_block->next->prev = NULL;
  100112:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100119:	00 
  10011a:	c3                   	ret    
    }
    // Last block on free_list
    else if(old_free_block->prev != NULL && old_free_block->next == NULL)
    {
        old_free_block->prev->next = NULL;
  10011b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  100122:	c3                   	ret    
    }
    // Only block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next == NULL)
    {
        free_list = NULL;
  100123:	48 c7 05 02 1f 00 00 	movq   $0x0,0x1f02(%rip)        # 102030 <free_list>
  10012a:	00 00 00 00 
    }
}
  10012e:	c3                   	ret    

000000000010012f <block_init>:

// Initialize header of a memory block that's about to be returned to user
void block_init(header* free_block)
{
    free_block->next = NULL;
  10012f:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    free_block->prev = NULL;
  100136:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10013d:	00 
    free_block->next_alloc_block = NULL;
  10013e:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  100145:	00 
    free_block->alloc = 1;
  100146:	c7 47 18 01 00 00 00 	movl   $0x1,0x18(%rdi)
}
  10014d:	c3                   	ret    

000000000010014e <set_canary>:

/**
 * Set canary value in an allocated memory block
 * @mem_block assumed to be pointer to mem_block header
*/
void set_canary(intptr_t mem_block){
  10014e:	55                   	push   %rbp
  10014f:	48 89 e5             	mov    %rsp,%rbp
    // Get canary location
    intptr_t block_size = (intptr_t)(((header*) mem_block)->size);
    intptr_t canary_location = mem_block + block_size - ((intptr_t)(sizeof(canary_value)));
  100152:	48 03 7f 10          	add    0x10(%rdi),%rdi
  100156:	48 83 ef 08          	sub    $0x8,%rdi
    // Set canary value
    memcpy(((void*)canary_location), &canary_value, sizeof(canary_value));
  10015a:	ba 08 00 00 00       	mov    $0x8,%edx
  10015f:	be 00 20 10 00       	mov    $0x102000,%esi
  100164:	e8 bd 05 00 00       	call   100726 <memcpy>
}
  100169:	5d                   	pop    %rbp
  10016a:	c3                   	ret    

000000000010016b <check_canary>:
/**
 * Ensure overflow canary is intact
 * @memblock assumed to be a pointer to mem_block payload
*/
int check_canary(intptr_t mem_block)
{
  10016b:	55                   	push   %rbp
  10016c:	48 89 e5             	mov    %rsp,%rbp
  10016f:	48 83 ec 10          	sub    $0x10,%rsp
    // Get canary location
    header* head = (header*)(mem_block - ((intptr_t) HEADER_SIZE));
    intptr_t block_size = (intptr_t)(head->size);
    intptr_t canary_location = (intptr_t)head + block_size - ((intptr_t)(sizeof(canary_value)));
  100173:	48 03 7f e8          	add    -0x18(%rdi),%rdi
  100177:	48 8d 77 d0          	lea    -0x30(%rdi),%rsi
    // Compare canary value
    size_t overflow_canary;
    memcpy(&overflow_canary, ((void*) canary_location), sizeof(canary_value));
  10017b:	ba 08 00 00 00       	mov    $0x8,%edx
  100180:	48 8d 7d f8          	lea    -0x8(%rbp),%rdi
  100184:	e8 9d 05 00 00       	call   100726 <memcpy>
    if(canary_value != overflow_canary)
  100189:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10018d:	48 39 05 6c 1e 00 00 	cmp    %rax,0x1e6c(%rip)        # 102000 <canary_value>
  100194:	0f 94 c0             	sete   %al
  100197:	0f b6 c0             	movzbl %al,%eax
    {
        return 0;
    }

    return 1;
}
  10019a:	c9                   	leave  
  10019b:	c3                   	ret    

000000000010019c <merge>:

// Merge two sorted sub arrays
void merge(header** ptr_array, header* left_array[], int left_size, header* right_array[], int right_size)
{
  10019c:	55                   	push   %rbp
  10019d:	48 89 e5             	mov    %rsp,%rbp
  1001a0:	41 55                	push   %r13
  1001a2:	41 54                	push   %r12
  1001a4:	53                   	push   %rbx
  1001a5:	48 89 f3             	mov    %rsi,%rbx
  1001a8:	41 89 d1             	mov    %edx,%r9d
  1001ab:	49 89 ca             	mov    %rcx,%r10
    int i = 0, j = 0, k = 0;
    while (i < left_size && j < right_size)
  1001ae:	85 d2                	test   %edx,%edx
  1001b0:	7e 57                	jle    100209 <merge+0x6d>
  1001b2:	45 85 c0             	test   %r8d,%r8d
  1001b5:	7e 52                	jle    100209 <merge+0x6d>
  1001b7:	48 89 fe             	mov    %rdi,%rsi
  1001ba:	b9 01 00 00 00       	mov    $0x1,%ecx
    int i = 0, j = 0, k = 0;
  1001bf:	ba 00 00 00 00       	mov    $0x0,%edx
  1001c4:	b8 00 00 00 00       	mov    $0x0,%eax
  1001c9:	eb 1a                	jmp    1001e5 <merge+0x49>
        {
            ptr_array[k++] = right_array[j++];
        }
        else
        {
            ptr_array[k++] = left_array[i++];
  1001cb:	83 c0 01             	add    $0x1,%eax
  1001ce:	41 89 cb             	mov    %ecx,%r11d
  1001d1:	4c 89 26             	mov    %r12,(%rsi)
    while (i < left_size && j < right_size)
  1001d4:	83 c1 01             	add    $0x1,%ecx
  1001d7:	48 83 c6 08          	add    $0x8,%rsi
  1001db:	44 39 c8             	cmp    %r9d,%eax
  1001de:	7d 39                	jge    100219 <merge+0x7d>
  1001e0:	44 39 c2             	cmp    %r8d,%edx
  1001e3:	7d 34                	jge    100219 <merge+0x7d>
        if (left_array[i]->size < right_array[j]->size)
  1001e5:	4c 63 d8             	movslq %eax,%r11
  1001e8:	4e 8b 24 db          	mov    (%rbx,%r11,8),%r12
  1001ec:	4c 63 da             	movslq %edx,%r11
  1001ef:	4f 8b 2c da          	mov    (%r10,%r11,8),%r13
  1001f3:	4d 8b 5d 10          	mov    0x10(%r13),%r11
  1001f7:	4d 39 5c 24 10       	cmp    %r11,0x10(%r12)
  1001fc:	73 cd                	jae    1001cb <merge+0x2f>
            ptr_array[k++] = right_array[j++];
  1001fe:	83 c2 01             	add    $0x1,%edx
  100201:	41 89 cb             	mov    %ecx,%r11d
  100204:	4c 89 2e             	mov    %r13,(%rsi)
  100207:	eb cb                	jmp    1001d4 <merge+0x38>
    int i = 0, j = 0, k = 0;
  100209:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  10020f:	ba 00 00 00 00       	mov    $0x0,%edx
  100214:	b8 00 00 00 00       	mov    $0x0,%eax
        }
    }
    while (i < left_size)
  100219:	41 39 c1             	cmp    %eax,%r9d
  10021c:	7e 39                	jle    100257 <merge+0xbb>
  10021e:	41 89 c4             	mov    %eax,%r12d
  100221:	44 89 ce             	mov    %r9d,%esi
  100224:	29 c6                	sub    %eax,%esi
  100226:	48 c1 e6 03          	shl    $0x3,%rsi
  10022a:	48 98                	cltq   
  10022c:	4c 8d 2c c3          	lea    (%rbx,%rax,8),%r13
  100230:	49 63 c3             	movslq %r11d,%rax
  100233:	48 8d 1c c7          	lea    (%rdi,%rax,8),%rbx
  100237:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = left_array[i++];
  10023c:	49 8b 4c 05 00       	mov    0x0(%r13,%rax,1),%rcx
  100241:	48 89 0c 03          	mov    %rcx,(%rbx,%rax,1)
    while (i < left_size)
  100245:	48 83 c0 08          	add    $0x8,%rax
  100249:	48 39 f0             	cmp    %rsi,%rax
  10024c:	75 ee                	jne    10023c <merge+0xa0>
  10024e:	45 01 d9             	add    %r11d,%r9d
        ptr_array[k++] = left_array[i++];
  100251:	45 29 e1             	sub    %r12d,%r9d
  100254:	45 89 cb             	mov    %r9d,%r11d

    }
    while (j < right_size)
  100257:	41 39 d0             	cmp    %edx,%r8d
  10025a:	7e 2b                	jle    100287 <merge+0xeb>
  10025c:	41 29 d0             	sub    %edx,%r8d
  10025f:	49 c1 e0 03          	shl    $0x3,%r8
  100263:	48 63 d2             	movslq %edx,%rdx
  100266:	49 8d 34 d2          	lea    (%r10,%rdx,8),%rsi
  10026a:	4d 63 db             	movslq %r11d,%r11
  10026d:	4a 8d 0c df          	lea    (%rdi,%r11,8),%rcx
  100271:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = right_array[j++];
  100276:	48 8b 14 06          	mov    (%rsi,%rax,1),%rdx
  10027a:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    while (j < right_size)
  10027e:	48 83 c0 08          	add    $0x8,%rax
  100282:	4c 39 c0             	cmp    %r8,%rax
  100285:	75 ef                	jne    100276 <merge+0xda>
    }
    
}
  100287:	5b                   	pop    %rbx
  100288:	41 5c                	pop    %r12
  10028a:	41 5d                	pop    %r13
  10028c:	5d                   	pop    %rbp
  10028d:	c3                   	ret    

000000000010028e <merge_sort>:

// Merge sort function
void merge_sort(header** ptr_array, int size)
{
  10028e:	55                   	push   %rbp
  10028f:	48 89 e5             	mov    %rsp,%rbp
  100292:	41 57                	push   %r15
  100294:	41 56                	push   %r14
  100296:	41 55                	push   %r13
  100298:	41 54                	push   %r12
  10029a:	53                   	push   %rbx
  10029b:	48 83 ec 18          	sub    $0x18,%rsp
  10029f:	48 89 fb             	mov    %rdi,%rbx
  1002a2:	48 89 e7             	mov    %rsp,%rdi
    // Base case
    if (size < 2)
  1002a5:	83 fe 01             	cmp    $0x1,%esi
  1002a8:	0f 8e d4 00 00 00    	jle    100382 <merge_sort+0xf4>
    {
        return;
    }
    int middle = size/2;
  1002ae:	41 89 f6             	mov    %esi,%r14d
  1002b1:	41 c1 ee 1f          	shr    $0x1f,%r14d
  1002b5:	41 01 f6             	add    %esi,%r14d
  1002b8:	41 d1 fe             	sar    %r14d
    header* left_array[middle];
  1002bb:	49 63 ce             	movslq %r14d,%rcx
  1002be:	48 c1 e1 03          	shl    $0x3,%rcx
  1002c2:	41 b8 10 00 00 00    	mov    $0x10,%r8d
  1002c8:	48 8d 41 0f          	lea    0xf(%rcx),%rax
  1002cc:	ba 00 00 00 00       	mov    $0x0,%edx
  1002d1:	49 f7 f0             	div    %r8
  1002d4:	48 c1 e0 04          	shl    $0x4,%rax
  1002d8:	48 29 c4             	sub    %rax,%rsp
  1002db:	49 89 e4             	mov    %rsp,%r12
    header* right_array[size - middle];
  1002de:	41 89 f7             	mov    %esi,%r15d
  1002e1:	45 29 f7             	sub    %r14d,%r15d
  1002e4:	49 63 c7             	movslq %r15d,%rax
  1002e7:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
  1002ee:	00 
  1002ef:	ba 00 00 00 00       	mov    $0x0,%edx
  1002f4:	49 f7 f0             	div    %r8
  1002f7:	48 c1 e0 04          	shl    $0x4,%rax
  1002fb:	48 29 c4             	sub    %rax,%rsp
  1002fe:	49 89 e5             	mov    %rsp,%r13
  100301:	b8 00 00 00 00       	mov    $0x0,%eax
    // Populate left and right sub-arrays
    for (int i = 0; i < middle; i++)
    {
        left_array[i] = ptr_array[i];
  100306:	48 8b 14 03          	mov    (%rbx,%rax,1),%rdx
  10030a:	49 89 14 04          	mov    %rdx,(%r12,%rax,1)
    for (int i = 0; i < middle; i++)
  10030e:	48 83 c0 08          	add    $0x8,%rax
  100312:	48 39 c1             	cmp    %rax,%rcx
  100315:	75 ef                	jne    100306 <merge_sort+0x78>
    }
    for (int j = middle; j < size; j++)
  100317:	44 39 f6             	cmp    %r14d,%esi
  10031a:	7e 25                	jle    100341 <merge_sort+0xb3>
  10031c:	44 29 f6             	sub    %r14d,%esi
  10031f:	48 8d 14 f5 00 00 00 	lea    0x0(,%rsi,8),%rdx
  100326:	00 
  100327:	48 01 d9             	add    %rbx,%rcx
  10032a:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        right_array[j - middle] = ptr_array[j];
  10032f:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  100333:	49 89 74 05 00       	mov    %rsi,0x0(%r13,%rax,1)
    for (int j = middle; j < size; j++)
  100338:	48 83 c0 08          	add    $0x8,%rax
  10033c:	48 39 d0             	cmp    %rdx,%rax
  10033f:	75 ee                	jne    10032f <merge_sort+0xa1>
  100341:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    }
    // Recursively sort left and right sub-arrays
    merge_sort(left_array, middle);
  100345:	44 89 f6             	mov    %r14d,%esi
  100348:	4c 89 e7             	mov    %r12,%rdi
  10034b:	e8 3e ff ff ff       	call   10028e <merge_sort>
    merge_sort(right_array, (size - middle));
  100350:	44 89 fe             	mov    %r15d,%esi
  100353:	4c 89 ef             	mov    %r13,%rdi
  100356:	e8 33 ff ff ff       	call   10028e <merge_sort>
    // Merge sorted sub-arrays back to original array
    merge(ptr_array, left_array, middle, right_array, (size - middle));
  10035b:	45 89 f8             	mov    %r15d,%r8d
  10035e:	4c 89 e9             	mov    %r13,%rcx
  100361:	44 89 f2             	mov    %r14d,%edx
  100364:	4c 89 e6             	mov    %r12,%rsi
  100367:	48 89 df             	mov    %rbx,%rdi
  10036a:	e8 2d fe ff ff       	call   10019c <merge>
  10036f:	48 8b 65 c8          	mov    -0x38(%rbp),%rsp
}
  100373:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  100377:	5b                   	pop    %rbx
  100378:	41 5c                	pop    %r12
  10037a:	41 5d                	pop    %r13
  10037c:	41 5e                	pop    %r14
  10037e:	41 5f                	pop    %r15
  100380:	5d                   	pop    %rbp
  100381:	c3                   	ret    
        return;
  100382:	48 89 fc             	mov    %rdi,%rsp
  100385:	eb ec                	jmp    100373 <merge_sort+0xe5>

0000000000100387 <free>:
// by a previous call to malloc or realloc, or if free has already been called before, then
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void *firstbyte) {
    // Corner cases: NULL pointer passed
    if (firstbyte == NULL)
  100387:	48 85 ff             	test   %rdi,%rdi
  10038a:	74 2a                	je     1003b6 <free+0x2f>
void free(void *firstbyte) {
  10038c:	55                   	push   %rbp
  10038d:	48 89 e5             	mov    %rsp,%rbp
  100390:	53                   	push   %rbx
  100391:	48 83 ec 08          	sub    $0x8,%rsp
    {
        return;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) firstbyte) - ((intptr_t)HEADER_SIZE));
  100395:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    // Ensure memory block was previously allocated
    if(head->alloc == 1)
  100399:	83 7f f0 01          	cmpl   $0x1,-0x10(%rdi)
  10039d:	74 06                	je     1003a5 <free+0x1e>
        // Push memory block into free_list
        push_free_block(head);
        head->alloc = 0;
    }
    return;
}
  10039f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1003a3:	c9                   	leave  
  1003a4:	c3                   	ret    
        push_free_block(head);
  1003a5:	48 89 df             	mov    %rbx,%rdi
  1003a8:	e8 c4 fc ff ff       	call   100071 <push_free_block>
        head->alloc = 0;
  1003ad:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
  1003b4:	eb e9                	jmp    10039f <free+0x18>
  1003b6:	c3                   	ret    

00000000001003b7 <malloc>:
// malloc(sz):
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void *malloc(uint64_t numbytes) {
  1003b7:	55                   	push   %rbp
  1003b8:	48 89 e5             	mov    %rsp,%rbp
  1003bb:	41 54                	push   %r12
  1003bd:	53                   	push   %rbx
    // Coner case
    if (numbytes == 0)
    {
        return NULL;
  1003be:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0)
  1003c3:	48 85 ff             	test   %rdi,%rdi
  1003c6:	0f 84 d9 00 00 00    	je     1004a5 <malloc+0xee>
    }
    // Compute size of memory to allocate
    uint64_t mem_alloc = (uint64_t)(((intptr_t) numbytes) + ((intptr_t) HEADER_SIZE) + ((intptr_t) sizeof(canary_value)));
  1003cc:	4c 8d 67 30          	lea    0x30(%rdi),%r12
    // Search for a suitable memory block to assign
    header* free_block = find_free_block(mem_alloc);
  1003d0:	4c 89 e7             	mov    %r12,%rdi
  1003d3:	e8 f3 fc ff ff       	call   1000cb <find_free_block>
  1003d8:	48 89 c3             	mov    %rax,%rbx
    // Initial malloc: free_list is empty
    if (free_block  == NULL)
  1003db:	48 85 c0             	test   %rax,%rax
  1003de:	74 6b                	je     10044b <malloc+0x94>
        free_block = ((header*) ret);
    }
    else
    {
        // Remove block from free_list
        reconnect_free_list(free_block);
  1003e0:	48 89 c7             	mov    %rax,%rdi
  1003e3:	e8 fe fc ff ff       	call   1000e6 <reconnect_free_list>
    }
    // Partition NOT required
    if ((free_block->size - mem_alloc) <= HEADER_SIZE)
  1003e8:	48 8b 43 10          	mov    0x10(%rbx),%rax
  1003ec:	4c 29 e0             	sub    %r12,%rax
  1003ef:	48 83 f8 28          	cmp    $0x28,%rax
  1003f3:	76 7e                	jbe    100473 <malloc+0xbc>
    }
    // Partition required
    else
    {
        // Resize the orginal "free block" header 
        intptr_t new_free_block = (((intptr_t) free_block) + mem_alloc);
  1003f5:	4a 8d 14 23          	lea    (%rbx,%r12,1),%rdx
        // Ensure "new_free_block" is page-aligned
        header* new_free_block_align = (header*)(ALIGN(new_free_block));
  1003f9:	48 8d 7a 07          	lea    0x7(%rdx),%rdi
  1003fd:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
        // Update size of new_free_block
        uint64_t new_free_block_align_size = free_block->size - mem_alloc - (((intptr_t)new_free_block_align) - new_free_block);
  100401:	48 89 f9             	mov    %rdi,%rcx
  100404:	48 29 d1             	sub    %rdx,%rcx
  100407:	48 29 c8             	sub    %rcx,%rax
  10040a:	48 89 47 10          	mov    %rax,0x10(%rdi)
    free_block->next = NULL;
  10040e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  100415:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10041c:	00 
    free_block->next_alloc_block = NULL;
  10041d:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  100424:	00 
    free_block->alloc = 1;
  100425:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        new_free_block_align->size = new_free_block_align_size;
        // Update assigned "free block" (to be returned)
        block_init(free_block);
        // Push "new_free_block"
        push_free_block(new_free_block_align);
  10042c:	e8 40 fc ff ff       	call   100071 <push_free_block>
        free_block->size = mem_alloc;
  100431:	4c 89 63 10          	mov    %r12,0x10(%rbx)
        // Set canary value
        set_canary((intptr_t) free_block);
  100435:	48 89 df             	mov    %rbx,%rdi
  100438:	e8 11 fd ff ff       	call   10014e <set_canary>
        // Add block to malloc_list
        push_malloc_block(free_block);
  10043d:	48 89 df             	mov    %rbx,%rdi
  100440:	e8 6e fc ff ff       	call   1000b3 <push_malloc_block>
        // Get payload pointer
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  100445:	48 83 c3 28          	add    $0x28,%rbx

        
        return ret;
  100449:	eb 5a                	jmp    1004a5 <malloc+0xee>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  10044b:	4c 89 e7             	mov    %r12,%rdi
  10044e:	cd 3a                	int    $0x3a
  100450:	48 89 05 d1 1b 00 00 	mov    %rax,0x1bd1(%rip)        # 102028 <result.0>
        if (ret == ((void*)-1))
  100457:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10045b:	74 48                	je     1004a5 <malloc+0xee>
        ret = (void*)(ALIGN((intptr_t)ret));
  10045d:	48 83 c0 07          	add    $0x7,%rax
  100461:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100465:	48 89 c3             	mov    %rax,%rbx
        program_break = ret;
  100468:	48 89 05 b1 1b 00 00 	mov    %rax,0x1bb1(%rip)        # 102020 <program_break>
        ((header*) ret)->size = mem_alloc;
  10046f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    free_block->next = NULL;
  100473:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  10047a:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100481:	00 
    free_block->next_alloc_block = NULL;
  100482:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  100489:	00 
    free_block->alloc = 1;
  10048a:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        set_canary((intptr_t) free_block);
  100491:	48 89 df             	mov    %rbx,%rdi
  100494:	e8 b5 fc ff ff       	call   10014e <set_canary>
        push_malloc_block(free_block);
  100499:	48 89 df             	mov    %rbx,%rdi
  10049c:	e8 12 fc ff ff       	call   1000b3 <push_malloc_block>
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  1004a1:	48 83 c3 28          	add    $0x28,%rbx
    }
    return NULL;
}
  1004a5:	48 89 d8             	mov    %rbx,%rax
  1004a8:	5b                   	pop    %rbx
  1004a9:	41 5c                	pop    %r12
  1004ab:	5d                   	pop    %rbp
  1004ac:	c3                   	ret    

00000000001004ad <calloc>:
// allocates memory of an array of num elements of size sz bytes each and returns a pointer 
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz) {
  1004ad:	55                   	push   %rbp
  1004ae:	48 89 e5             	mov    %rsp,%rbp
  1004b1:	41 54                	push   %r12
  1004b3:	53                   	push   %rbx
    // Calculate total memory to be allocated
    uint64_t total_memory = num * sz;
  1004b4:	48 0f af fe          	imul   %rsi,%rdi
  1004b8:	49 89 fc             	mov    %rdi,%r12
    // Request for memory
    void* new_memory_block = malloc(total_memory);
  1004bb:	e8 f7 fe ff ff       	call   1003b7 <malloc>
  1004c0:	48 89 c3             	mov    %rax,%rbx
    // Error while allocating memory
    if (new_memory_block == NULL)
  1004c3:	48 85 c0             	test   %rax,%rax
  1004c6:	74 23                	je     1004eb <calloc+0x3e>
        return NULL;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) new_memory_block) - ((intptr_t) HEADER_SIZE));
    // Zero out the memory
    memset(new_memory_block, 0, ((size_t)total_memory));
  1004c8:	4c 89 e2             	mov    %r12,%rdx
  1004cb:	be 00 00 00 00       	mov    $0x0,%esi
  1004d0:	48 89 c7             	mov    %rax,%rdi
  1004d3:	e8 4c 03 00 00       	call   100824 <memset>
    // Check for overflow***
    if(check_canary((intptr_t) new_memory_block) == 0)
  1004d8:	48 89 df             	mov    %rbx,%rdi
  1004db:	e8 8b fc ff ff       	call   10016b <check_canary>
    {
        // free memory that was malloc'd
        return NULL;
  1004e0:	85 c0                	test   %eax,%eax
  1004e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1004e7:	48 0f 44 d8          	cmove  %rax,%rbx
    }
    return new_memory_block;
}
  1004eb:	48 89 d8             	mov    %rbx,%rax
  1004ee:	5b                   	pop    %rbx
  1004ef:	41 5c                	pop    %r12
  1004f1:	5d                   	pop    %rbp
  1004f2:	c3                   	ret    

00000000001004f3 <realloc>:
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz) {
  1004f3:	55                   	push   %rbp
  1004f4:	48 89 e5             	mov    %rsp,%rbp
  1004f7:	41 55                	push   %r13
  1004f9:	41 54                	push   %r12
  1004fb:	53                   	push   %rbx
  1004fc:	48 83 ec 08          	sub    $0x8,%rsp
  100500:	48 89 fb             	mov    %rdi,%rbx
  100503:	48 89 f7             	mov    %rsi,%rdi
    // Corner case: ptr is NULL, ptr provided but sz is 0
    if (ptr == NULL)
  100506:	48 85 db             	test   %rbx,%rbx
  100509:	74 38                	je     100543 <realloc+0x50>
    {
        return malloc(sz);
    }
    if (ptr && (sz == 0))
  10050b:	48 85 f6             	test   %rsi,%rsi
  10050e:	74 3d                	je     10054d <realloc+0x5a>
    }
    // Get head of memory block
    header* head = (header*)(((intptr_t) ptr) - ((intptr_t) HEADER_SIZE));
    
    // Allocate new, larger/smaller memory
    void* ret = malloc(sz);
  100510:	e8 a2 fe ff ff       	call   1003b7 <malloc>
  100515:	49 89 c4             	mov    %rax,%r12
    if (ret == ((void*) -1))
  100518:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  10051c:	74 3f                	je     10055d <realloc+0x6a>
    {
        // Error while allocating new memory block
        return NULL;
    }
    // Transfer data from old mem block to new mem block
    memcpy(ret, ptr, ((size_t) head->size));
  10051e:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  100522:	48 89 de             	mov    %rbx,%rsi
  100525:	48 89 c7             	mov    %rax,%rdi
  100528:	e8 f9 01 00 00       	call   100726 <memcpy>
    // Push old block to free_list
    free((header*) ptr);
  10052d:	48 89 df             	mov    %rbx,%rdi
  100530:	e8 52 fe ff ff       	call   100387 <free>
        
    return ret;
}
  100535:	4c 89 e0             	mov    %r12,%rax
  100538:	48 83 c4 08          	add    $0x8,%rsp
  10053c:	5b                   	pop    %rbx
  10053d:	41 5c                	pop    %r12
  10053f:	41 5d                	pop    %r13
  100541:	5d                   	pop    %rbp
  100542:	c3                   	ret    
        return malloc(sz);
  100543:	e8 6f fe ff ff       	call   1003b7 <malloc>
  100548:	49 89 c4             	mov    %rax,%r12
  10054b:	eb e8                	jmp    100535 <realloc+0x42>
        free(ptr);
  10054d:	48 89 df             	mov    %rbx,%rdi
  100550:	e8 32 fe ff ff       	call   100387 <free>
        return NULL;
  100555:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10055b:	eb d8                	jmp    100535 <realloc+0x42>
        return NULL;
  10055d:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100563:	eb d0                	jmp    100535 <realloc+0x42>

0000000000100565 <defrag>:
 * 3. Merge with left block if it's free
 * 4. Merge with both left and right blocks if both are free
*/
void defrag() {

}
  100565:	c3                   	ret    

0000000000100566 <heap_info>:
// the user, i.e. the process will be responsible for freeing these allocations
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info) {
  100566:	55                   	push   %rbp
  100567:	48 89 e5             	mov    %rsp,%rbp
  10056a:	41 57                	push   %r15
  10056c:	41 56                	push   %r14
  10056e:	41 55                	push   %r13
  100570:	41 54                	push   %r12
  100572:	53                   	push   %rbx
  100573:	48 83 ec 18          	sub    $0x18,%rsp
  100577:	49 89 ff             	mov    %rdi,%r15
    int debug = 0;
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
    // Find "largest_free_chunk", "free_space" from free_list
    header* temp = free_list;
  10057a:	48 8b 05 af 1a 00 00 	mov    0x1aaf(%rip),%rax        # 102030 <free_list>
    while (temp != NULL)
  100581:	48 85 c0             	test   %rax,%rax
  100584:	74 2f                	je     1005b5 <heap_info+0x4f>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  100586:	41 be 00 00 00 00    	mov    $0x0,%r14d
  10058c:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100592:	eb 08                	jmp    10059c <heap_info+0x36>
            if (temp->size > ((uint64_t)largest_free_chunk))
            {
                largest_free_chunk = temp->size;
            }
        }
        temp = temp->next;
  100594:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  100597:	48 85 c0             	test   %rax,%rax
  10059a:	74 25                	je     1005c1 <heap_info+0x5b>
        if (temp->alloc == 0)
  10059c:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  1005a0:	75 f2                	jne    100594 <heap_info+0x2e>
            free_space += temp->size;
  1005a2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1005a6:	41 01 d6             	add    %edx,%r14d
            if (temp->size > ((uint64_t)largest_free_chunk))
  1005a9:	49 63 cd             	movslq %r13d,%rcx
                largest_free_chunk = temp->size;
  1005ac:	48 39 d1             	cmp    %rdx,%rcx
  1005af:	44 0f 42 ea          	cmovb  %edx,%r13d
  1005b3:	eb df                	jmp    100594 <heap_info+0x2e>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  1005b5:	41 be 00 00 00 00    	mov    $0x0,%r14d
  1005bb:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    }
    // Find "num_allocs" from malloc_list
    temp = malloc_list;
  1005c1:	48 8b 05 50 1a 00 00 	mov    0x1a50(%rip),%rax        # 102018 <malloc_list>
    while (temp != NULL)
  1005c8:	48 85 c0             	test   %rax,%rax
  1005cb:	0f 84 c8 00 00 00    	je     100699 <heap_info+0x133>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  1005d1:	bb 00 00 00 00       	mov    $0x0,%ebx
  1005d6:	eb 09                	jmp    1005e1 <heap_info+0x7b>
        // Ensure block has not been freed
        if (temp->alloc == 1)
        {
            num_allocs ++;
        }
        temp = temp->next_alloc_block;
  1005d8:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL)
  1005dc:	48 85 c0             	test   %rax,%rax
  1005df:	74 0b                	je     1005ec <heap_info+0x86>
        if (temp->alloc == 1)
  1005e1:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  1005e5:	75 f1                	jne    1005d8 <heap_info+0x72>
            num_allocs ++;
  1005e7:	83 c3 01             	add    $0x1,%ebx
  1005ea:	eb ec                	jmp    1005d8 <heap_info+0x72>
    }
    // Create ptr_array (list of pointers to memory block headers)
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  1005ec:	48 63 c3             	movslq %ebx,%rax
  1005ef:	48 c1 e0 03          	shl    $0x3,%rax
  1005f3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  1005f7:	48 89 c7             	mov    %rax,%rdi
  1005fa:	e8 b8 fd ff ff       	call   1003b7 <malloc>
  1005ff:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  100602:	48 85 c0             	test   %rax,%rax
  100605:	74 63                	je     10066a <heap_info+0x104>
    {
        return -1;
    }
    int count = 0;
    // Reinitialize "temp"
    temp = malloc_list;
  100607:	48 8b 05 0a 1a 00 00 	mov    0x1a0a(%rip),%rax        # 102018 <malloc_list>
    while (temp != NULL && (count < num_allocs))
  10060e:	48 85 c0             	test   %rax,%rax
  100611:	74 32                	je     100645 <heap_info+0xdf>
  100613:	85 db                	test   %ebx,%ebx
  100615:	7e 2e                	jle    100645 <heap_info+0xdf>
    int count = 0;
  100617:	ba 00 00 00 00       	mov    $0x0,%edx
  10061c:	eb 15                	jmp    100633 <heap_info+0xcd>
        if (temp->alloc == 1)
        {
            ptr_array[count] = temp;
            count += 1;
        }
        temp = temp->next_alloc_block;
  10061e:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL && (count < num_allocs))
  100622:	48 85 c0             	test   %rax,%rax
  100625:	0f 84 a3 00 00 00    	je     1006ce <heap_info+0x168>
  10062b:	39 d3                	cmp    %edx,%ebx
  10062d:	0f 8e 9b 00 00 00    	jle    1006ce <heap_info+0x168>
        if (temp->alloc == 1)
  100633:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  100637:	75 e5                	jne    10061e <heap_info+0xb8>
            ptr_array[count] = temp;
  100639:	48 63 ca             	movslq %edx,%rcx
  10063c:	49 89 04 cc          	mov    %rax,(%r12,%rcx,8)
            count += 1;
  100640:	83 c2 01             	add    $0x1,%edx
  100643:	eb d9                	jmp    10061e <heap_info+0xb8>
    }
    // Sort ptr_array in descending order
    merge_sort(ptr_array, num_allocs);
  100645:	89 de                	mov    %ebx,%esi
  100647:	4c 89 e7             	mov    %r12,%rdi
  10064a:	e8 3f fc ff ff       	call   10028e <merge_sort>
    // Create "size_array"
    long* size_array = malloc(sizeof(long) * num_allocs);
  10064f:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100653:	e8 5f fd ff ff       	call   1003b7 <malloc>
    if (size_array == NULL)
  100658:	48 85 c0             	test   %rax,%rax
  10065b:	74 17                	je     100674 <heap_info+0x10e>
    {
        return -1;
    }
    for(int i = 0; i < num_allocs; i++)
  10065d:	85 db                	test   %ebx,%ebx
  10065f:	0f 8f 81 00 00 00    	jg     1006e6 <heap_info+0x180>
  100665:	e9 95 00 00 00       	jmp    1006ff <heap_info+0x199>
        return -1;
  10066a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10066f:	e9 a3 00 00 00       	jmp    100717 <heap_info+0x1b1>
        return -1;
  100674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100679:	e9 99 00 00 00       	jmp    100717 <heap_info+0x1b1>
        return -1;
  10067e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100683:	e9 8f 00 00 00       	jmp    100717 <heap_info+0x1b1>
        return -1;
  100688:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10068d:	e9 85 00 00 00       	jmp    100717 <heap_info+0x1b1>
  100692:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100697:	eb 7e                	jmp    100717 <heap_info+0x1b1>
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  100699:	bf 00 00 00 00       	mov    $0x0,%edi
  10069e:	e8 14 fd ff ff       	call   1003b7 <malloc>
  1006a3:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  1006a6:	48 85 c0             	test   %rax,%rax
  1006a9:	74 d3                	je     10067e <heap_info+0x118>
    merge_sort(ptr_array, num_allocs);
  1006ab:	be 00 00 00 00       	mov    $0x0,%esi
  1006b0:	48 89 c7             	mov    %rax,%rdi
  1006b3:	e8 d6 fb ff ff       	call   10028e <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  1006b8:	bf 00 00 00 00       	mov    $0x0,%edi
  1006bd:	e8 f5 fc ff ff       	call   1003b7 <malloc>
    if (size_array == NULL)
  1006c2:	48 85 c0             	test   %rax,%rax
  1006c5:	74 cb                	je     100692 <heap_info+0x12c>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  1006c7:	bb 00 00 00 00       	mov    $0x0,%ebx
  1006cc:	eb 31                	jmp    1006ff <heap_info+0x199>
    merge_sort(ptr_array, num_allocs);
  1006ce:	89 de                	mov    %ebx,%esi
  1006d0:	4c 89 e7             	mov    %r12,%rdi
  1006d3:	e8 b6 fb ff ff       	call   10028e <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  1006d8:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  1006dc:	e8 d6 fc ff ff       	call   1003b7 <malloc>
    if (size_array == NULL)
  1006e1:	48 85 c0             	test   %rax,%rax
  1006e4:	74 a2                	je     100688 <heap_info+0x122>
    int count = 0;
  1006e6:	ba 00 00 00 00       	mov    $0x0,%edx
    {
        size_array[i] = (long)ptr_array[i]->size;
  1006eb:	49 8b 0c d4          	mov    (%r12,%rdx,8),%rcx
  1006ef:	48 8b 49 10          	mov    0x10(%rcx),%rcx
  1006f3:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    for(int i = 0; i < num_allocs; i++)
  1006f7:	48 83 c2 01          	add    $0x1,%rdx
  1006fb:	39 d3                	cmp    %edx,%ebx
  1006fd:	7f ec                	jg     1006eb <heap_info+0x185>
    }
    // Assign values to heap_info_struct
    info->num_allocs = num_allocs;
  1006ff:	41 89 1f             	mov    %ebx,(%r15)
    info->size_array = size_array;
  100702:	49 89 47 08          	mov    %rax,0x8(%r15)
    info->ptr_array = (void**)ptr_array;
  100706:	4d 89 67 10          	mov    %r12,0x10(%r15)
    info->free_space = free_space;
  10070a:	45 89 77 18          	mov    %r14d,0x18(%r15)
    info->largest_free_chunk = largest_free_chunk;
  10070e:	45 89 6f 1c          	mov    %r13d,0x1c(%r15)
    return 0;
  100712:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100717:	48 83 c4 18          	add    $0x18,%rsp
  10071b:	5b                   	pop    %rbx
  10071c:	41 5c                	pop    %r12
  10071e:	41 5d                	pop    %r13
  100720:	41 5e                	pop    %r14
  100722:	41 5f                	pop    %r15
  100724:	5d                   	pop    %rbp
  100725:	c3                   	ret    

0000000000100726 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100726:	55                   	push   %rbp
  100727:	48 89 e5             	mov    %rsp,%rbp
  10072a:	48 83 ec 28          	sub    $0x28,%rsp
  10072e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100732:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100736:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10073a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10073e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100742:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100746:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10074a:	eb 1c                	jmp    100768 <memcpy+0x42>
        *d = *s;
  10074c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100750:	0f b6 10             	movzbl (%rax),%edx
  100753:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100757:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100759:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10075e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100763:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100768:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10076d:	75 dd                	jne    10074c <memcpy+0x26>
    }
    return dst;
  10076f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100773:	c9                   	leave  
  100774:	c3                   	ret    

0000000000100775 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100775:	55                   	push   %rbp
  100776:	48 89 e5             	mov    %rsp,%rbp
  100779:	48 83 ec 28          	sub    $0x28,%rsp
  10077d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100781:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100785:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100789:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10078d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  100791:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100795:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100799:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10079d:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1007a1:	73 6a                	jae    10080d <memmove+0x98>
  1007a3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1007a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007ab:	48 01 d0             	add    %rdx,%rax
  1007ae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1007b2:	73 59                	jae    10080d <memmove+0x98>
        s += n, d += n;
  1007b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007b8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1007bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007c0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1007c4:	eb 17                	jmp    1007dd <memmove+0x68>
            *--d = *--s;
  1007c6:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1007cb:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1007d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007d4:	0f b6 10             	movzbl (%rax),%edx
  1007d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1007db:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1007dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1007e1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1007e5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1007e9:	48 85 c0             	test   %rax,%rax
  1007ec:	75 d8                	jne    1007c6 <memmove+0x51>
    if (s < d && s + n > d) {
  1007ee:	eb 2e                	jmp    10081e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  1007f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1007f4:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1007f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1007fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100800:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100804:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100808:	0f b6 12             	movzbl (%rdx),%edx
  10080b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10080d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100811:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100815:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100819:	48 85 c0             	test   %rax,%rax
  10081c:	75 d2                	jne    1007f0 <memmove+0x7b>
        }
    }
    return dst;
  10081e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100822:	c9                   	leave  
  100823:	c3                   	ret    

0000000000100824 <memset>:

void* memset(void* v, int c, size_t n) {
  100824:	55                   	push   %rbp
  100825:	48 89 e5             	mov    %rsp,%rbp
  100828:	48 83 ec 28          	sub    $0x28,%rsp
  10082c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100830:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100833:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100837:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10083b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10083f:	eb 15                	jmp    100856 <memset+0x32>
        *p = c;
  100841:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100844:	89 c2                	mov    %eax,%edx
  100846:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10084a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10084c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100851:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100856:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10085b:	75 e4                	jne    100841 <memset+0x1d>
    }
    return v;
  10085d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100861:	c9                   	leave  
  100862:	c3                   	ret    

0000000000100863 <strlen>:

size_t strlen(const char* s) {
  100863:	55                   	push   %rbp
  100864:	48 89 e5             	mov    %rsp,%rbp
  100867:	48 83 ec 18          	sub    $0x18,%rsp
  10086b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10086f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100876:	00 
  100877:	eb 0a                	jmp    100883 <strlen+0x20>
        ++n;
  100879:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10087e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100883:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100887:	0f b6 00             	movzbl (%rax),%eax
  10088a:	84 c0                	test   %al,%al
  10088c:	75 eb                	jne    100879 <strlen+0x16>
    }
    return n;
  10088e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100892:	c9                   	leave  
  100893:	c3                   	ret    

0000000000100894 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100894:	55                   	push   %rbp
  100895:	48 89 e5             	mov    %rsp,%rbp
  100898:	48 83 ec 20          	sub    $0x20,%rsp
  10089c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1008a0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1008a4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1008ab:	00 
  1008ac:	eb 0a                	jmp    1008b8 <strnlen+0x24>
        ++n;
  1008ae:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1008b3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1008b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008bc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1008c0:	74 0b                	je     1008cd <strnlen+0x39>
  1008c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008c6:	0f b6 00             	movzbl (%rax),%eax
  1008c9:	84 c0                	test   %al,%al
  1008cb:	75 e1                	jne    1008ae <strnlen+0x1a>
    }
    return n;
  1008cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1008d1:	c9                   	leave  
  1008d2:	c3                   	ret    

00000000001008d3 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1008d3:	55                   	push   %rbp
  1008d4:	48 89 e5             	mov    %rsp,%rbp
  1008d7:	48 83 ec 20          	sub    $0x20,%rsp
  1008db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1008df:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1008e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1008e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1008eb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1008ef:	48 8d 42 01          	lea    0x1(%rdx),%rax
  1008f3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  1008f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1008ff:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100903:	0f b6 12             	movzbl (%rdx),%edx
  100906:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100908:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10090c:	48 83 e8 01          	sub    $0x1,%rax
  100910:	0f b6 00             	movzbl (%rax),%eax
  100913:	84 c0                	test   %al,%al
  100915:	75 d4                	jne    1008eb <strcpy+0x18>
    return dst;
  100917:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10091b:	c9                   	leave  
  10091c:	c3                   	ret    

000000000010091d <strcmp>:

int strcmp(const char* a, const char* b) {
  10091d:	55                   	push   %rbp
  10091e:	48 89 e5             	mov    %rsp,%rbp
  100921:	48 83 ec 10          	sub    $0x10,%rsp
  100925:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100929:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10092d:	eb 0a                	jmp    100939 <strcmp+0x1c>
        ++a, ++b;
  10092f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100934:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100939:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10093d:	0f b6 00             	movzbl (%rax),%eax
  100940:	84 c0                	test   %al,%al
  100942:	74 1d                	je     100961 <strcmp+0x44>
  100944:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100948:	0f b6 00             	movzbl (%rax),%eax
  10094b:	84 c0                	test   %al,%al
  10094d:	74 12                	je     100961 <strcmp+0x44>
  10094f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100953:	0f b6 10             	movzbl (%rax),%edx
  100956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10095a:	0f b6 00             	movzbl (%rax),%eax
  10095d:	38 c2                	cmp    %al,%dl
  10095f:	74 ce                	je     10092f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100965:	0f b6 00             	movzbl (%rax),%eax
  100968:	89 c2                	mov    %eax,%edx
  10096a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10096e:	0f b6 00             	movzbl (%rax),%eax
  100971:	38 d0                	cmp    %dl,%al
  100973:	0f 92 c0             	setb   %al
  100976:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10097d:	0f b6 00             	movzbl (%rax),%eax
  100980:	89 c1                	mov    %eax,%ecx
  100982:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100986:	0f b6 00             	movzbl (%rax),%eax
  100989:	38 c1                	cmp    %al,%cl
  10098b:	0f 92 c0             	setb   %al
  10098e:	0f b6 c0             	movzbl %al,%eax
  100991:	29 c2                	sub    %eax,%edx
  100993:	89 d0                	mov    %edx,%eax
}
  100995:	c9                   	leave  
  100996:	c3                   	ret    

0000000000100997 <strchr>:

char* strchr(const char* s, int c) {
  100997:	55                   	push   %rbp
  100998:	48 89 e5             	mov    %rsp,%rbp
  10099b:	48 83 ec 10          	sub    $0x10,%rsp
  10099f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1009a3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1009a6:	eb 05                	jmp    1009ad <strchr+0x16>
        ++s;
  1009a8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1009ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009b1:	0f b6 00             	movzbl (%rax),%eax
  1009b4:	84 c0                	test   %al,%al
  1009b6:	74 0e                	je     1009c6 <strchr+0x2f>
  1009b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009bc:	0f b6 00             	movzbl (%rax),%eax
  1009bf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1009c2:	38 d0                	cmp    %dl,%al
  1009c4:	75 e2                	jne    1009a8 <strchr+0x11>
    }
    if (*s == (char) c) {
  1009c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009ca:	0f b6 00             	movzbl (%rax),%eax
  1009cd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1009d0:	38 d0                	cmp    %dl,%al
  1009d2:	75 06                	jne    1009da <strchr+0x43>
        return (char*) s;
  1009d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009d8:	eb 05                	jmp    1009df <strchr+0x48>
    } else {
        return NULL;
  1009da:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1009df:	c9                   	leave  
  1009e0:	c3                   	ret    

00000000001009e1 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1009e5:	8b 05 4d 16 00 00    	mov    0x164d(%rip),%eax        # 102038 <rand_seed_set>
  1009eb:	85 c0                	test   %eax,%eax
  1009ed:	75 0a                	jne    1009f9 <rand+0x18>
        srand(819234718U);
  1009ef:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  1009f4:	e8 24 00 00 00       	call   100a1d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1009f9:	8b 05 3d 16 00 00    	mov    0x163d(%rip),%eax        # 10203c <rand_seed>
  1009ff:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100a05:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100a0a:	89 05 2c 16 00 00    	mov    %eax,0x162c(%rip)        # 10203c <rand_seed>
    return rand_seed & RAND_MAX;
  100a10:	8b 05 26 16 00 00    	mov    0x1626(%rip),%eax        # 10203c <rand_seed>
  100a16:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100a1b:	5d                   	pop    %rbp
  100a1c:	c3                   	ret    

0000000000100a1d <srand>:

void srand(unsigned seed) {
  100a1d:	55                   	push   %rbp
  100a1e:	48 89 e5             	mov    %rsp,%rbp
  100a21:	48 83 ec 08          	sub    $0x8,%rsp
  100a25:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100a28:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100a2b:	89 05 0b 16 00 00    	mov    %eax,0x160b(%rip)        # 10203c <rand_seed>
    rand_seed_set = 1;
  100a31:	c7 05 fd 15 00 00 01 	movl   $0x1,0x15fd(%rip)        # 102038 <rand_seed_set>
  100a38:	00 00 00 
}
  100a3b:	90                   	nop
  100a3c:	c9                   	leave  
  100a3d:	c3                   	ret    

0000000000100a3e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100a3e:	55                   	push   %rbp
  100a3f:	48 89 e5             	mov    %rsp,%rbp
  100a42:	48 83 ec 28          	sub    $0x28,%rsp
  100a46:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a4a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100a4e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100a51:	48 c7 45 f8 60 19 10 	movq   $0x101960,-0x8(%rbp)
  100a58:	00 
    if (base < 0) {
  100a59:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100a5d:	79 0b                	jns    100a6a <fill_numbuf+0x2c>
        digits = lower_digits;
  100a5f:	48 c7 45 f8 80 19 10 	movq   $0x101980,-0x8(%rbp)
  100a66:	00 
        base = -base;
  100a67:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100a6a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100a6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a73:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100a76:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100a79:	48 63 c8             	movslq %eax,%rcx
  100a7c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a80:	ba 00 00 00 00       	mov    $0x0,%edx
  100a85:	48 f7 f1             	div    %rcx
  100a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a8c:	48 01 d0             	add    %rdx,%rax
  100a8f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100a94:	0f b6 10             	movzbl (%rax),%edx
  100a97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a9b:	88 10                	mov    %dl,(%rax)
        val /= base;
  100a9d:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100aa0:	48 63 f0             	movslq %eax,%rsi
  100aa3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100aa7:	ba 00 00 00 00       	mov    $0x0,%edx
  100aac:	48 f7 f6             	div    %rsi
  100aaf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100ab3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100ab8:	75 bc                	jne    100a76 <fill_numbuf+0x38>
    return numbuf_end;
  100aba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100abe:	c9                   	leave  
  100abf:	c3                   	ret    

0000000000100ac0 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100ac0:	55                   	push   %rbp
  100ac1:	48 89 e5             	mov    %rsp,%rbp
  100ac4:	53                   	push   %rbx
  100ac5:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100acc:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100ad3:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100ad9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100ae0:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100ae7:	e9 8a 09 00 00       	jmp    101476 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100aec:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100af3:	0f b6 00             	movzbl (%rax),%eax
  100af6:	3c 25                	cmp    $0x25,%al
  100af8:	74 31                	je     100b2b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100afa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100b01:	4c 8b 00             	mov    (%rax),%r8
  100b04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b0b:	0f b6 00             	movzbl (%rax),%eax
  100b0e:	0f b6 c8             	movzbl %al,%ecx
  100b11:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100b17:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100b1e:	89 ce                	mov    %ecx,%esi
  100b20:	48 89 c7             	mov    %rax,%rdi
  100b23:	41 ff d0             	call   *%r8
            continue;
  100b26:	e9 43 09 00 00       	jmp    10146e <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100b2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100b32:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b39:	01 
  100b3a:	eb 44                	jmp    100b80 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100b3c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b43:	0f b6 00             	movzbl (%rax),%eax
  100b46:	0f be c0             	movsbl %al,%eax
  100b49:	89 c6                	mov    %eax,%esi
  100b4b:	bf 80 17 10 00       	mov    $0x101780,%edi
  100b50:	e8 42 fe ff ff       	call   100997 <strchr>
  100b55:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100b59:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100b5e:	74 30                	je     100b90 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100b60:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100b64:	48 2d 80 17 10 00    	sub    $0x101780,%rax
  100b6a:	ba 01 00 00 00       	mov    $0x1,%edx
  100b6f:	89 c1                	mov    %eax,%ecx
  100b71:	d3 e2                	shl    %cl,%edx
  100b73:	89 d0                	mov    %edx,%eax
  100b75:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100b78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b7f:	01 
  100b80:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b87:	0f b6 00             	movzbl (%rax),%eax
  100b8a:	84 c0                	test   %al,%al
  100b8c:	75 ae                	jne    100b3c <printer_vprintf+0x7c>
  100b8e:	eb 01                	jmp    100b91 <printer_vprintf+0xd1>
            } else {
                break;
  100b90:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100b91:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100b98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b9f:	0f b6 00             	movzbl (%rax),%eax
  100ba2:	3c 30                	cmp    $0x30,%al
  100ba4:	7e 67                	jle    100c0d <printer_vprintf+0x14d>
  100ba6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bad:	0f b6 00             	movzbl (%rax),%eax
  100bb0:	3c 39                	cmp    $0x39,%al
  100bb2:	7f 59                	jg     100c0d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100bb4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100bbb:	eb 2e                	jmp    100beb <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100bbd:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100bc0:	89 d0                	mov    %edx,%eax
  100bc2:	c1 e0 02             	shl    $0x2,%eax
  100bc5:	01 d0                	add    %edx,%eax
  100bc7:	01 c0                	add    %eax,%eax
  100bc9:	89 c1                	mov    %eax,%ecx
  100bcb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bd2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100bd6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100bdd:	0f b6 00             	movzbl (%rax),%eax
  100be0:	0f be c0             	movsbl %al,%eax
  100be3:	01 c8                	add    %ecx,%eax
  100be5:	83 e8 30             	sub    $0x30,%eax
  100be8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100beb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bf2:	0f b6 00             	movzbl (%rax),%eax
  100bf5:	3c 2f                	cmp    $0x2f,%al
  100bf7:	0f 8e 85 00 00 00    	jle    100c82 <printer_vprintf+0x1c2>
  100bfd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c04:	0f b6 00             	movzbl (%rax),%eax
  100c07:	3c 39                	cmp    $0x39,%al
  100c09:	7e b2                	jle    100bbd <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100c0b:	eb 75                	jmp    100c82 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100c0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c14:	0f b6 00             	movzbl (%rax),%eax
  100c17:	3c 2a                	cmp    $0x2a,%al
  100c19:	75 68                	jne    100c83 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100c1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c22:	8b 00                	mov    (%rax),%eax
  100c24:	83 f8 2f             	cmp    $0x2f,%eax
  100c27:	77 30                	ja     100c59 <printer_vprintf+0x199>
  100c29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c30:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3b:	8b 00                	mov    (%rax),%eax
  100c3d:	89 c0                	mov    %eax,%eax
  100c3f:	48 01 d0             	add    %rdx,%rax
  100c42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c49:	8b 12                	mov    (%rdx),%edx
  100c4b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c55:	89 0a                	mov    %ecx,(%rdx)
  100c57:	eb 1a                	jmp    100c73 <printer_vprintf+0x1b3>
  100c59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c60:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c64:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c68:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c6f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c73:	8b 00                	mov    (%rax),%eax
  100c75:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100c78:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c7f:	01 
  100c80:	eb 01                	jmp    100c83 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100c82:	90                   	nop
        }

        // process precision
        int precision = -1;
  100c83:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100c8a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c91:	0f b6 00             	movzbl (%rax),%eax
  100c94:	3c 2e                	cmp    $0x2e,%al
  100c96:	0f 85 00 01 00 00    	jne    100d9c <printer_vprintf+0x2dc>
            ++format;
  100c9c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ca3:	01 
            if (*format >= '0' && *format <= '9') {
  100ca4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cab:	0f b6 00             	movzbl (%rax),%eax
  100cae:	3c 2f                	cmp    $0x2f,%al
  100cb0:	7e 67                	jle    100d19 <printer_vprintf+0x259>
  100cb2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cb9:	0f b6 00             	movzbl (%rax),%eax
  100cbc:	3c 39                	cmp    $0x39,%al
  100cbe:	7f 59                	jg     100d19 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100cc0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100cc7:	eb 2e                	jmp    100cf7 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100cc9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100ccc:	89 d0                	mov    %edx,%eax
  100cce:	c1 e0 02             	shl    $0x2,%eax
  100cd1:	01 d0                	add    %edx,%eax
  100cd3:	01 c0                	add    %eax,%eax
  100cd5:	89 c1                	mov    %eax,%ecx
  100cd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cde:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ce2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100ce9:	0f b6 00             	movzbl (%rax),%eax
  100cec:	0f be c0             	movsbl %al,%eax
  100cef:	01 c8                	add    %ecx,%eax
  100cf1:	83 e8 30             	sub    $0x30,%eax
  100cf4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100cf7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cfe:	0f b6 00             	movzbl (%rax),%eax
  100d01:	3c 2f                	cmp    $0x2f,%al
  100d03:	0f 8e 85 00 00 00    	jle    100d8e <printer_vprintf+0x2ce>
  100d09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d10:	0f b6 00             	movzbl (%rax),%eax
  100d13:	3c 39                	cmp    $0x39,%al
  100d15:	7e b2                	jle    100cc9 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100d17:	eb 75                	jmp    100d8e <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100d19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d20:	0f b6 00             	movzbl (%rax),%eax
  100d23:	3c 2a                	cmp    $0x2a,%al
  100d25:	75 68                	jne    100d8f <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100d27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d2e:	8b 00                	mov    (%rax),%eax
  100d30:	83 f8 2f             	cmp    $0x2f,%eax
  100d33:	77 30                	ja     100d65 <printer_vprintf+0x2a5>
  100d35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d3c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d47:	8b 00                	mov    (%rax),%eax
  100d49:	89 c0                	mov    %eax,%eax
  100d4b:	48 01 d0             	add    %rdx,%rax
  100d4e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d55:	8b 12                	mov    (%rdx),%edx
  100d57:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d5a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d61:	89 0a                	mov    %ecx,(%rdx)
  100d63:	eb 1a                	jmp    100d7f <printer_vprintf+0x2bf>
  100d65:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d70:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d74:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d7b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d7f:	8b 00                	mov    (%rax),%eax
  100d81:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100d84:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d8b:	01 
  100d8c:	eb 01                	jmp    100d8f <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100d8e:	90                   	nop
            }
            if (precision < 0) {
  100d8f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100d93:	79 07                	jns    100d9c <printer_vprintf+0x2dc>
                precision = 0;
  100d95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100d9c:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100da3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100daa:	00 
        int length = 0;
  100dab:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100db2:	48 c7 45 c8 86 17 10 	movq   $0x101786,-0x38(%rbp)
  100db9:	00 
    again:
        switch (*format) {
  100dba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dc1:	0f b6 00             	movzbl (%rax),%eax
  100dc4:	0f be c0             	movsbl %al,%eax
  100dc7:	83 e8 43             	sub    $0x43,%eax
  100dca:	83 f8 37             	cmp    $0x37,%eax
  100dcd:	0f 87 9f 03 00 00    	ja     101172 <printer_vprintf+0x6b2>
  100dd3:	89 c0                	mov    %eax,%eax
  100dd5:	48 8b 04 c5 98 17 10 	mov    0x101798(,%rax,8),%rax
  100ddc:	00 
  100ddd:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100ddf:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100de6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100ded:	01 
            goto again;
  100dee:	eb ca                	jmp    100dba <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100df0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100df4:	74 5d                	je     100e53 <printer_vprintf+0x393>
  100df6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100dfd:	8b 00                	mov    (%rax),%eax
  100dff:	83 f8 2f             	cmp    $0x2f,%eax
  100e02:	77 30                	ja     100e34 <printer_vprintf+0x374>
  100e04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e0b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e16:	8b 00                	mov    (%rax),%eax
  100e18:	89 c0                	mov    %eax,%eax
  100e1a:	48 01 d0             	add    %rdx,%rax
  100e1d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e24:	8b 12                	mov    (%rdx),%edx
  100e26:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e30:	89 0a                	mov    %ecx,(%rdx)
  100e32:	eb 1a                	jmp    100e4e <printer_vprintf+0x38e>
  100e34:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e3b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e3f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e4a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e4e:	48 8b 00             	mov    (%rax),%rax
  100e51:	eb 5c                	jmp    100eaf <printer_vprintf+0x3ef>
  100e53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e5a:	8b 00                	mov    (%rax),%eax
  100e5c:	83 f8 2f             	cmp    $0x2f,%eax
  100e5f:	77 30                	ja     100e91 <printer_vprintf+0x3d1>
  100e61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e68:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e73:	8b 00                	mov    (%rax),%eax
  100e75:	89 c0                	mov    %eax,%eax
  100e77:	48 01 d0             	add    %rdx,%rax
  100e7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e81:	8b 12                	mov    (%rdx),%edx
  100e83:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e8d:	89 0a                	mov    %ecx,(%rdx)
  100e8f:	eb 1a                	jmp    100eab <printer_vprintf+0x3eb>
  100e91:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e98:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e9c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ea0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ea7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100eab:	8b 00                	mov    (%rax),%eax
  100ead:	48 98                	cltq   
  100eaf:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100eb3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100eb7:	48 c1 f8 38          	sar    $0x38,%rax
  100ebb:	25 80 00 00 00       	and    $0x80,%eax
  100ec0:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100ec3:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100ec7:	74 09                	je     100ed2 <printer_vprintf+0x412>
  100ec9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ecd:	48 f7 d8             	neg    %rax
  100ed0:	eb 04                	jmp    100ed6 <printer_vprintf+0x416>
  100ed2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ed6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100eda:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100edd:	83 c8 60             	or     $0x60,%eax
  100ee0:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100ee3:	e9 cf 02 00 00       	jmp    1011b7 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100ee8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100eec:	74 5d                	je     100f4b <printer_vprintf+0x48b>
  100eee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ef5:	8b 00                	mov    (%rax),%eax
  100ef7:	83 f8 2f             	cmp    $0x2f,%eax
  100efa:	77 30                	ja     100f2c <printer_vprintf+0x46c>
  100efc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f03:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f0e:	8b 00                	mov    (%rax),%eax
  100f10:	89 c0                	mov    %eax,%eax
  100f12:	48 01 d0             	add    %rdx,%rax
  100f15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f1c:	8b 12                	mov    (%rdx),%edx
  100f1e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f28:	89 0a                	mov    %ecx,(%rdx)
  100f2a:	eb 1a                	jmp    100f46 <printer_vprintf+0x486>
  100f2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f33:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f37:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f3b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f42:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f46:	48 8b 00             	mov    (%rax),%rax
  100f49:	eb 5c                	jmp    100fa7 <printer_vprintf+0x4e7>
  100f4b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f52:	8b 00                	mov    (%rax),%eax
  100f54:	83 f8 2f             	cmp    $0x2f,%eax
  100f57:	77 30                	ja     100f89 <printer_vprintf+0x4c9>
  100f59:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f60:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f64:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f6b:	8b 00                	mov    (%rax),%eax
  100f6d:	89 c0                	mov    %eax,%eax
  100f6f:	48 01 d0             	add    %rdx,%rax
  100f72:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f79:	8b 12                	mov    (%rdx),%edx
  100f7b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f85:	89 0a                	mov    %ecx,(%rdx)
  100f87:	eb 1a                	jmp    100fa3 <printer_vprintf+0x4e3>
  100f89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f90:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f94:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f98:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f9f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fa3:	8b 00                	mov    (%rax),%eax
  100fa5:	89 c0                	mov    %eax,%eax
  100fa7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100fab:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100faf:	e9 03 02 00 00       	jmp    1011b7 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100fb4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100fbb:	e9 28 ff ff ff       	jmp    100ee8 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100fc0:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100fc7:	e9 1c ff ff ff       	jmp    100ee8 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100fcc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fd3:	8b 00                	mov    (%rax),%eax
  100fd5:	83 f8 2f             	cmp    $0x2f,%eax
  100fd8:	77 30                	ja     10100a <printer_vprintf+0x54a>
  100fda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fe1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fe5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fec:	8b 00                	mov    (%rax),%eax
  100fee:	89 c0                	mov    %eax,%eax
  100ff0:	48 01 d0             	add    %rdx,%rax
  100ff3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ffa:	8b 12                	mov    (%rdx),%edx
  100ffc:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101006:	89 0a                	mov    %ecx,(%rdx)
  101008:	eb 1a                	jmp    101024 <printer_vprintf+0x564>
  10100a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101011:	48 8b 40 08          	mov    0x8(%rax),%rax
  101015:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101019:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101020:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101024:	48 8b 00             	mov    (%rax),%rax
  101027:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  10102b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  101032:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  101039:	e9 79 01 00 00       	jmp    1011b7 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  10103e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101045:	8b 00                	mov    (%rax),%eax
  101047:	83 f8 2f             	cmp    $0x2f,%eax
  10104a:	77 30                	ja     10107c <printer_vprintf+0x5bc>
  10104c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101053:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101057:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10105e:	8b 00                	mov    (%rax),%eax
  101060:	89 c0                	mov    %eax,%eax
  101062:	48 01 d0             	add    %rdx,%rax
  101065:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10106c:	8b 12                	mov    (%rdx),%edx
  10106e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101071:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101078:	89 0a                	mov    %ecx,(%rdx)
  10107a:	eb 1a                	jmp    101096 <printer_vprintf+0x5d6>
  10107c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101083:	48 8b 40 08          	mov    0x8(%rax),%rax
  101087:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10108b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101092:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101096:	48 8b 00             	mov    (%rax),%rax
  101099:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10109d:	e9 15 01 00 00       	jmp    1011b7 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  1010a2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010a9:	8b 00                	mov    (%rax),%eax
  1010ab:	83 f8 2f             	cmp    $0x2f,%eax
  1010ae:	77 30                	ja     1010e0 <printer_vprintf+0x620>
  1010b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010b7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1010bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010c2:	8b 00                	mov    (%rax),%eax
  1010c4:	89 c0                	mov    %eax,%eax
  1010c6:	48 01 d0             	add    %rdx,%rax
  1010c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010d0:	8b 12                	mov    (%rdx),%edx
  1010d2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1010d5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010dc:	89 0a                	mov    %ecx,(%rdx)
  1010de:	eb 1a                	jmp    1010fa <printer_vprintf+0x63a>
  1010e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010e7:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010eb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010f6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010fa:	8b 00                	mov    (%rax),%eax
  1010fc:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101102:	e9 67 03 00 00       	jmp    10146e <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101107:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10110b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10110f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101116:	8b 00                	mov    (%rax),%eax
  101118:	83 f8 2f             	cmp    $0x2f,%eax
  10111b:	77 30                	ja     10114d <printer_vprintf+0x68d>
  10111d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101124:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101128:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10112f:	8b 00                	mov    (%rax),%eax
  101131:	89 c0                	mov    %eax,%eax
  101133:	48 01 d0             	add    %rdx,%rax
  101136:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10113d:	8b 12                	mov    (%rdx),%edx
  10113f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101142:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101149:	89 0a                	mov    %ecx,(%rdx)
  10114b:	eb 1a                	jmp    101167 <printer_vprintf+0x6a7>
  10114d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101154:	48 8b 40 08          	mov    0x8(%rax),%rax
  101158:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10115c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101163:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101167:	8b 00                	mov    (%rax),%eax
  101169:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10116c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101170:	eb 45                	jmp    1011b7 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101172:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101176:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10117a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101181:	0f b6 00             	movzbl (%rax),%eax
  101184:	84 c0                	test   %al,%al
  101186:	74 0c                	je     101194 <printer_vprintf+0x6d4>
  101188:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10118f:	0f b6 00             	movzbl (%rax),%eax
  101192:	eb 05                	jmp    101199 <printer_vprintf+0x6d9>
  101194:	b8 25 00 00 00       	mov    $0x25,%eax
  101199:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10119c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1011a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1011a7:	0f b6 00             	movzbl (%rax),%eax
  1011aa:	84 c0                	test   %al,%al
  1011ac:	75 08                	jne    1011b6 <printer_vprintf+0x6f6>
                format--;
  1011ae:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1011b5:	01 
            }
            break;
  1011b6:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1011b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ba:	83 e0 20             	and    $0x20,%eax
  1011bd:	85 c0                	test   %eax,%eax
  1011bf:	74 1e                	je     1011df <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1011c1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1011c5:	48 83 c0 18          	add    $0x18,%rax
  1011c9:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1011cc:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1011d0:	48 89 ce             	mov    %rcx,%rsi
  1011d3:	48 89 c7             	mov    %rax,%rdi
  1011d6:	e8 63 f8 ff ff       	call   100a3e <fill_numbuf>
  1011db:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1011df:	48 c7 45 c0 86 17 10 	movq   $0x101786,-0x40(%rbp)
  1011e6:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1011e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011ea:	83 e0 20             	and    $0x20,%eax
  1011ed:	85 c0                	test   %eax,%eax
  1011ef:	74 48                	je     101239 <printer_vprintf+0x779>
  1011f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011f4:	83 e0 40             	and    $0x40,%eax
  1011f7:	85 c0                	test   %eax,%eax
  1011f9:	74 3e                	je     101239 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  1011fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011fe:	25 80 00 00 00       	and    $0x80,%eax
  101203:	85 c0                	test   %eax,%eax
  101205:	74 0a                	je     101211 <printer_vprintf+0x751>
                prefix = "-";
  101207:	48 c7 45 c0 87 17 10 	movq   $0x101787,-0x40(%rbp)
  10120e:	00 
            if (flags & FLAG_NEGATIVE) {
  10120f:	eb 73                	jmp    101284 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101211:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101214:	83 e0 10             	and    $0x10,%eax
  101217:	85 c0                	test   %eax,%eax
  101219:	74 0a                	je     101225 <printer_vprintf+0x765>
                prefix = "+";
  10121b:	48 c7 45 c0 89 17 10 	movq   $0x101789,-0x40(%rbp)
  101222:	00 
            if (flags & FLAG_NEGATIVE) {
  101223:	eb 5f                	jmp    101284 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101225:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101228:	83 e0 08             	and    $0x8,%eax
  10122b:	85 c0                	test   %eax,%eax
  10122d:	74 55                	je     101284 <printer_vprintf+0x7c4>
                prefix = " ";
  10122f:	48 c7 45 c0 8b 17 10 	movq   $0x10178b,-0x40(%rbp)
  101236:	00 
            if (flags & FLAG_NEGATIVE) {
  101237:	eb 4b                	jmp    101284 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101239:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10123c:	83 e0 20             	and    $0x20,%eax
  10123f:	85 c0                	test   %eax,%eax
  101241:	74 42                	je     101285 <printer_vprintf+0x7c5>
  101243:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101246:	83 e0 01             	and    $0x1,%eax
  101249:	85 c0                	test   %eax,%eax
  10124b:	74 38                	je     101285 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10124d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101251:	74 06                	je     101259 <printer_vprintf+0x799>
  101253:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101257:	75 2c                	jne    101285 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101259:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10125e:	75 0c                	jne    10126c <printer_vprintf+0x7ac>
  101260:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101263:	25 00 01 00 00       	and    $0x100,%eax
  101268:	85 c0                	test   %eax,%eax
  10126a:	74 19                	je     101285 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  10126c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101270:	75 07                	jne    101279 <printer_vprintf+0x7b9>
  101272:	b8 8d 17 10 00       	mov    $0x10178d,%eax
  101277:	eb 05                	jmp    10127e <printer_vprintf+0x7be>
  101279:	b8 90 17 10 00       	mov    $0x101790,%eax
  10127e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101282:	eb 01                	jmp    101285 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101284:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101285:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101289:	78 24                	js     1012af <printer_vprintf+0x7ef>
  10128b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10128e:	83 e0 20             	and    $0x20,%eax
  101291:	85 c0                	test   %eax,%eax
  101293:	75 1a                	jne    1012af <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101295:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101298:	48 63 d0             	movslq %eax,%rdx
  10129b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  10129f:	48 89 d6             	mov    %rdx,%rsi
  1012a2:	48 89 c7             	mov    %rax,%rdi
  1012a5:	e8 ea f5 ff ff       	call   100894 <strnlen>
  1012aa:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1012ad:	eb 0f                	jmp    1012be <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1012af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1012b3:	48 89 c7             	mov    %rax,%rdi
  1012b6:	e8 a8 f5 ff ff       	call   100863 <strlen>
  1012bb:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1012be:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012c1:	83 e0 20             	and    $0x20,%eax
  1012c4:	85 c0                	test   %eax,%eax
  1012c6:	74 20                	je     1012e8 <printer_vprintf+0x828>
  1012c8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1012cc:	78 1a                	js     1012e8 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1012ce:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1012d1:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1012d4:	7e 08                	jle    1012de <printer_vprintf+0x81e>
  1012d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1012d9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1012dc:	eb 05                	jmp    1012e3 <printer_vprintf+0x823>
  1012de:	b8 00 00 00 00       	mov    $0x0,%eax
  1012e3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1012e6:	eb 5c                	jmp    101344 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1012e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012eb:	83 e0 20             	and    $0x20,%eax
  1012ee:	85 c0                	test   %eax,%eax
  1012f0:	74 4b                	je     10133d <printer_vprintf+0x87d>
  1012f2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012f5:	83 e0 02             	and    $0x2,%eax
  1012f8:	85 c0                	test   %eax,%eax
  1012fa:	74 41                	je     10133d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  1012fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012ff:	83 e0 04             	and    $0x4,%eax
  101302:	85 c0                	test   %eax,%eax
  101304:	75 37                	jne    10133d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101306:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10130a:	48 89 c7             	mov    %rax,%rdi
  10130d:	e8 51 f5 ff ff       	call   100863 <strlen>
  101312:	89 c2                	mov    %eax,%edx
  101314:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101317:	01 d0                	add    %edx,%eax
  101319:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10131c:	7e 1f                	jle    10133d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10131e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101321:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101324:	89 c3                	mov    %eax,%ebx
  101326:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10132a:	48 89 c7             	mov    %rax,%rdi
  10132d:	e8 31 f5 ff ff       	call   100863 <strlen>
  101332:	89 c2                	mov    %eax,%edx
  101334:	89 d8                	mov    %ebx,%eax
  101336:	29 d0                	sub    %edx,%eax
  101338:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10133b:	eb 07                	jmp    101344 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10133d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101344:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101347:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10134a:	01 d0                	add    %edx,%eax
  10134c:	48 63 d8             	movslq %eax,%rbx
  10134f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101353:	48 89 c7             	mov    %rax,%rdi
  101356:	e8 08 f5 ff ff       	call   100863 <strlen>
  10135b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10135f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101362:	29 d0                	sub    %edx,%eax
  101364:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101367:	eb 25                	jmp    10138e <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101369:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101370:	48 8b 08             	mov    (%rax),%rcx
  101373:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101379:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101380:	be 20 00 00 00       	mov    $0x20,%esi
  101385:	48 89 c7             	mov    %rax,%rdi
  101388:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10138a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10138e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101391:	83 e0 04             	and    $0x4,%eax
  101394:	85 c0                	test   %eax,%eax
  101396:	75 36                	jne    1013ce <printer_vprintf+0x90e>
  101398:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10139c:	7f cb                	jg     101369 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  10139e:	eb 2e                	jmp    1013ce <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1013a0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013a7:	4c 8b 00             	mov    (%rax),%r8
  1013aa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1013ae:	0f b6 00             	movzbl (%rax),%eax
  1013b1:	0f b6 c8             	movzbl %al,%ecx
  1013b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013c1:	89 ce                	mov    %ecx,%esi
  1013c3:	48 89 c7             	mov    %rax,%rdi
  1013c6:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1013c9:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1013ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1013d2:	0f b6 00             	movzbl (%rax),%eax
  1013d5:	84 c0                	test   %al,%al
  1013d7:	75 c7                	jne    1013a0 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1013d9:	eb 25                	jmp    101400 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1013db:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013e2:	48 8b 08             	mov    (%rax),%rcx
  1013e5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013f2:	be 30 00 00 00       	mov    $0x30,%esi
  1013f7:	48 89 c7             	mov    %rax,%rdi
  1013fa:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  1013fc:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101400:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101404:	7f d5                	jg     1013db <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101406:	eb 32                	jmp    10143a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101408:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10140f:	4c 8b 00             	mov    (%rax),%r8
  101412:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101416:	0f b6 00             	movzbl (%rax),%eax
  101419:	0f b6 c8             	movzbl %al,%ecx
  10141c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101422:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101429:	89 ce                	mov    %ecx,%esi
  10142b:	48 89 c7             	mov    %rax,%rdi
  10142e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101431:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101436:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10143a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10143e:	7f c8                	jg     101408 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101440:	eb 25                	jmp    101467 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101442:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101449:	48 8b 08             	mov    (%rax),%rcx
  10144c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101452:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101459:	be 20 00 00 00       	mov    $0x20,%esi
  10145e:	48 89 c7             	mov    %rax,%rdi
  101461:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101463:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101467:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10146b:	7f d5                	jg     101442 <printer_vprintf+0x982>
        }
    done: ;
  10146d:	90                   	nop
    for (; *format; ++format) {
  10146e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101475:	01 
  101476:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10147d:	0f b6 00             	movzbl (%rax),%eax
  101480:	84 c0                	test   %al,%al
  101482:	0f 85 64 f6 ff ff    	jne    100aec <printer_vprintf+0x2c>
    }
}
  101488:	90                   	nop
  101489:	90                   	nop
  10148a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10148e:	c9                   	leave  
  10148f:	c3                   	ret    

0000000000101490 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101490:	55                   	push   %rbp
  101491:	48 89 e5             	mov    %rsp,%rbp
  101494:	48 83 ec 20          	sub    $0x20,%rsp
  101498:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10149c:	89 f0                	mov    %esi,%eax
  10149e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1014a1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1014a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1014a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1014ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014b0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014b4:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1014b9:	48 39 d0             	cmp    %rdx,%rax
  1014bc:	72 0c                	jb     1014ca <console_putc+0x3a>
        cp->cursor = console;
  1014be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014c2:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1014c9:	00 
    }
    if (c == '\n') {
  1014ca:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1014ce:	75 78                	jne    101548 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1014d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1014d4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1014d8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1014de:	48 d1 f8             	sar    %rax
  1014e1:	48 89 c1             	mov    %rax,%rcx
  1014e4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1014eb:	66 66 66 
  1014ee:	48 89 c8             	mov    %rcx,%rax
  1014f1:	48 f7 ea             	imul   %rdx
  1014f4:	48 c1 fa 05          	sar    $0x5,%rdx
  1014f8:	48 89 c8             	mov    %rcx,%rax
  1014fb:	48 c1 f8 3f          	sar    $0x3f,%rax
  1014ff:	48 29 c2             	sub    %rax,%rdx
  101502:	48 89 d0             	mov    %rdx,%rax
  101505:	48 c1 e0 02          	shl    $0x2,%rax
  101509:	48 01 d0             	add    %rdx,%rax
  10150c:	48 c1 e0 04          	shl    $0x4,%rax
  101510:	48 29 c1             	sub    %rax,%rcx
  101513:	48 89 ca             	mov    %rcx,%rdx
  101516:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101519:	eb 25                	jmp    101540 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10151b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10151e:	83 c8 20             	or     $0x20,%eax
  101521:	89 c6                	mov    %eax,%esi
  101523:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101527:	48 8b 40 08          	mov    0x8(%rax),%rax
  10152b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10152f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101533:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101537:	89 f2                	mov    %esi,%edx
  101539:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10153c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101540:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101544:	75 d5                	jne    10151b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101546:	eb 24                	jmp    10156c <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101548:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10154c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10154f:	09 d0                	or     %edx,%eax
  101551:	89 c6                	mov    %eax,%esi
  101553:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101557:	48 8b 40 08          	mov    0x8(%rax),%rax
  10155b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10155f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101563:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101567:	89 f2                	mov    %esi,%edx
  101569:	66 89 10             	mov    %dx,(%rax)
}
  10156c:	90                   	nop
  10156d:	c9                   	leave  
  10156e:	c3                   	ret    

000000000010156f <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10156f:	55                   	push   %rbp
  101570:	48 89 e5             	mov    %rsp,%rbp
  101573:	48 83 ec 30          	sub    $0x30,%rsp
  101577:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10157a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10157d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101581:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101585:	48 c7 45 f0 90 14 10 	movq   $0x101490,-0x10(%rbp)
  10158c:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10158d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101591:	78 09                	js     10159c <console_vprintf+0x2d>
  101593:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  10159a:	7e 07                	jle    1015a3 <console_vprintf+0x34>
        cpos = 0;
  10159c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1015a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015a6:	48 98                	cltq   
  1015a8:	48 01 c0             	add    %rax,%rax
  1015ab:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1015b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1015b5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1015b9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1015bd:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1015c0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1015c4:	48 89 c7             	mov    %rax,%rdi
  1015c7:	e8 f4 f4 ff ff       	call   100ac0 <printer_vprintf>
    return cp.cursor - console;
  1015cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1015d0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1015d6:	48 d1 f8             	sar    %rax
}
  1015d9:	c9                   	leave  
  1015da:	c3                   	ret    

00000000001015db <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1015db:	55                   	push   %rbp
  1015dc:	48 89 e5             	mov    %rsp,%rbp
  1015df:	48 83 ec 60          	sub    $0x60,%rsp
  1015e3:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1015e6:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1015e9:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1015ed:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1015f1:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1015f5:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1015f9:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101600:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101604:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101608:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10160c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101610:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101614:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101618:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10161b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10161e:	89 c7                	mov    %eax,%edi
  101620:	e8 4a ff ff ff       	call   10156f <console_vprintf>
  101625:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101628:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10162b:	c9                   	leave  
  10162c:	c3                   	ret    

000000000010162d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10162d:	55                   	push   %rbp
  10162e:	48 89 e5             	mov    %rsp,%rbp
  101631:	48 83 ec 20          	sub    $0x20,%rsp
  101635:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101639:	89 f0                	mov    %esi,%eax
  10163b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10163e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101641:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101645:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101649:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10164d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101651:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101655:	48 8b 40 10          	mov    0x10(%rax),%rax
  101659:	48 39 c2             	cmp    %rax,%rdx
  10165c:	73 1a                	jae    101678 <string_putc+0x4b>
        *sp->s++ = c;
  10165e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101662:	48 8b 40 08          	mov    0x8(%rax),%rax
  101666:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10166a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10166e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101672:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101676:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101678:	90                   	nop
  101679:	c9                   	leave  
  10167a:	c3                   	ret    

000000000010167b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10167b:	55                   	push   %rbp
  10167c:	48 89 e5             	mov    %rsp,%rbp
  10167f:	48 83 ec 40          	sub    $0x40,%rsp
  101683:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101687:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10168b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10168f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101693:	48 c7 45 e8 2d 16 10 	movq   $0x10162d,-0x18(%rbp)
  10169a:	00 
    sp.s = s;
  10169b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10169f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1016a3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1016a8:	74 33                	je     1016dd <vsnprintf+0x62>
        sp.end = s + size - 1;
  1016aa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1016ae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1016b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1016b6:	48 01 d0             	add    %rdx,%rax
  1016b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1016bd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1016c1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1016c5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1016c9:	be 00 00 00 00       	mov    $0x0,%esi
  1016ce:	48 89 c7             	mov    %rax,%rdi
  1016d1:	e8 ea f3 ff ff       	call   100ac0 <printer_vprintf>
        *sp.s = 0;
  1016d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016da:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1016dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016e1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1016e5:	c9                   	leave  
  1016e6:	c3                   	ret    

00000000001016e7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1016e7:	55                   	push   %rbp
  1016e8:	48 89 e5             	mov    %rsp,%rbp
  1016eb:	48 83 ec 70          	sub    $0x70,%rsp
  1016ef:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  1016f3:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  1016f7:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  1016fb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1016ff:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101703:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101707:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10170e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101712:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101716:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10171a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10171e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101722:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101726:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10172a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10172e:	48 89 c7             	mov    %rax,%rdi
  101731:	e8 45 ff ff ff       	call   10167b <vsnprintf>
  101736:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101739:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10173c:	c9                   	leave  
  10173d:	c3                   	ret    

000000000010173e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10173e:	55                   	push   %rbp
  10173f:	48 89 e5             	mov    %rsp,%rbp
  101742:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101746:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10174d:	eb 13                	jmp    101762 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10174f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101752:	48 98                	cltq   
  101754:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10175b:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10175e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101762:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101769:	7e e4                	jle    10174f <console_clear+0x11>
    }
    cursorpos = 0;
  10176b:	c7 05 87 78 fb ff 00 	movl   $0x0,-0x48779(%rip)        # b8ffc <cursorpos>
  101772:	00 00 00 
}
  101775:	90                   	nop
  101776:	c9                   	leave  
  101777:	c3                   	ret    
