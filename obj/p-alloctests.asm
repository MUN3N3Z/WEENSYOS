
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 9e 0c 00 00       	call   2c0cb9 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 2e 06 00 00       	call   2c0653 <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 4b 07 00 00       	call   2c078f <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 dd 06 00 00       	call   2c0749 <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 77 07 00 00       	call   2c0802 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 20 1a 2c 00       	mov    $0x2c1a20,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 2e 1a 2c 00       	mov    $0x2c1a2e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 44 1a 2c 00       	mov    $0x2c1a44,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 2e 1a 2c 00       	mov    $0x2c1a2e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 68 1a 2c 00       	mov    $0x2c1a68,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 2e 1a 2c 00       	mov    $0x2c1a2e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 53 1a 2c 00       	mov    $0x2c1a53,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 14 05 00 00       	call   2c0623 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 0c 05 00 00       	call   2c0623 <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 1e 05 00 00       	call   2c0653 <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be 98 1a 2c 00       	mov    $0x2c1a98,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 fd 1a 2c 00 	movzbl 0x2c1afd(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 10 16 00 00       	call   2c180b <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave  
  2c020f:	c3                   	ret    

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be c8 1a 2c 00       	mov    $0x2c1ac8,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 62 07 00 00       	call   2c09c2 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 9f 16 00 00       	call   2c1917 <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq   
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba d0 1a 2c 00       	mov    $0x2c1ad0,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 c6 15 00 00       	call   2c1877 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be 63 1a 2c 00       	mov    $0x2c1a63,%esi
  2c02d7:	e8 93 08 00 00       	call   2c0b6f <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba d8 1a 2c 00       	mov    $0x2c1ad8,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 73 15 00 00       	call   2c1877 <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <push_free_block>:

// Adds a free memory block to the beginning of the free list
void push_free_block(header* free_block)
{
    // List is not empty
    if (free_list != NULL)
  2c030d:	48 8b 05 0c 1d 00 00 	mov    0x1d0c(%rip),%rax        # 2c2020 <free_list>
  2c0314:	48 85 c0             	test   %rax,%rax
  2c0317:	74 1e                	je     2c0337 <push_free_block+0x2a>
    {
        // Remember old list head
        header* old_head = free_list;
        // Attach new free block as list head
        free_block->next = old_head;
  2c0319:	48 89 07             	mov    %rax,(%rdi)
        old_head->prev = free_block;
  2c031c:	48 89 78 08          	mov    %rdi,0x8(%rax)
        free_block->prev = NULL;
  2c0320:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0327:	00 
        free_list = free_block;
  2c0328:	48 89 3d f1 1c 00 00 	mov    %rdi,0x1cf1(%rip)        # 2c2020 <free_list>
        free_list = free_block;
        free_block->prev = NULL;
        free_block->next = NULL;
    }
    // Reset "alloc" flag to 0 (free)
    free_block->alloc = 0;
  2c032f:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
}
  2c0336:	c3                   	ret    
        free_list = free_block;
  2c0337:	48 89 3d e2 1c 00 00 	mov    %rdi,0x1ce2(%rip)        # 2c2020 <free_list>
        free_block->prev = NULL;
  2c033e:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c0345:	00 
        free_block->next = NULL;
  2c0346:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
  2c034d:	eb e0                	jmp    2c032f <push_free_block+0x22>

00000000002c034f <push_malloc_block>:

// Push an allocated memory block to top of the malloc_list
void push_malloc_block(header* malloc_block)
{
    // List is not empty
    if (malloc_list != NULL)
  2c034f:	48 8b 05 b2 1c 00 00 	mov    0x1cb2(%rip),%rax        # 2c2008 <malloc_list>
  2c0356:	48 85 c0             	test   %rax,%rax
  2c0359:	74 04                	je     2c035f <push_malloc_block+0x10>
    {
        // Remember old list head
        header* old_head = malloc_list;
        // Attach new free block as list head
        malloc_block->next_alloc_block = old_head;
  2c035b:	48 89 47 20          	mov    %rax,0x20(%rdi)
        malloc_list = malloc_block;
  2c035f:	48 89 3d a2 1c 00 00 	mov    %rdi,0x1ca2(%rip)        # 2c2008 <malloc_list>
    }
    else
    {
        malloc_list = malloc_block;
    }
}
  2c0366:	c3                   	ret    

00000000002c0367 <find_free_block>:

// [First-fit strategy] Finds a free memory block suitable to hold sz + sizeof(header)
header* find_free_block(uint64_t sz){
    header* temp = free_list;
  2c0367:	48 8b 05 b2 1c 00 00 	mov    0x1cb2(%rip),%rax        # 2c2020 <free_list>
    while (temp != NULL)
  2c036e:	48 85 c0             	test   %rax,%rax
  2c0371:	74 0e                	je     2c0381 <find_free_block+0x1a>
    {
        if (temp->size >= sz)
  2c0373:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  2c0377:	73 08                	jae    2c0381 <find_free_block+0x1a>
        {
            return temp;
        }
        // Move to next memory block
        temp = temp->next;
  2c0379:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  2c037c:	48 85 c0             	test   %rax,%rax
  2c037f:	75 f2                	jne    2c0373 <find_free_block+0xc>
    }
    return NULL;
}
  2c0381:	c3                   	ret    

00000000002c0382 <reconnect_free_list>:

// Reconnect free_list after a free block is partitioned
void reconnect_free_list(header* old_free_block)
{
    // Free block on both ends
    if(old_free_block->prev != NULL && old_free_block->next != NULL)
  2c0382:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c0386:	48 85 c0             	test   %rax,%rax
  2c0389:	74 14                	je     2c039f <reconnect_free_list+0x1d>
  2c038b:	48 8b 17             	mov    (%rdi),%rdx
  2c038e:	48 85 d2             	test   %rdx,%rdx
  2c0391:	74 24                	je     2c03b7 <reconnect_free_list+0x35>
    {
        old_free_block->prev->next = old_free_block->next;
  2c0393:	48 89 10             	mov    %rdx,(%rax)
        old_free_block->next->prev = old_free_block->prev;
  2c0396:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c039a:	48 89 42 08          	mov    %rax,0x8(%rdx)
  2c039e:	c3                   	ret    
    }
    // First block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next != NULL)
  2c039f:	48 8b 07             	mov    (%rdi),%rax
  2c03a2:	48 85 c0             	test   %rax,%rax
  2c03a5:	74 18                	je     2c03bf <reconnect_free_list+0x3d>
    {
        free_list = old_free_block->next;
  2c03a7:	48 89 05 72 1c 00 00 	mov    %rax,0x1c72(%rip)        # 2c2020 <free_list>
        old_free_block->next->prev = NULL;
  2c03ae:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c03b5:	00 
  2c03b6:	c3                   	ret    
    }
    // Last block on free_list
    else if(old_free_block->prev != NULL && old_free_block->next == NULL)
    {
        old_free_block->prev->next = NULL;
  2c03b7:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  2c03be:	c3                   	ret    
    }
    // Only block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next == NULL)
    {
        free_list = NULL;
  2c03bf:	48 c7 05 56 1c 00 00 	movq   $0x0,0x1c56(%rip)        # 2c2020 <free_list>
  2c03c6:	00 00 00 00 
    }
}
  2c03ca:	c3                   	ret    

00000000002c03cb <block_init>:

// Initialize header of a memory block that's about to be returned to user
void block_init(header* free_block)
{
    free_block->next = NULL;
  2c03cb:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    free_block->prev = NULL;
  2c03d2:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  2c03d9:	00 
    free_block->next_alloc_block = NULL;
  2c03da:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  2c03e1:	00 
    free_block->alloc = 1;
  2c03e2:	c7 47 18 01 00 00 00 	movl   $0x1,0x18(%rdi)
}
  2c03e9:	c3                   	ret    

00000000002c03ea <set_canary>:

/**
 * Set canary value in an allocated memory block
 * @mem_block assumed to be pointer to mem_block header
*/
void set_canary(intptr_t mem_block){
  2c03ea:	55                   	push   %rbp
  2c03eb:	48 89 e5             	mov    %rsp,%rbp
    // Get canary location
    intptr_t block_size = (intptr_t)(((header*) mem_block)->size);
    intptr_t canary_location = mem_block + block_size - ((intptr_t)(sizeof(canary_value)));
  2c03ee:	48 03 7f 10          	add    0x10(%rdi),%rdi
  2c03f2:	48 83 ef 08          	sub    $0x8,%rdi
    // Set canary value
    memcpy(((void*)canary_location), &canary_value, sizeof(canary_value));
  2c03f6:	ba 08 00 00 00       	mov    $0x8,%edx
  2c03fb:	be 00 20 2c 00       	mov    $0x2c2000,%esi
  2c0400:	e8 bd 05 00 00       	call   2c09c2 <memcpy>
}
  2c0405:	5d                   	pop    %rbp
  2c0406:	c3                   	ret    

00000000002c0407 <check_canary>:
/**
 * Ensure overflow canary is intact
 * @memblock assumed to be a pointer to mem_block payload
*/
int check_canary(intptr_t mem_block)
{
  2c0407:	55                   	push   %rbp
  2c0408:	48 89 e5             	mov    %rsp,%rbp
  2c040b:	48 83 ec 10          	sub    $0x10,%rsp
    // Get canary location
    header* head = (header*)(mem_block - ((intptr_t) HEADER_SIZE));
    intptr_t block_size = (intptr_t)(head->size);
    intptr_t canary_location = (intptr_t)head + block_size - ((intptr_t)(sizeof(canary_value)));
  2c040f:	48 03 7f e8          	add    -0x18(%rdi),%rdi
  2c0413:	48 8d 77 d0          	lea    -0x30(%rdi),%rsi
    // Compare canary value
    size_t overflow_canary;
    memcpy(&overflow_canary, ((void*) canary_location), sizeof(canary_value));
  2c0417:	ba 08 00 00 00       	mov    $0x8,%edx
  2c041c:	48 8d 7d f8          	lea    -0x8(%rbp),%rdi
  2c0420:	e8 9d 05 00 00       	call   2c09c2 <memcpy>
    if(canary_value != overflow_canary)
  2c0425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0429:	48 39 05 d0 1b 00 00 	cmp    %rax,0x1bd0(%rip)        # 2c2000 <canary_value>
  2c0430:	0f 94 c0             	sete   %al
  2c0433:	0f b6 c0             	movzbl %al,%eax
    {
        return 0;
    }

    return 1;
}
  2c0436:	c9                   	leave  
  2c0437:	c3                   	ret    

00000000002c0438 <merge>:

// Merge two sorted sub arrays
void merge(header** ptr_array, header* left_array[], int left_size, header* right_array[], int right_size)
{
  2c0438:	55                   	push   %rbp
  2c0439:	48 89 e5             	mov    %rsp,%rbp
  2c043c:	41 55                	push   %r13
  2c043e:	41 54                	push   %r12
  2c0440:	53                   	push   %rbx
  2c0441:	48 89 f3             	mov    %rsi,%rbx
  2c0444:	41 89 d1             	mov    %edx,%r9d
  2c0447:	49 89 ca             	mov    %rcx,%r10
    int i = 0, j = 0, k = 0;
    while (i < left_size && j < right_size)
  2c044a:	85 d2                	test   %edx,%edx
  2c044c:	7e 57                	jle    2c04a5 <merge+0x6d>
  2c044e:	45 85 c0             	test   %r8d,%r8d
  2c0451:	7e 52                	jle    2c04a5 <merge+0x6d>
  2c0453:	48 89 fe             	mov    %rdi,%rsi
  2c0456:	b9 01 00 00 00       	mov    $0x1,%ecx
    int i = 0, j = 0, k = 0;
  2c045b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0460:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0465:	eb 1a                	jmp    2c0481 <merge+0x49>
        {
            ptr_array[k++] = right_array[j++];
        }
        else
        {
            ptr_array[k++] = left_array[i++];
  2c0467:	83 c0 01             	add    $0x1,%eax
  2c046a:	41 89 cb             	mov    %ecx,%r11d
  2c046d:	4c 89 26             	mov    %r12,(%rsi)
    while (i < left_size && j < right_size)
  2c0470:	83 c1 01             	add    $0x1,%ecx
  2c0473:	48 83 c6 08          	add    $0x8,%rsi
  2c0477:	44 39 c8             	cmp    %r9d,%eax
  2c047a:	7d 39                	jge    2c04b5 <merge+0x7d>
  2c047c:	44 39 c2             	cmp    %r8d,%edx
  2c047f:	7d 34                	jge    2c04b5 <merge+0x7d>
        if (left_array[i]->size < right_array[j]->size)
  2c0481:	4c 63 d8             	movslq %eax,%r11
  2c0484:	4e 8b 24 db          	mov    (%rbx,%r11,8),%r12
  2c0488:	4c 63 da             	movslq %edx,%r11
  2c048b:	4f 8b 2c da          	mov    (%r10,%r11,8),%r13
  2c048f:	4d 8b 5d 10          	mov    0x10(%r13),%r11
  2c0493:	4d 39 5c 24 10       	cmp    %r11,0x10(%r12)
  2c0498:	73 cd                	jae    2c0467 <merge+0x2f>
            ptr_array[k++] = right_array[j++];
  2c049a:	83 c2 01             	add    $0x1,%edx
  2c049d:	41 89 cb             	mov    %ecx,%r11d
  2c04a0:	4c 89 2e             	mov    %r13,(%rsi)
  2c04a3:	eb cb                	jmp    2c0470 <merge+0x38>
    int i = 0, j = 0, k = 0;
  2c04a5:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  2c04ab:	ba 00 00 00 00       	mov    $0x0,%edx
  2c04b0:	b8 00 00 00 00       	mov    $0x0,%eax
        }
    }
    while (i < left_size)
  2c04b5:	41 39 c1             	cmp    %eax,%r9d
  2c04b8:	7e 39                	jle    2c04f3 <merge+0xbb>
  2c04ba:	41 89 c4             	mov    %eax,%r12d
  2c04bd:	44 89 ce             	mov    %r9d,%esi
  2c04c0:	29 c6                	sub    %eax,%esi
  2c04c2:	48 c1 e6 03          	shl    $0x3,%rsi
  2c04c6:	48 98                	cltq   
  2c04c8:	4c 8d 2c c3          	lea    (%rbx,%rax,8),%r13
  2c04cc:	49 63 c3             	movslq %r11d,%rax
  2c04cf:	48 8d 1c c7          	lea    (%rdi,%rax,8),%rbx
  2c04d3:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = left_array[i++];
  2c04d8:	49 8b 4c 05 00       	mov    0x0(%r13,%rax,1),%rcx
  2c04dd:	48 89 0c 03          	mov    %rcx,(%rbx,%rax,1)
    while (i < left_size)
  2c04e1:	48 83 c0 08          	add    $0x8,%rax
  2c04e5:	48 39 f0             	cmp    %rsi,%rax
  2c04e8:	75 ee                	jne    2c04d8 <merge+0xa0>
  2c04ea:	45 01 d9             	add    %r11d,%r9d
        ptr_array[k++] = left_array[i++];
  2c04ed:	45 29 e1             	sub    %r12d,%r9d
  2c04f0:	45 89 cb             	mov    %r9d,%r11d

    }
    while (j < right_size)
  2c04f3:	41 39 d0             	cmp    %edx,%r8d
  2c04f6:	7e 2b                	jle    2c0523 <merge+0xeb>
  2c04f8:	41 29 d0             	sub    %edx,%r8d
  2c04fb:	49 c1 e0 03          	shl    $0x3,%r8
  2c04ff:	48 63 d2             	movslq %edx,%rdx
  2c0502:	49 8d 34 d2          	lea    (%r10,%rdx,8),%rsi
  2c0506:	4d 63 db             	movslq %r11d,%r11
  2c0509:	4a 8d 0c df          	lea    (%rdi,%r11,8),%rcx
  2c050d:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = right_array[j++];
  2c0512:	48 8b 14 06          	mov    (%rsi,%rax,1),%rdx
  2c0516:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    while (j < right_size)
  2c051a:	48 83 c0 08          	add    $0x8,%rax
  2c051e:	4c 39 c0             	cmp    %r8,%rax
  2c0521:	75 ef                	jne    2c0512 <merge+0xda>
    }
    
}
  2c0523:	5b                   	pop    %rbx
  2c0524:	41 5c                	pop    %r12
  2c0526:	41 5d                	pop    %r13
  2c0528:	5d                   	pop    %rbp
  2c0529:	c3                   	ret    

00000000002c052a <merge_sort>:

// Merge sort function
void merge_sort(header** ptr_array, int size)
{
  2c052a:	55                   	push   %rbp
  2c052b:	48 89 e5             	mov    %rsp,%rbp
  2c052e:	41 57                	push   %r15
  2c0530:	41 56                	push   %r14
  2c0532:	41 55                	push   %r13
  2c0534:	41 54                	push   %r12
  2c0536:	53                   	push   %rbx
  2c0537:	48 83 ec 18          	sub    $0x18,%rsp
  2c053b:	48 89 fb             	mov    %rdi,%rbx
  2c053e:	48 89 e7             	mov    %rsp,%rdi
    // Base case
    if (size < 2)
  2c0541:	83 fe 01             	cmp    $0x1,%esi
  2c0544:	0f 8e d4 00 00 00    	jle    2c061e <merge_sort+0xf4>
    {
        return;
    }
    int middle = size/2;
  2c054a:	41 89 f6             	mov    %esi,%r14d
  2c054d:	41 c1 ee 1f          	shr    $0x1f,%r14d
  2c0551:	41 01 f6             	add    %esi,%r14d
  2c0554:	41 d1 fe             	sar    %r14d
    header* left_array[middle];
  2c0557:	49 63 ce             	movslq %r14d,%rcx
  2c055a:	48 c1 e1 03          	shl    $0x3,%rcx
  2c055e:	41 b8 10 00 00 00    	mov    $0x10,%r8d
  2c0564:	48 8d 41 0f          	lea    0xf(%rcx),%rax
  2c0568:	ba 00 00 00 00       	mov    $0x0,%edx
  2c056d:	49 f7 f0             	div    %r8
  2c0570:	48 c1 e0 04          	shl    $0x4,%rax
  2c0574:	48 29 c4             	sub    %rax,%rsp
  2c0577:	49 89 e4             	mov    %rsp,%r12
    header* right_array[size - middle];
  2c057a:	41 89 f7             	mov    %esi,%r15d
  2c057d:	45 29 f7             	sub    %r14d,%r15d
  2c0580:	49 63 c7             	movslq %r15d,%rax
  2c0583:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
  2c058a:	00 
  2c058b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0590:	49 f7 f0             	div    %r8
  2c0593:	48 c1 e0 04          	shl    $0x4,%rax
  2c0597:	48 29 c4             	sub    %rax,%rsp
  2c059a:	49 89 e5             	mov    %rsp,%r13
  2c059d:	b8 00 00 00 00       	mov    $0x0,%eax
    // Populate left and right sub-arrays
    for (int i = 0; i < middle; i++)
    {
        left_array[i] = ptr_array[i];
  2c05a2:	48 8b 14 03          	mov    (%rbx,%rax,1),%rdx
  2c05a6:	49 89 14 04          	mov    %rdx,(%r12,%rax,1)
    for (int i = 0; i < middle; i++)
  2c05aa:	48 83 c0 08          	add    $0x8,%rax
  2c05ae:	48 39 c1             	cmp    %rax,%rcx
  2c05b1:	75 ef                	jne    2c05a2 <merge_sort+0x78>
    }
    for (int j = middle; j < size; j++)
  2c05b3:	44 39 f6             	cmp    %r14d,%esi
  2c05b6:	7e 25                	jle    2c05dd <merge_sort+0xb3>
  2c05b8:	44 29 f6             	sub    %r14d,%esi
  2c05bb:	48 8d 14 f5 00 00 00 	lea    0x0(,%rsi,8),%rdx
  2c05c2:	00 
  2c05c3:	48 01 d9             	add    %rbx,%rcx
  2c05c6:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        right_array[j - middle] = ptr_array[j];
  2c05cb:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  2c05cf:	49 89 74 05 00       	mov    %rsi,0x0(%r13,%rax,1)
    for (int j = middle; j < size; j++)
  2c05d4:	48 83 c0 08          	add    $0x8,%rax
  2c05d8:	48 39 d0             	cmp    %rdx,%rax
  2c05db:	75 ee                	jne    2c05cb <merge_sort+0xa1>
  2c05dd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    }
    // Recursively sort left and right sub-arrays
    merge_sort(left_array, middle);
  2c05e1:	44 89 f6             	mov    %r14d,%esi
  2c05e4:	4c 89 e7             	mov    %r12,%rdi
  2c05e7:	e8 3e ff ff ff       	call   2c052a <merge_sort>
    merge_sort(right_array, (size - middle));
  2c05ec:	44 89 fe             	mov    %r15d,%esi
  2c05ef:	4c 89 ef             	mov    %r13,%rdi
  2c05f2:	e8 33 ff ff ff       	call   2c052a <merge_sort>
    // Merge sorted sub-arrays back to original array
    merge(ptr_array, left_array, middle, right_array, (size - middle));
  2c05f7:	45 89 f8             	mov    %r15d,%r8d
  2c05fa:	4c 89 e9             	mov    %r13,%rcx
  2c05fd:	44 89 f2             	mov    %r14d,%edx
  2c0600:	4c 89 e6             	mov    %r12,%rsi
  2c0603:	48 89 df             	mov    %rbx,%rdi
  2c0606:	e8 2d fe ff ff       	call   2c0438 <merge>
  2c060b:	48 8b 65 c8          	mov    -0x38(%rbp),%rsp
}
  2c060f:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  2c0613:	5b                   	pop    %rbx
  2c0614:	41 5c                	pop    %r12
  2c0616:	41 5d                	pop    %r13
  2c0618:	41 5e                	pop    %r14
  2c061a:	41 5f                	pop    %r15
  2c061c:	5d                   	pop    %rbp
  2c061d:	c3                   	ret    
        return;
  2c061e:	48 89 fc             	mov    %rdi,%rsp
  2c0621:	eb ec                	jmp    2c060f <merge_sort+0xe5>

00000000002c0623 <free>:
// by a previous call to malloc or realloc, or if free has already been called before, then
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void *firstbyte) {
    // Corner cases: NULL pointer passed
    if (firstbyte == NULL)
  2c0623:	48 85 ff             	test   %rdi,%rdi
  2c0626:	74 2a                	je     2c0652 <free+0x2f>
void free(void *firstbyte) {
  2c0628:	55                   	push   %rbp
  2c0629:	48 89 e5             	mov    %rsp,%rbp
  2c062c:	53                   	push   %rbx
  2c062d:	48 83 ec 08          	sub    $0x8,%rsp
    {
        return;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) firstbyte) - ((intptr_t)HEADER_SIZE));
  2c0631:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    // Ensure memory block was previously allocated
    if(head->alloc == 1)
  2c0635:	83 7f f0 01          	cmpl   $0x1,-0x10(%rdi)
  2c0639:	74 06                	je     2c0641 <free+0x1e>
        // Push memory block into free_list
        push_free_block(head);
        head->alloc = 0;
    }
    return;
}
  2c063b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c063f:	c9                   	leave  
  2c0640:	c3                   	ret    
        push_free_block(head);
  2c0641:	48 89 df             	mov    %rbx,%rdi
  2c0644:	e8 c4 fc ff ff       	call   2c030d <push_free_block>
        head->alloc = 0;
  2c0649:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
  2c0650:	eb e9                	jmp    2c063b <free+0x18>
  2c0652:	c3                   	ret    

00000000002c0653 <malloc>:
// malloc(sz):
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void *malloc(uint64_t numbytes) {
  2c0653:	55                   	push   %rbp
  2c0654:	48 89 e5             	mov    %rsp,%rbp
  2c0657:	41 54                	push   %r12
  2c0659:	53                   	push   %rbx
    // Coner case
    if (numbytes == 0)
    {
        return NULL;
  2c065a:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0)
  2c065f:	48 85 ff             	test   %rdi,%rdi
  2c0662:	0f 84 d9 00 00 00    	je     2c0741 <malloc+0xee>
    }
    // Compute size of memory to allocate
    uint64_t mem_alloc = (uint64_t)(((intptr_t) numbytes) + ((intptr_t) HEADER_SIZE) + ((intptr_t) sizeof(canary_value)));
  2c0668:	4c 8d 67 30          	lea    0x30(%rdi),%r12
    // Search for a suitable memory block to assign
    header* free_block = find_free_block(mem_alloc);
  2c066c:	4c 89 e7             	mov    %r12,%rdi
  2c066f:	e8 f3 fc ff ff       	call   2c0367 <find_free_block>
  2c0674:	48 89 c3             	mov    %rax,%rbx
    // Initial malloc: free_list is empty
    if (free_block  == NULL)
  2c0677:	48 85 c0             	test   %rax,%rax
  2c067a:	74 6b                	je     2c06e7 <malloc+0x94>
        free_block = ((header*) ret);
    }
    else
    {
        // Remove block from free_list
        reconnect_free_list(free_block);
  2c067c:	48 89 c7             	mov    %rax,%rdi
  2c067f:	e8 fe fc ff ff       	call   2c0382 <reconnect_free_list>
    }
    // Partition NOT required
    if ((free_block->size - mem_alloc) <= HEADER_SIZE)
  2c0684:	48 8b 43 10          	mov    0x10(%rbx),%rax
  2c0688:	4c 29 e0             	sub    %r12,%rax
  2c068b:	48 83 f8 28          	cmp    $0x28,%rax
  2c068f:	76 7e                	jbe    2c070f <malloc+0xbc>
    }
    // Partition required
    else
    {
        // Resize the orginal "free block" header 
        intptr_t new_free_block = (((intptr_t) free_block) + mem_alloc);
  2c0691:	4a 8d 14 23          	lea    (%rbx,%r12,1),%rdx
        // Ensure "new_free_block" is page-aligned
        header* new_free_block_align = (header*)(ALIGN(new_free_block));
  2c0695:	48 8d 7a 07          	lea    0x7(%rdx),%rdi
  2c0699:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
        // Update size of new_free_block
        uint64_t new_free_block_align_size = free_block->size - mem_alloc - (((intptr_t)new_free_block_align) - new_free_block);
  2c069d:	48 89 f9             	mov    %rdi,%rcx
  2c06a0:	48 29 d1             	sub    %rdx,%rcx
  2c06a3:	48 29 c8             	sub    %rcx,%rax
  2c06a6:	48 89 47 10          	mov    %rax,0x10(%rdi)
    free_block->next = NULL;
  2c06aa:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  2c06b1:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c06b8:	00 
    free_block->next_alloc_block = NULL;
  2c06b9:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  2c06c0:	00 
    free_block->alloc = 1;
  2c06c1:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        new_free_block_align->size = new_free_block_align_size;
        // Update assigned "free block" (to be returned)
        block_init(free_block);
        // Push "new_free_block"
        push_free_block(new_free_block_align);
  2c06c8:	e8 40 fc ff ff       	call   2c030d <push_free_block>
        free_block->size = mem_alloc;
  2c06cd:	4c 89 63 10          	mov    %r12,0x10(%rbx)
        // Set canary value
        set_canary((intptr_t) free_block);
  2c06d1:	48 89 df             	mov    %rbx,%rdi
  2c06d4:	e8 11 fd ff ff       	call   2c03ea <set_canary>
        // Add block to malloc_list
        push_malloc_block(free_block);
  2c06d9:	48 89 df             	mov    %rbx,%rdi
  2c06dc:	e8 6e fc ff ff       	call   2c034f <push_malloc_block>
        // Get payload pointer
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  2c06e1:	48 83 c3 28          	add    $0x28,%rbx

        
        return ret;
  2c06e5:	eb 5a                	jmp    2c0741 <malloc+0xee>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c06e7:	4c 89 e7             	mov    %r12,%rdi
  2c06ea:	cd 3a                	int    $0x3a
  2c06ec:	48 89 05 25 19 00 00 	mov    %rax,0x1925(%rip)        # 2c2018 <result.0>
        if (ret == ((void*)-1))
  2c06f3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c06f7:	74 48                	je     2c0741 <malloc+0xee>
        ret = (void*)(ALIGN((intptr_t)ret));
  2c06f9:	48 83 c0 07          	add    $0x7,%rax
  2c06fd:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  2c0701:	48 89 c3             	mov    %rax,%rbx
        program_break = ret;
  2c0704:	48 89 05 05 19 00 00 	mov    %rax,0x1905(%rip)        # 2c2010 <program_break>
        ((header*) ret)->size = mem_alloc;
  2c070b:	4c 89 60 10          	mov    %r12,0x10(%rax)
    free_block->next = NULL;
  2c070f:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  2c0716:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c071d:	00 
    free_block->next_alloc_block = NULL;
  2c071e:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  2c0725:	00 
    free_block->alloc = 1;
  2c0726:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        set_canary((intptr_t) free_block);
  2c072d:	48 89 df             	mov    %rbx,%rdi
  2c0730:	e8 b5 fc ff ff       	call   2c03ea <set_canary>
        push_malloc_block(free_block);
  2c0735:	48 89 df             	mov    %rbx,%rdi
  2c0738:	e8 12 fc ff ff       	call   2c034f <push_malloc_block>
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  2c073d:	48 83 c3 28          	add    $0x28,%rbx
    }
    return NULL;
}
  2c0741:	48 89 d8             	mov    %rbx,%rax
  2c0744:	5b                   	pop    %rbx
  2c0745:	41 5c                	pop    %r12
  2c0747:	5d                   	pop    %rbp
  2c0748:	c3                   	ret    

00000000002c0749 <calloc>:
// allocates memory of an array of num elements of size sz bytes each and returns a pointer 
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz) {
  2c0749:	55                   	push   %rbp
  2c074a:	48 89 e5             	mov    %rsp,%rbp
  2c074d:	41 54                	push   %r12
  2c074f:	53                   	push   %rbx
    // Calculate total memory to be allocated
    uint64_t total_memory = num * sz;
  2c0750:	48 0f af fe          	imul   %rsi,%rdi
  2c0754:	49 89 fc             	mov    %rdi,%r12
    // Request for memory
    void* new_memory_block = malloc(total_memory);
  2c0757:	e8 f7 fe ff ff       	call   2c0653 <malloc>
  2c075c:	48 89 c3             	mov    %rax,%rbx
    // Error while allocating memory
    if (new_memory_block == NULL)
  2c075f:	48 85 c0             	test   %rax,%rax
  2c0762:	74 23                	je     2c0787 <calloc+0x3e>
        return NULL;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) new_memory_block) - ((intptr_t) HEADER_SIZE));
    // Zero out the memory
    memset(new_memory_block, 0, ((size_t)total_memory));
  2c0764:	4c 89 e2             	mov    %r12,%rdx
  2c0767:	be 00 00 00 00       	mov    $0x0,%esi
  2c076c:	48 89 c7             	mov    %rax,%rdi
  2c076f:	e8 4c 03 00 00       	call   2c0ac0 <memset>
    // Check for overflow***
    if(check_canary((intptr_t) new_memory_block) == 0)
  2c0774:	48 89 df             	mov    %rbx,%rdi
  2c0777:	e8 8b fc ff ff       	call   2c0407 <check_canary>
    {
        // free memory that was malloc'd
        return NULL;
  2c077c:	85 c0                	test   %eax,%eax
  2c077e:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0783:	48 0f 44 d8          	cmove  %rax,%rbx
    }
    return new_memory_block;
}
  2c0787:	48 89 d8             	mov    %rbx,%rax
  2c078a:	5b                   	pop    %rbx
  2c078b:	41 5c                	pop    %r12
  2c078d:	5d                   	pop    %rbp
  2c078e:	c3                   	ret    

00000000002c078f <realloc>:
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz) {
  2c078f:	55                   	push   %rbp
  2c0790:	48 89 e5             	mov    %rsp,%rbp
  2c0793:	41 55                	push   %r13
  2c0795:	41 54                	push   %r12
  2c0797:	53                   	push   %rbx
  2c0798:	48 83 ec 08          	sub    $0x8,%rsp
  2c079c:	48 89 fb             	mov    %rdi,%rbx
  2c079f:	48 89 f7             	mov    %rsi,%rdi
    // Corner case: ptr is NULL, ptr provided but sz is 0
    if (ptr == NULL)
  2c07a2:	48 85 db             	test   %rbx,%rbx
  2c07a5:	74 38                	je     2c07df <realloc+0x50>
    {
        return malloc(sz);
    }
    if (ptr && (sz == 0))
  2c07a7:	48 85 f6             	test   %rsi,%rsi
  2c07aa:	74 3d                	je     2c07e9 <realloc+0x5a>
    }
    // Get head of memory block
    header* head = (header*)(((intptr_t) ptr) - ((intptr_t) HEADER_SIZE));
    
    // Allocate new, larger/smaller memory
    void* ret = malloc(sz);
  2c07ac:	e8 a2 fe ff ff       	call   2c0653 <malloc>
  2c07b1:	49 89 c4             	mov    %rax,%r12
    if (ret == ((void*) -1))
  2c07b4:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c07b8:	74 3f                	je     2c07f9 <realloc+0x6a>
    {
        // Error while allocating new memory block
        return NULL;
    }
    // Transfer data from old mem block to new mem block
    memcpy(ret, ptr, ((size_t) head->size));
  2c07ba:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c07be:	48 89 de             	mov    %rbx,%rsi
  2c07c1:	48 89 c7             	mov    %rax,%rdi
  2c07c4:	e8 f9 01 00 00       	call   2c09c2 <memcpy>
    // Push old block to free_list
    free((header*) ptr);
  2c07c9:	48 89 df             	mov    %rbx,%rdi
  2c07cc:	e8 52 fe ff ff       	call   2c0623 <free>
        
    return ret;
}
  2c07d1:	4c 89 e0             	mov    %r12,%rax
  2c07d4:	48 83 c4 08          	add    $0x8,%rsp
  2c07d8:	5b                   	pop    %rbx
  2c07d9:	41 5c                	pop    %r12
  2c07db:	41 5d                	pop    %r13
  2c07dd:	5d                   	pop    %rbp
  2c07de:	c3                   	ret    
        return malloc(sz);
  2c07df:	e8 6f fe ff ff       	call   2c0653 <malloc>
  2c07e4:	49 89 c4             	mov    %rax,%r12
  2c07e7:	eb e8                	jmp    2c07d1 <realloc+0x42>
        free(ptr);
  2c07e9:	48 89 df             	mov    %rbx,%rdi
  2c07ec:	e8 32 fe ff ff       	call   2c0623 <free>
        return NULL;
  2c07f1:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c07f7:	eb d8                	jmp    2c07d1 <realloc+0x42>
        return NULL;
  2c07f9:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c07ff:	eb d0                	jmp    2c07d1 <realloc+0x42>

00000000002c0801 <defrag>:
 * 3. Merge with left block if it's free
 * 4. Merge with both left and right blocks if both are free
*/
void defrag() {

}
  2c0801:	c3                   	ret    

00000000002c0802 <heap_info>:
// the user, i.e. the process will be responsible for freeing these allocations
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info) {
  2c0802:	55                   	push   %rbp
  2c0803:	48 89 e5             	mov    %rsp,%rbp
  2c0806:	41 57                	push   %r15
  2c0808:	41 56                	push   %r14
  2c080a:	41 55                	push   %r13
  2c080c:	41 54                	push   %r12
  2c080e:	53                   	push   %rbx
  2c080f:	48 83 ec 18          	sub    $0x18,%rsp
  2c0813:	49 89 ff             	mov    %rdi,%r15
    int debug = 0;
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
    // Find "largest_free_chunk", "free_space" from free_list
    header* temp = free_list;
  2c0816:	48 8b 05 03 18 00 00 	mov    0x1803(%rip),%rax        # 2c2020 <free_list>
    while (temp != NULL)
  2c081d:	48 85 c0             	test   %rax,%rax
  2c0820:	74 2f                	je     2c0851 <heap_info+0x4f>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  2c0822:	41 be 00 00 00 00    	mov    $0x0,%r14d
  2c0828:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c082e:	eb 08                	jmp    2c0838 <heap_info+0x36>
            if (temp->size > ((uint64_t)largest_free_chunk))
            {
                largest_free_chunk = temp->size;
            }
        }
        temp = temp->next;
  2c0830:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  2c0833:	48 85 c0             	test   %rax,%rax
  2c0836:	74 25                	je     2c085d <heap_info+0x5b>
        if (temp->alloc == 0)
  2c0838:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  2c083c:	75 f2                	jne    2c0830 <heap_info+0x2e>
            free_space += temp->size;
  2c083e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0842:	41 01 d6             	add    %edx,%r14d
            if (temp->size > ((uint64_t)largest_free_chunk))
  2c0845:	49 63 cd             	movslq %r13d,%rcx
                largest_free_chunk = temp->size;
  2c0848:	48 39 d1             	cmp    %rdx,%rcx
  2c084b:	44 0f 42 ea          	cmovb  %edx,%r13d
  2c084f:	eb df                	jmp    2c0830 <heap_info+0x2e>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  2c0851:	41 be 00 00 00 00    	mov    $0x0,%r14d
  2c0857:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    }
    // Find "num_allocs" from malloc_list
    temp = malloc_list;
  2c085d:	48 8b 05 a4 17 00 00 	mov    0x17a4(%rip),%rax        # 2c2008 <malloc_list>
    while (temp != NULL)
  2c0864:	48 85 c0             	test   %rax,%rax
  2c0867:	0f 84 c8 00 00 00    	je     2c0935 <heap_info+0x133>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  2c086d:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0872:	eb 09                	jmp    2c087d <heap_info+0x7b>
        // Ensure block has not been freed
        if (temp->alloc == 1)
        {
            num_allocs ++;
        }
        temp = temp->next_alloc_block;
  2c0874:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL)
  2c0878:	48 85 c0             	test   %rax,%rax
  2c087b:	74 0b                	je     2c0888 <heap_info+0x86>
        if (temp->alloc == 1)
  2c087d:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  2c0881:	75 f1                	jne    2c0874 <heap_info+0x72>
            num_allocs ++;
  2c0883:	83 c3 01             	add    $0x1,%ebx
  2c0886:	eb ec                	jmp    2c0874 <heap_info+0x72>
    }
    // Create ptr_array (list of pointers to memory block headers)
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  2c0888:	48 63 c3             	movslq %ebx,%rax
  2c088b:	48 c1 e0 03          	shl    $0x3,%rax
  2c088f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  2c0893:	48 89 c7             	mov    %rax,%rdi
  2c0896:	e8 b8 fd ff ff       	call   2c0653 <malloc>
  2c089b:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  2c089e:	48 85 c0             	test   %rax,%rax
  2c08a1:	74 63                	je     2c0906 <heap_info+0x104>
    {
        return -1;
    }
    int count = 0;
    // Reinitialize "temp"
    temp = malloc_list;
  2c08a3:	48 8b 05 5e 17 00 00 	mov    0x175e(%rip),%rax        # 2c2008 <malloc_list>
    while (temp != NULL && (count < num_allocs))
  2c08aa:	48 85 c0             	test   %rax,%rax
  2c08ad:	74 32                	je     2c08e1 <heap_info+0xdf>
  2c08af:	85 db                	test   %ebx,%ebx
  2c08b1:	7e 2e                	jle    2c08e1 <heap_info+0xdf>
    int count = 0;
  2c08b3:	ba 00 00 00 00       	mov    $0x0,%edx
  2c08b8:	eb 15                	jmp    2c08cf <heap_info+0xcd>
        if (temp->alloc == 1)
        {
            ptr_array[count] = temp;
            count += 1;
        }
        temp = temp->next_alloc_block;
  2c08ba:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL && (count < num_allocs))
  2c08be:	48 85 c0             	test   %rax,%rax
  2c08c1:	0f 84 a3 00 00 00    	je     2c096a <heap_info+0x168>
  2c08c7:	39 d3                	cmp    %edx,%ebx
  2c08c9:	0f 8e 9b 00 00 00    	jle    2c096a <heap_info+0x168>
        if (temp->alloc == 1)
  2c08cf:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  2c08d3:	75 e5                	jne    2c08ba <heap_info+0xb8>
            ptr_array[count] = temp;
  2c08d5:	48 63 ca             	movslq %edx,%rcx
  2c08d8:	49 89 04 cc          	mov    %rax,(%r12,%rcx,8)
            count += 1;
  2c08dc:	83 c2 01             	add    $0x1,%edx
  2c08df:	eb d9                	jmp    2c08ba <heap_info+0xb8>
    }
    // Sort ptr_array in descending order
    merge_sort(ptr_array, num_allocs);
  2c08e1:	89 de                	mov    %ebx,%esi
  2c08e3:	4c 89 e7             	mov    %r12,%rdi
  2c08e6:	e8 3f fc ff ff       	call   2c052a <merge_sort>
    // Create "size_array"
    long* size_array = malloc(sizeof(long) * num_allocs);
  2c08eb:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  2c08ef:	e8 5f fd ff ff       	call   2c0653 <malloc>
    if (size_array == NULL)
  2c08f4:	48 85 c0             	test   %rax,%rax
  2c08f7:	74 17                	je     2c0910 <heap_info+0x10e>
    {
        return -1;
    }
    for(int i = 0; i < num_allocs; i++)
  2c08f9:	85 db                	test   %ebx,%ebx
  2c08fb:	0f 8f 81 00 00 00    	jg     2c0982 <heap_info+0x180>
  2c0901:	e9 95 00 00 00       	jmp    2c099b <heap_info+0x199>
        return -1;
  2c0906:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c090b:	e9 a3 00 00 00       	jmp    2c09b3 <heap_info+0x1b1>
        return -1;
  2c0910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0915:	e9 99 00 00 00       	jmp    2c09b3 <heap_info+0x1b1>
        return -1;
  2c091a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c091f:	e9 8f 00 00 00       	jmp    2c09b3 <heap_info+0x1b1>
        return -1;
  2c0924:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0929:	e9 85 00 00 00       	jmp    2c09b3 <heap_info+0x1b1>
  2c092e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0933:	eb 7e                	jmp    2c09b3 <heap_info+0x1b1>
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  2c0935:	bf 00 00 00 00       	mov    $0x0,%edi
  2c093a:	e8 14 fd ff ff       	call   2c0653 <malloc>
  2c093f:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  2c0942:	48 85 c0             	test   %rax,%rax
  2c0945:	74 d3                	je     2c091a <heap_info+0x118>
    merge_sort(ptr_array, num_allocs);
  2c0947:	be 00 00 00 00       	mov    $0x0,%esi
  2c094c:	48 89 c7             	mov    %rax,%rdi
  2c094f:	e8 d6 fb ff ff       	call   2c052a <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  2c0954:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0959:	e8 f5 fc ff ff       	call   2c0653 <malloc>
    if (size_array == NULL)
  2c095e:	48 85 c0             	test   %rax,%rax
  2c0961:	74 cb                	je     2c092e <heap_info+0x12c>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  2c0963:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0968:	eb 31                	jmp    2c099b <heap_info+0x199>
    merge_sort(ptr_array, num_allocs);
  2c096a:	89 de                	mov    %ebx,%esi
  2c096c:	4c 89 e7             	mov    %r12,%rdi
  2c096f:	e8 b6 fb ff ff       	call   2c052a <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  2c0974:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  2c0978:	e8 d6 fc ff ff       	call   2c0653 <malloc>
    if (size_array == NULL)
  2c097d:	48 85 c0             	test   %rax,%rax
  2c0980:	74 a2                	je     2c0924 <heap_info+0x122>
    int count = 0;
  2c0982:	ba 00 00 00 00       	mov    $0x0,%edx
    {
        size_array[i] = (long)ptr_array[i]->size;
  2c0987:	49 8b 0c d4          	mov    (%r12,%rdx,8),%rcx
  2c098b:	48 8b 49 10          	mov    0x10(%rcx),%rcx
  2c098f:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    for(int i = 0; i < num_allocs; i++)
  2c0993:	48 83 c2 01          	add    $0x1,%rdx
  2c0997:	39 d3                	cmp    %edx,%ebx
  2c0999:	7f ec                	jg     2c0987 <heap_info+0x185>
    }
    // Assign values to heap_info_struct
    info->num_allocs = num_allocs;
  2c099b:	41 89 1f             	mov    %ebx,(%r15)
    info->size_array = size_array;
  2c099e:	49 89 47 08          	mov    %rax,0x8(%r15)
    info->ptr_array = (void**)ptr_array;
  2c09a2:	4d 89 67 10          	mov    %r12,0x10(%r15)
    info->free_space = free_space;
  2c09a6:	45 89 77 18          	mov    %r14d,0x18(%r15)
    info->largest_free_chunk = largest_free_chunk;
  2c09aa:	45 89 6f 1c          	mov    %r13d,0x1c(%r15)
    return 0;
  2c09ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c09b3:	48 83 c4 18          	add    $0x18,%rsp
  2c09b7:	5b                   	pop    %rbx
  2c09b8:	41 5c                	pop    %r12
  2c09ba:	41 5d                	pop    %r13
  2c09bc:	41 5e                	pop    %r14
  2c09be:	41 5f                	pop    %r15
  2c09c0:	5d                   	pop    %rbp
  2c09c1:	c3                   	ret    

00000000002c09c2 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c09c2:	55                   	push   %rbp
  2c09c3:	48 89 e5             	mov    %rsp,%rbp
  2c09c6:	48 83 ec 28          	sub    $0x28,%rsp
  2c09ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c09d2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c09d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c09da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c09de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c09e2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c09e6:	eb 1c                	jmp    2c0a04 <memcpy+0x42>
        *d = *s;
  2c09e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09ec:	0f b6 10             	movzbl (%rax),%edx
  2c09ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09f3:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c09f5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c09fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c09ff:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0a04:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0a09:	75 dd                	jne    2c09e8 <memcpy+0x26>
    }
    return dst;
  2c0a0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a0f:	c9                   	leave  
  2c0a10:	c3                   	ret    

00000000002c0a11 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0a11:	55                   	push   %rbp
  2c0a12:	48 89 e5             	mov    %rsp,%rbp
  2c0a15:	48 83 ec 28          	sub    $0x28,%rsp
  2c0a19:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a1d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0a21:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0a25:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0a29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c0a2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0a35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a39:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c0a3d:	73 6a                	jae    2c0aa9 <memmove+0x98>
  2c0a3f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0a43:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a47:	48 01 d0             	add    %rdx,%rax
  2c0a4a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c0a4e:	73 59                	jae    2c0aa9 <memmove+0x98>
        s += n, d += n;
  2c0a50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a54:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0a58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a5c:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0a60:	eb 17                	jmp    2c0a79 <memmove+0x68>
            *--d = *--s;
  2c0a62:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0a67:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c0a6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a70:	0f b6 10             	movzbl (%rax),%edx
  2c0a73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a77:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0a79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0a7d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0a81:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0a85:	48 85 c0             	test   %rax,%rax
  2c0a88:	75 d8                	jne    2c0a62 <memmove+0x51>
    if (s < d && s + n > d) {
  2c0a8a:	eb 2e                	jmp    2c0aba <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c0a8c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0a90:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0a94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0a98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0a9c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0aa0:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c0aa4:	0f b6 12             	movzbl (%rdx),%edx
  2c0aa7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0aa9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0aad:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0ab1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0ab5:	48 85 c0             	test   %rax,%rax
  2c0ab8:	75 d2                	jne    2c0a8c <memmove+0x7b>
        }
    }
    return dst;
  2c0aba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0abe:	c9                   	leave  
  2c0abf:	c3                   	ret    

00000000002c0ac0 <memset>:

void* memset(void* v, int c, size_t n) {
  2c0ac0:	55                   	push   %rbp
  2c0ac1:	48 89 e5             	mov    %rsp,%rbp
  2c0ac4:	48 83 ec 28          	sub    $0x28,%rsp
  2c0ac8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0acc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c0acf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0ad3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0ad7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c0adb:	eb 15                	jmp    2c0af2 <memset+0x32>
        *p = c;
  2c0add:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c0ae0:	89 c2                	mov    %eax,%edx
  2c0ae2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ae6:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0ae8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0aed:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0af2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0af7:	75 e4                	jne    2c0add <memset+0x1d>
    }
    return v;
  2c0af9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0afd:	c9                   	leave  
  2c0afe:	c3                   	ret    

00000000002c0aff <strlen>:

size_t strlen(const char* s) {
  2c0aff:	55                   	push   %rbp
  2c0b00:	48 89 e5             	mov    %rsp,%rbp
  2c0b03:	48 83 ec 18          	sub    $0x18,%rsp
  2c0b07:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0b0b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b12:	00 
  2c0b13:	eb 0a                	jmp    2c0b1f <strlen+0x20>
        ++n;
  2c0b15:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0b1a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0b1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b23:	0f b6 00             	movzbl (%rax),%eax
  2c0b26:	84 c0                	test   %al,%al
  2c0b28:	75 eb                	jne    2c0b15 <strlen+0x16>
    }
    return n;
  2c0b2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0b2e:	c9                   	leave  
  2c0b2f:	c3                   	ret    

00000000002c0b30 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0b30:	55                   	push   %rbp
  2c0b31:	48 89 e5             	mov    %rsp,%rbp
  2c0b34:	48 83 ec 20          	sub    $0x20,%rsp
  2c0b38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b3c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b40:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0b47:	00 
  2c0b48:	eb 0a                	jmp    2c0b54 <strnlen+0x24>
        ++n;
  2c0b4a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0b4f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b58:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0b5c:	74 0b                	je     2c0b69 <strnlen+0x39>
  2c0b5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b62:	0f b6 00             	movzbl (%rax),%eax
  2c0b65:	84 c0                	test   %al,%al
  2c0b67:	75 e1                	jne    2c0b4a <strnlen+0x1a>
    }
    return n;
  2c0b69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0b6d:	c9                   	leave  
  2c0b6e:	c3                   	ret    

00000000002c0b6f <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0b6f:	55                   	push   %rbp
  2c0b70:	48 89 e5             	mov    %rsp,%rbp
  2c0b73:	48 83 ec 20          	sub    $0x20,%rsp
  2c0b77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0b7b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0b7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0b83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0b87:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0b8b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0b8f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0b93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b97:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0b9b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0b9f:	0f b6 12             	movzbl (%rdx),%edx
  2c0ba2:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0ba4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ba8:	48 83 e8 01          	sub    $0x1,%rax
  2c0bac:	0f b6 00             	movzbl (%rax),%eax
  2c0baf:	84 c0                	test   %al,%al
  2c0bb1:	75 d4                	jne    2c0b87 <strcpy+0x18>
    return dst;
  2c0bb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0bb7:	c9                   	leave  
  2c0bb8:	c3                   	ret    

00000000002c0bb9 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0bb9:	55                   	push   %rbp
  2c0bba:	48 89 e5             	mov    %rsp,%rbp
  2c0bbd:	48 83 ec 10          	sub    $0x10,%rsp
  2c0bc1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0bc5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0bc9:	eb 0a                	jmp    2c0bd5 <strcmp+0x1c>
        ++a, ++b;
  2c0bcb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0bd0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0bd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bd9:	0f b6 00             	movzbl (%rax),%eax
  2c0bdc:	84 c0                	test   %al,%al
  2c0bde:	74 1d                	je     2c0bfd <strcmp+0x44>
  2c0be0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0be4:	0f b6 00             	movzbl (%rax),%eax
  2c0be7:	84 c0                	test   %al,%al
  2c0be9:	74 12                	je     2c0bfd <strcmp+0x44>
  2c0beb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0bef:	0f b6 10             	movzbl (%rax),%edx
  2c0bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0bf6:	0f b6 00             	movzbl (%rax),%eax
  2c0bf9:	38 c2                	cmp    %al,%dl
  2c0bfb:	74 ce                	je     2c0bcb <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c01:	0f b6 00             	movzbl (%rax),%eax
  2c0c04:	89 c2                	mov    %eax,%edx
  2c0c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c0a:	0f b6 00             	movzbl (%rax),%eax
  2c0c0d:	38 d0                	cmp    %dl,%al
  2c0c0f:	0f 92 c0             	setb   %al
  2c0c12:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0c15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c19:	0f b6 00             	movzbl (%rax),%eax
  2c0c1c:	89 c1                	mov    %eax,%ecx
  2c0c1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0c22:	0f b6 00             	movzbl (%rax),%eax
  2c0c25:	38 c1                	cmp    %al,%cl
  2c0c27:	0f 92 c0             	setb   %al
  2c0c2a:	0f b6 c0             	movzbl %al,%eax
  2c0c2d:	29 c2                	sub    %eax,%edx
  2c0c2f:	89 d0                	mov    %edx,%eax
}
  2c0c31:	c9                   	leave  
  2c0c32:	c3                   	ret    

00000000002c0c33 <strchr>:

char* strchr(const char* s, int c) {
  2c0c33:	55                   	push   %rbp
  2c0c34:	48 89 e5             	mov    %rsp,%rbp
  2c0c37:	48 83 ec 10          	sub    $0x10,%rsp
  2c0c3b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0c3f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0c42:	eb 05                	jmp    2c0c49 <strchr+0x16>
        ++s;
  2c0c44:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0c49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c4d:	0f b6 00             	movzbl (%rax),%eax
  2c0c50:	84 c0                	test   %al,%al
  2c0c52:	74 0e                	je     2c0c62 <strchr+0x2f>
  2c0c54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c58:	0f b6 00             	movzbl (%rax),%eax
  2c0c5b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0c5e:	38 d0                	cmp    %dl,%al
  2c0c60:	75 e2                	jne    2c0c44 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c66:	0f b6 00             	movzbl (%rax),%eax
  2c0c69:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0c6c:	38 d0                	cmp    %dl,%al
  2c0c6e:	75 06                	jne    2c0c76 <strchr+0x43>
        return (char*) s;
  2c0c70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c74:	eb 05                	jmp    2c0c7b <strchr+0x48>
    } else {
        return NULL;
  2c0c76:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0c7b:	c9                   	leave  
  2c0c7c:	c3                   	ret    

00000000002c0c7d <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0c7d:	55                   	push   %rbp
  2c0c7e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0c81:	8b 05 a1 13 00 00    	mov    0x13a1(%rip),%eax        # 2c2028 <rand_seed_set>
  2c0c87:	85 c0                	test   %eax,%eax
  2c0c89:	75 0a                	jne    2c0c95 <rand+0x18>
        srand(819234718U);
  2c0c8b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0c90:	e8 24 00 00 00       	call   2c0cb9 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0c95:	8b 05 91 13 00 00    	mov    0x1391(%rip),%eax        # 2c202c <rand_seed>
  2c0c9b:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0ca1:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0ca6:	89 05 80 13 00 00    	mov    %eax,0x1380(%rip)        # 2c202c <rand_seed>
    return rand_seed & RAND_MAX;
  2c0cac:	8b 05 7a 13 00 00    	mov    0x137a(%rip),%eax        # 2c202c <rand_seed>
  2c0cb2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0cb7:	5d                   	pop    %rbp
  2c0cb8:	c3                   	ret    

00000000002c0cb9 <srand>:

void srand(unsigned seed) {
  2c0cb9:	55                   	push   %rbp
  2c0cba:	48 89 e5             	mov    %rsp,%rbp
  2c0cbd:	48 83 ec 08          	sub    $0x8,%rsp
  2c0cc1:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0cc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0cc7:	89 05 5f 13 00 00    	mov    %eax,0x135f(%rip)        # 2c202c <rand_seed>
    rand_seed_set = 1;
  2c0ccd:	c7 05 51 13 00 00 01 	movl   $0x1,0x1351(%rip)        # 2c2028 <rand_seed_set>
  2c0cd4:	00 00 00 
}
  2c0cd7:	90                   	nop
  2c0cd8:	c9                   	leave  
  2c0cd9:	c3                   	ret    

00000000002c0cda <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0cda:	55                   	push   %rbp
  2c0cdb:	48 89 e5             	mov    %rsp,%rbp
  2c0cde:	48 83 ec 28          	sub    $0x28,%rsp
  2c0ce2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0ce6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0cea:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0ced:	48 c7 45 f8 f0 1c 2c 	movq   $0x2c1cf0,-0x8(%rbp)
  2c0cf4:	00 
    if (base < 0) {
  2c0cf5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0cf9:	79 0b                	jns    2c0d06 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0cfb:	48 c7 45 f8 10 1d 2c 	movq   $0x2c1d10,-0x8(%rbp)
  2c0d02:	00 
        base = -base;
  2c0d03:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0d06:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d0f:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0d12:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d15:	48 63 c8             	movslq %eax,%rcx
  2c0d18:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d1c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d21:	48 f7 f1             	div    %rcx
  2c0d24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0d28:	48 01 d0             	add    %rdx,%rax
  2c0d2b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0d30:	0f b6 10             	movzbl (%rax),%edx
  2c0d33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0d37:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0d39:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0d3c:	48 63 f0             	movslq %eax,%rsi
  2c0d3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0d43:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0d48:	48 f7 f6             	div    %rsi
  2c0d4b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0d4f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0d54:	75 bc                	jne    2c0d12 <fill_numbuf+0x38>
    return numbuf_end;
  2c0d56:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0d5a:	c9                   	leave  
  2c0d5b:	c3                   	ret    

00000000002c0d5c <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0d5c:	55                   	push   %rbp
  2c0d5d:	48 89 e5             	mov    %rsp,%rbp
  2c0d60:	53                   	push   %rbx
  2c0d61:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0d68:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0d6f:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0d75:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0d7c:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0d83:	e9 8a 09 00 00       	jmp    2c1712 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0d88:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d8f:	0f b6 00             	movzbl (%rax),%eax
  2c0d92:	3c 25                	cmp    $0x25,%al
  2c0d94:	74 31                	je     2c0dc7 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0d96:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0d9d:	4c 8b 00             	mov    (%rax),%r8
  2c0da0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0da7:	0f b6 00             	movzbl (%rax),%eax
  2c0daa:	0f b6 c8             	movzbl %al,%ecx
  2c0dad:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0db3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0dba:	89 ce                	mov    %ecx,%esi
  2c0dbc:	48 89 c7             	mov    %rax,%rdi
  2c0dbf:	41 ff d0             	call   *%r8
            continue;
  2c0dc2:	e9 43 09 00 00       	jmp    2c170a <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0dc7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0dce:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0dd5:	01 
  2c0dd6:	eb 44                	jmp    2c0e1c <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0dd8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ddf:	0f b6 00             	movzbl (%rax),%eax
  2c0de2:	0f be c0             	movsbl %al,%eax
  2c0de5:	89 c6                	mov    %eax,%esi
  2c0de7:	bf 10 1b 2c 00       	mov    $0x2c1b10,%edi
  2c0dec:	e8 42 fe ff ff       	call   2c0c33 <strchr>
  2c0df1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0df5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0dfa:	74 30                	je     2c0e2c <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0dfc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0e00:	48 2d 10 1b 2c 00    	sub    $0x2c1b10,%rax
  2c0e06:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0e0b:	89 c1                	mov    %eax,%ecx
  2c0e0d:	d3 e2                	shl    %cl,%edx
  2c0e0f:	89 d0                	mov    %edx,%eax
  2c0e11:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0e14:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e1b:	01 
  2c0e1c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e23:	0f b6 00             	movzbl (%rax),%eax
  2c0e26:	84 c0                	test   %al,%al
  2c0e28:	75 ae                	jne    2c0dd8 <printer_vprintf+0x7c>
  2c0e2a:	eb 01                	jmp    2c0e2d <printer_vprintf+0xd1>
            } else {
                break;
  2c0e2c:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0e2d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0e34:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e3b:	0f b6 00             	movzbl (%rax),%eax
  2c0e3e:	3c 30                	cmp    $0x30,%al
  2c0e40:	7e 67                	jle    2c0ea9 <printer_vprintf+0x14d>
  2c0e42:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e49:	0f b6 00             	movzbl (%rax),%eax
  2c0e4c:	3c 39                	cmp    $0x39,%al
  2c0e4e:	7f 59                	jg     2c0ea9 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0e50:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0e57:	eb 2e                	jmp    2c0e87 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0e59:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0e5c:	89 d0                	mov    %edx,%eax
  2c0e5e:	c1 e0 02             	shl    $0x2,%eax
  2c0e61:	01 d0                	add    %edx,%eax
  2c0e63:	01 c0                	add    %eax,%eax
  2c0e65:	89 c1                	mov    %eax,%ecx
  2c0e67:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e6e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0e72:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0e79:	0f b6 00             	movzbl (%rax),%eax
  2c0e7c:	0f be c0             	movsbl %al,%eax
  2c0e7f:	01 c8                	add    %ecx,%eax
  2c0e81:	83 e8 30             	sub    $0x30,%eax
  2c0e84:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0e87:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e8e:	0f b6 00             	movzbl (%rax),%eax
  2c0e91:	3c 2f                	cmp    $0x2f,%al
  2c0e93:	0f 8e 85 00 00 00    	jle    2c0f1e <printer_vprintf+0x1c2>
  2c0e99:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ea0:	0f b6 00             	movzbl (%rax),%eax
  2c0ea3:	3c 39                	cmp    $0x39,%al
  2c0ea5:	7e b2                	jle    2c0e59 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0ea7:	eb 75                	jmp    2c0f1e <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0ea9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0eb0:	0f b6 00             	movzbl (%rax),%eax
  2c0eb3:	3c 2a                	cmp    $0x2a,%al
  2c0eb5:	75 68                	jne    2c0f1f <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0eb7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ebe:	8b 00                	mov    (%rax),%eax
  2c0ec0:	83 f8 2f             	cmp    $0x2f,%eax
  2c0ec3:	77 30                	ja     2c0ef5 <printer_vprintf+0x199>
  2c0ec5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ecc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0ed0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ed7:	8b 00                	mov    (%rax),%eax
  2c0ed9:	89 c0                	mov    %eax,%eax
  2c0edb:	48 01 d0             	add    %rdx,%rax
  2c0ede:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ee5:	8b 12                	mov    (%rdx),%edx
  2c0ee7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0eea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ef1:	89 0a                	mov    %ecx,(%rdx)
  2c0ef3:	eb 1a                	jmp    2c0f0f <printer_vprintf+0x1b3>
  2c0ef5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0efc:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f00:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f04:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f0b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f0f:	8b 00                	mov    (%rax),%eax
  2c0f11:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0f14:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f1b:	01 
  2c0f1c:	eb 01                	jmp    2c0f1f <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0f1e:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0f1f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0f26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f2d:	0f b6 00             	movzbl (%rax),%eax
  2c0f30:	3c 2e                	cmp    $0x2e,%al
  2c0f32:	0f 85 00 01 00 00    	jne    2c1038 <printer_vprintf+0x2dc>
            ++format;
  2c0f38:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f3f:	01 
            if (*format >= '0' && *format <= '9') {
  2c0f40:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f47:	0f b6 00             	movzbl (%rax),%eax
  2c0f4a:	3c 2f                	cmp    $0x2f,%al
  2c0f4c:	7e 67                	jle    2c0fb5 <printer_vprintf+0x259>
  2c0f4e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f55:	0f b6 00             	movzbl (%rax),%eax
  2c0f58:	3c 39                	cmp    $0x39,%al
  2c0f5a:	7f 59                	jg     2c0fb5 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0f5c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0f63:	eb 2e                	jmp    2c0f93 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0f65:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0f68:	89 d0                	mov    %edx,%eax
  2c0f6a:	c1 e0 02             	shl    $0x2,%eax
  2c0f6d:	01 d0                	add    %edx,%eax
  2c0f6f:	01 c0                	add    %eax,%eax
  2c0f71:	89 c1                	mov    %eax,%ecx
  2c0f73:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f7a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0f7e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0f85:	0f b6 00             	movzbl (%rax),%eax
  2c0f88:	0f be c0             	movsbl %al,%eax
  2c0f8b:	01 c8                	add    %ecx,%eax
  2c0f8d:	83 e8 30             	sub    $0x30,%eax
  2c0f90:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0f93:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f9a:	0f b6 00             	movzbl (%rax),%eax
  2c0f9d:	3c 2f                	cmp    $0x2f,%al
  2c0f9f:	0f 8e 85 00 00 00    	jle    2c102a <printer_vprintf+0x2ce>
  2c0fa5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fac:	0f b6 00             	movzbl (%rax),%eax
  2c0faf:	3c 39                	cmp    $0x39,%al
  2c0fb1:	7e b2                	jle    2c0f65 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0fb3:	eb 75                	jmp    2c102a <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0fb5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0fbc:	0f b6 00             	movzbl (%rax),%eax
  2c0fbf:	3c 2a                	cmp    $0x2a,%al
  2c0fc1:	75 68                	jne    2c102b <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0fc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fca:	8b 00                	mov    (%rax),%eax
  2c0fcc:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fcf:	77 30                	ja     2c1001 <printer_vprintf+0x2a5>
  2c0fd1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fd8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fdc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe3:	8b 00                	mov    (%rax),%eax
  2c0fe5:	89 c0                	mov    %eax,%eax
  2c0fe7:	48 01 d0             	add    %rdx,%rax
  2c0fea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ff1:	8b 12                	mov    (%rdx),%edx
  2c0ff3:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0ff6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ffd:	89 0a                	mov    %ecx,(%rdx)
  2c0fff:	eb 1a                	jmp    2c101b <printer_vprintf+0x2bf>
  2c1001:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1008:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c100c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1010:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1017:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c101b:	8b 00                	mov    (%rax),%eax
  2c101d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c1020:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1027:	01 
  2c1028:	eb 01                	jmp    2c102b <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c102a:	90                   	nop
            }
            if (precision < 0) {
  2c102b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c102f:	79 07                	jns    2c1038 <printer_vprintf+0x2dc>
                precision = 0;
  2c1031:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c1038:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c103f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c1046:	00 
        int length = 0;
  2c1047:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c104e:	48 c7 45 c8 16 1b 2c 	movq   $0x2c1b16,-0x38(%rbp)
  2c1055:	00 
    again:
        switch (*format) {
  2c1056:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c105d:	0f b6 00             	movzbl (%rax),%eax
  2c1060:	0f be c0             	movsbl %al,%eax
  2c1063:	83 e8 43             	sub    $0x43,%eax
  2c1066:	83 f8 37             	cmp    $0x37,%eax
  2c1069:	0f 87 9f 03 00 00    	ja     2c140e <printer_vprintf+0x6b2>
  2c106f:	89 c0                	mov    %eax,%eax
  2c1071:	48 8b 04 c5 28 1b 2c 	mov    0x2c1b28(,%rax,8),%rax
  2c1078:	00 
  2c1079:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c107b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c1082:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1089:	01 
            goto again;
  2c108a:	eb ca                	jmp    2c1056 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c108c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1090:	74 5d                	je     2c10ef <printer_vprintf+0x393>
  2c1092:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1099:	8b 00                	mov    (%rax),%eax
  2c109b:	83 f8 2f             	cmp    $0x2f,%eax
  2c109e:	77 30                	ja     2c10d0 <printer_vprintf+0x374>
  2c10a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10b2:	8b 00                	mov    (%rax),%eax
  2c10b4:	89 c0                	mov    %eax,%eax
  2c10b6:	48 01 d0             	add    %rdx,%rax
  2c10b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10c0:	8b 12                	mov    (%rdx),%edx
  2c10c2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10cc:	89 0a                	mov    %ecx,(%rdx)
  2c10ce:	eb 1a                	jmp    2c10ea <printer_vprintf+0x38e>
  2c10d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10d7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10db:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10e6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10ea:	48 8b 00             	mov    (%rax),%rax
  2c10ed:	eb 5c                	jmp    2c114b <printer_vprintf+0x3ef>
  2c10ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10f6:	8b 00                	mov    (%rax),%eax
  2c10f8:	83 f8 2f             	cmp    $0x2f,%eax
  2c10fb:	77 30                	ja     2c112d <printer_vprintf+0x3d1>
  2c10fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1104:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1108:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c110f:	8b 00                	mov    (%rax),%eax
  2c1111:	89 c0                	mov    %eax,%eax
  2c1113:	48 01 d0             	add    %rdx,%rax
  2c1116:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c111d:	8b 12                	mov    (%rdx),%edx
  2c111f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1122:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1129:	89 0a                	mov    %ecx,(%rdx)
  2c112b:	eb 1a                	jmp    2c1147 <printer_vprintf+0x3eb>
  2c112d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1134:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1138:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c113c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1143:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1147:	8b 00                	mov    (%rax),%eax
  2c1149:	48 98                	cltq   
  2c114b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c114f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1153:	48 c1 f8 38          	sar    $0x38,%rax
  2c1157:	25 80 00 00 00       	and    $0x80,%eax
  2c115c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c115f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1163:	74 09                	je     2c116e <printer_vprintf+0x412>
  2c1165:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1169:	48 f7 d8             	neg    %rax
  2c116c:	eb 04                	jmp    2c1172 <printer_vprintf+0x416>
  2c116e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1172:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c1176:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c1179:	83 c8 60             	or     $0x60,%eax
  2c117c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c117f:	e9 cf 02 00 00       	jmp    2c1453 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1184:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1188:	74 5d                	je     2c11e7 <printer_vprintf+0x48b>
  2c118a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1191:	8b 00                	mov    (%rax),%eax
  2c1193:	83 f8 2f             	cmp    $0x2f,%eax
  2c1196:	77 30                	ja     2c11c8 <printer_vprintf+0x46c>
  2c1198:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c119f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c11a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11aa:	8b 00                	mov    (%rax),%eax
  2c11ac:	89 c0                	mov    %eax,%eax
  2c11ae:	48 01 d0             	add    %rdx,%rax
  2c11b1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11b8:	8b 12                	mov    (%rdx),%edx
  2c11ba:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11c4:	89 0a                	mov    %ecx,(%rdx)
  2c11c6:	eb 1a                	jmp    2c11e2 <printer_vprintf+0x486>
  2c11c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11cf:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11d3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11de:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11e2:	48 8b 00             	mov    (%rax),%rax
  2c11e5:	eb 5c                	jmp    2c1243 <printer_vprintf+0x4e7>
  2c11e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11ee:	8b 00                	mov    (%rax),%eax
  2c11f0:	83 f8 2f             	cmp    $0x2f,%eax
  2c11f3:	77 30                	ja     2c1225 <printer_vprintf+0x4c9>
  2c11f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11fc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1200:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1207:	8b 00                	mov    (%rax),%eax
  2c1209:	89 c0                	mov    %eax,%eax
  2c120b:	48 01 d0             	add    %rdx,%rax
  2c120e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1215:	8b 12                	mov    (%rdx),%edx
  2c1217:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c121a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1221:	89 0a                	mov    %ecx,(%rdx)
  2c1223:	eb 1a                	jmp    2c123f <printer_vprintf+0x4e3>
  2c1225:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c122c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1230:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1234:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c123b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c123f:	8b 00                	mov    (%rax),%eax
  2c1241:	89 c0                	mov    %eax,%eax
  2c1243:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c1247:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c124b:	e9 03 02 00 00       	jmp    2c1453 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c1250:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c1257:	e9 28 ff ff ff       	jmp    2c1184 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c125c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1263:	e9 1c ff ff ff       	jmp    2c1184 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c1268:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c126f:	8b 00                	mov    (%rax),%eax
  2c1271:	83 f8 2f             	cmp    $0x2f,%eax
  2c1274:	77 30                	ja     2c12a6 <printer_vprintf+0x54a>
  2c1276:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c127d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1281:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1288:	8b 00                	mov    (%rax),%eax
  2c128a:	89 c0                	mov    %eax,%eax
  2c128c:	48 01 d0             	add    %rdx,%rax
  2c128f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1296:	8b 12                	mov    (%rdx),%edx
  2c1298:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c129b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12a2:	89 0a                	mov    %ecx,(%rdx)
  2c12a4:	eb 1a                	jmp    2c12c0 <printer_vprintf+0x564>
  2c12a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12ad:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c12b1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c12b5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12c0:	48 8b 00             	mov    (%rax),%rax
  2c12c3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c12c7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c12ce:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c12d5:	e9 79 01 00 00       	jmp    2c1453 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c12da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12e1:	8b 00                	mov    (%rax),%eax
  2c12e3:	83 f8 2f             	cmp    $0x2f,%eax
  2c12e6:	77 30                	ja     2c1318 <printer_vprintf+0x5bc>
  2c12e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12ef:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c12f3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12fa:	8b 00                	mov    (%rax),%eax
  2c12fc:	89 c0                	mov    %eax,%eax
  2c12fe:	48 01 d0             	add    %rdx,%rax
  2c1301:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1308:	8b 12                	mov    (%rdx),%edx
  2c130a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c130d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1314:	89 0a                	mov    %ecx,(%rdx)
  2c1316:	eb 1a                	jmp    2c1332 <printer_vprintf+0x5d6>
  2c1318:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c131f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1323:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1327:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c132e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1332:	48 8b 00             	mov    (%rax),%rax
  2c1335:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1339:	e9 15 01 00 00       	jmp    2c1453 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c133e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1345:	8b 00                	mov    (%rax),%eax
  2c1347:	83 f8 2f             	cmp    $0x2f,%eax
  2c134a:	77 30                	ja     2c137c <printer_vprintf+0x620>
  2c134c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1353:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1357:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c135e:	8b 00                	mov    (%rax),%eax
  2c1360:	89 c0                	mov    %eax,%eax
  2c1362:	48 01 d0             	add    %rdx,%rax
  2c1365:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c136c:	8b 12                	mov    (%rdx),%edx
  2c136e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1371:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1378:	89 0a                	mov    %ecx,(%rdx)
  2c137a:	eb 1a                	jmp    2c1396 <printer_vprintf+0x63a>
  2c137c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1383:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1387:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c138b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1392:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1396:	8b 00                	mov    (%rax),%eax
  2c1398:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c139e:	e9 67 03 00 00       	jmp    2c170a <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c13a3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c13a7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c13ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13b2:	8b 00                	mov    (%rax),%eax
  2c13b4:	83 f8 2f             	cmp    $0x2f,%eax
  2c13b7:	77 30                	ja     2c13e9 <printer_vprintf+0x68d>
  2c13b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c13c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13cb:	8b 00                	mov    (%rax),%eax
  2c13cd:	89 c0                	mov    %eax,%eax
  2c13cf:	48 01 d0             	add    %rdx,%rax
  2c13d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13d9:	8b 12                	mov    (%rdx),%edx
  2c13db:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c13de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13e5:	89 0a                	mov    %ecx,(%rdx)
  2c13e7:	eb 1a                	jmp    2c1403 <printer_vprintf+0x6a7>
  2c13e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c13f0:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c13f4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c13f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c13ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1403:	8b 00                	mov    (%rax),%eax
  2c1405:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1408:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c140c:	eb 45                	jmp    2c1453 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c140e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1412:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1416:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c141d:	0f b6 00             	movzbl (%rax),%eax
  2c1420:	84 c0                	test   %al,%al
  2c1422:	74 0c                	je     2c1430 <printer_vprintf+0x6d4>
  2c1424:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c142b:	0f b6 00             	movzbl (%rax),%eax
  2c142e:	eb 05                	jmp    2c1435 <printer_vprintf+0x6d9>
  2c1430:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1435:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1438:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c143c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1443:	0f b6 00             	movzbl (%rax),%eax
  2c1446:	84 c0                	test   %al,%al
  2c1448:	75 08                	jne    2c1452 <printer_vprintf+0x6f6>
                format--;
  2c144a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1451:	01 
            }
            break;
  2c1452:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1453:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1456:	83 e0 20             	and    $0x20,%eax
  2c1459:	85 c0                	test   %eax,%eax
  2c145b:	74 1e                	je     2c147b <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c145d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1461:	48 83 c0 18          	add    $0x18,%rax
  2c1465:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1468:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c146c:	48 89 ce             	mov    %rcx,%rsi
  2c146f:	48 89 c7             	mov    %rax,%rdi
  2c1472:	e8 63 f8 ff ff       	call   2c0cda <fill_numbuf>
  2c1477:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c147b:	48 c7 45 c0 16 1b 2c 	movq   $0x2c1b16,-0x40(%rbp)
  2c1482:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1483:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1486:	83 e0 20             	and    $0x20,%eax
  2c1489:	85 c0                	test   %eax,%eax
  2c148b:	74 48                	je     2c14d5 <printer_vprintf+0x779>
  2c148d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1490:	83 e0 40             	and    $0x40,%eax
  2c1493:	85 c0                	test   %eax,%eax
  2c1495:	74 3e                	je     2c14d5 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c1497:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c149a:	25 80 00 00 00       	and    $0x80,%eax
  2c149f:	85 c0                	test   %eax,%eax
  2c14a1:	74 0a                	je     2c14ad <printer_vprintf+0x751>
                prefix = "-";
  2c14a3:	48 c7 45 c0 17 1b 2c 	movq   $0x2c1b17,-0x40(%rbp)
  2c14aa:	00 
            if (flags & FLAG_NEGATIVE) {
  2c14ab:	eb 73                	jmp    2c1520 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c14ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14b0:	83 e0 10             	and    $0x10,%eax
  2c14b3:	85 c0                	test   %eax,%eax
  2c14b5:	74 0a                	je     2c14c1 <printer_vprintf+0x765>
                prefix = "+";
  2c14b7:	48 c7 45 c0 19 1b 2c 	movq   $0x2c1b19,-0x40(%rbp)
  2c14be:	00 
            if (flags & FLAG_NEGATIVE) {
  2c14bf:	eb 5f                	jmp    2c1520 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c14c1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14c4:	83 e0 08             	and    $0x8,%eax
  2c14c7:	85 c0                	test   %eax,%eax
  2c14c9:	74 55                	je     2c1520 <printer_vprintf+0x7c4>
                prefix = " ";
  2c14cb:	48 c7 45 c0 1b 1b 2c 	movq   $0x2c1b1b,-0x40(%rbp)
  2c14d2:	00 
            if (flags & FLAG_NEGATIVE) {
  2c14d3:	eb 4b                	jmp    2c1520 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c14d5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14d8:	83 e0 20             	and    $0x20,%eax
  2c14db:	85 c0                	test   %eax,%eax
  2c14dd:	74 42                	je     2c1521 <printer_vprintf+0x7c5>
  2c14df:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14e2:	83 e0 01             	and    $0x1,%eax
  2c14e5:	85 c0                	test   %eax,%eax
  2c14e7:	74 38                	je     2c1521 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c14e9:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c14ed:	74 06                	je     2c14f5 <printer_vprintf+0x799>
  2c14ef:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c14f3:	75 2c                	jne    2c1521 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c14f5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c14fa:	75 0c                	jne    2c1508 <printer_vprintf+0x7ac>
  2c14fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14ff:	25 00 01 00 00       	and    $0x100,%eax
  2c1504:	85 c0                	test   %eax,%eax
  2c1506:	74 19                	je     2c1521 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1508:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c150c:	75 07                	jne    2c1515 <printer_vprintf+0x7b9>
  2c150e:	b8 1d 1b 2c 00       	mov    $0x2c1b1d,%eax
  2c1513:	eb 05                	jmp    2c151a <printer_vprintf+0x7be>
  2c1515:	b8 20 1b 2c 00       	mov    $0x2c1b20,%eax
  2c151a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c151e:	eb 01                	jmp    2c1521 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1520:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1521:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1525:	78 24                	js     2c154b <printer_vprintf+0x7ef>
  2c1527:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c152a:	83 e0 20             	and    $0x20,%eax
  2c152d:	85 c0                	test   %eax,%eax
  2c152f:	75 1a                	jne    2c154b <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1531:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1534:	48 63 d0             	movslq %eax,%rdx
  2c1537:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c153b:	48 89 d6             	mov    %rdx,%rsi
  2c153e:	48 89 c7             	mov    %rax,%rdi
  2c1541:	e8 ea f5 ff ff       	call   2c0b30 <strnlen>
  2c1546:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1549:	eb 0f                	jmp    2c155a <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c154b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c154f:	48 89 c7             	mov    %rax,%rdi
  2c1552:	e8 a8 f5 ff ff       	call   2c0aff <strlen>
  2c1557:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c155a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c155d:	83 e0 20             	and    $0x20,%eax
  2c1560:	85 c0                	test   %eax,%eax
  2c1562:	74 20                	je     2c1584 <printer_vprintf+0x828>
  2c1564:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1568:	78 1a                	js     2c1584 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c156a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c156d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1570:	7e 08                	jle    2c157a <printer_vprintf+0x81e>
  2c1572:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1575:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1578:	eb 05                	jmp    2c157f <printer_vprintf+0x823>
  2c157a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c157f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1582:	eb 5c                	jmp    2c15e0 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1584:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1587:	83 e0 20             	and    $0x20,%eax
  2c158a:	85 c0                	test   %eax,%eax
  2c158c:	74 4b                	je     2c15d9 <printer_vprintf+0x87d>
  2c158e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1591:	83 e0 02             	and    $0x2,%eax
  2c1594:	85 c0                	test   %eax,%eax
  2c1596:	74 41                	je     2c15d9 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c1598:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c159b:	83 e0 04             	and    $0x4,%eax
  2c159e:	85 c0                	test   %eax,%eax
  2c15a0:	75 37                	jne    2c15d9 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c15a2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c15a6:	48 89 c7             	mov    %rax,%rdi
  2c15a9:	e8 51 f5 ff ff       	call   2c0aff <strlen>
  2c15ae:	89 c2                	mov    %eax,%edx
  2c15b0:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c15b3:	01 d0                	add    %edx,%eax
  2c15b5:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c15b8:	7e 1f                	jle    2c15d9 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c15ba:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c15bd:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c15c0:	89 c3                	mov    %eax,%ebx
  2c15c2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c15c6:	48 89 c7             	mov    %rax,%rdi
  2c15c9:	e8 31 f5 ff ff       	call   2c0aff <strlen>
  2c15ce:	89 c2                	mov    %eax,%edx
  2c15d0:	89 d8                	mov    %ebx,%eax
  2c15d2:	29 d0                	sub    %edx,%eax
  2c15d4:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c15d7:	eb 07                	jmp    2c15e0 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c15d9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c15e0:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c15e3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c15e6:	01 d0                	add    %edx,%eax
  2c15e8:	48 63 d8             	movslq %eax,%rbx
  2c15eb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c15ef:	48 89 c7             	mov    %rax,%rdi
  2c15f2:	e8 08 f5 ff ff       	call   2c0aff <strlen>
  2c15f7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c15fb:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c15fe:	29 d0                	sub    %edx,%eax
  2c1600:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1603:	eb 25                	jmp    2c162a <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1605:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c160c:	48 8b 08             	mov    (%rax),%rcx
  2c160f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1615:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c161c:	be 20 00 00 00       	mov    $0x20,%esi
  2c1621:	48 89 c7             	mov    %rax,%rdi
  2c1624:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1626:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c162a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c162d:	83 e0 04             	and    $0x4,%eax
  2c1630:	85 c0                	test   %eax,%eax
  2c1632:	75 36                	jne    2c166a <printer_vprintf+0x90e>
  2c1634:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1638:	7f cb                	jg     2c1605 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c163a:	eb 2e                	jmp    2c166a <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c163c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1643:	4c 8b 00             	mov    (%rax),%r8
  2c1646:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c164a:	0f b6 00             	movzbl (%rax),%eax
  2c164d:	0f b6 c8             	movzbl %al,%ecx
  2c1650:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1656:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c165d:	89 ce                	mov    %ecx,%esi
  2c165f:	48 89 c7             	mov    %rax,%rdi
  2c1662:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1665:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c166a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c166e:	0f b6 00             	movzbl (%rax),%eax
  2c1671:	84 c0                	test   %al,%al
  2c1673:	75 c7                	jne    2c163c <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c1675:	eb 25                	jmp    2c169c <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1677:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c167e:	48 8b 08             	mov    (%rax),%rcx
  2c1681:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1687:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c168e:	be 30 00 00 00       	mov    $0x30,%esi
  2c1693:	48 89 c7             	mov    %rax,%rdi
  2c1696:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c1698:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c169c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c16a0:	7f d5                	jg     2c1677 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c16a2:	eb 32                	jmp    2c16d6 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c16a4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16ab:	4c 8b 00             	mov    (%rax),%r8
  2c16ae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c16b2:	0f b6 00             	movzbl (%rax),%eax
  2c16b5:	0f b6 c8             	movzbl %al,%ecx
  2c16b8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16c5:	89 ce                	mov    %ecx,%esi
  2c16c7:	48 89 c7             	mov    %rax,%rdi
  2c16ca:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c16cd:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c16d2:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c16d6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c16da:	7f c8                	jg     2c16a4 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c16dc:	eb 25                	jmp    2c1703 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c16de:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16e5:	48 8b 08             	mov    (%rax),%rcx
  2c16e8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c16ee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c16f5:	be 20 00 00 00       	mov    $0x20,%esi
  2c16fa:	48 89 c7             	mov    %rax,%rdi
  2c16fd:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c16ff:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1703:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1707:	7f d5                	jg     2c16de <printer_vprintf+0x982>
        }
    done: ;
  2c1709:	90                   	nop
    for (; *format; ++format) {
  2c170a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1711:	01 
  2c1712:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1719:	0f b6 00             	movzbl (%rax),%eax
  2c171c:	84 c0                	test   %al,%al
  2c171e:	0f 85 64 f6 ff ff    	jne    2c0d88 <printer_vprintf+0x2c>
    }
}
  2c1724:	90                   	nop
  2c1725:	90                   	nop
  2c1726:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c172a:	c9                   	leave  
  2c172b:	c3                   	ret    

00000000002c172c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c172c:	55                   	push   %rbp
  2c172d:	48 89 e5             	mov    %rsp,%rbp
  2c1730:	48 83 ec 20          	sub    $0x20,%rsp
  2c1734:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1738:	89 f0                	mov    %esi,%eax
  2c173a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c173d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1740:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1744:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1748:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c174c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1750:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1755:	48 39 d0             	cmp    %rdx,%rax
  2c1758:	72 0c                	jb     2c1766 <console_putc+0x3a>
        cp->cursor = console;
  2c175a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c175e:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1765:	00 
    }
    if (c == '\n') {
  2c1766:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c176a:	75 78                	jne    2c17e4 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c176c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1770:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1774:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c177a:	48 d1 f8             	sar    %rax
  2c177d:	48 89 c1             	mov    %rax,%rcx
  2c1780:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1787:	66 66 66 
  2c178a:	48 89 c8             	mov    %rcx,%rax
  2c178d:	48 f7 ea             	imul   %rdx
  2c1790:	48 c1 fa 05          	sar    $0x5,%rdx
  2c1794:	48 89 c8             	mov    %rcx,%rax
  2c1797:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c179b:	48 29 c2             	sub    %rax,%rdx
  2c179e:	48 89 d0             	mov    %rdx,%rax
  2c17a1:	48 c1 e0 02          	shl    $0x2,%rax
  2c17a5:	48 01 d0             	add    %rdx,%rax
  2c17a8:	48 c1 e0 04          	shl    $0x4,%rax
  2c17ac:	48 29 c1             	sub    %rax,%rcx
  2c17af:	48 89 ca             	mov    %rcx,%rdx
  2c17b2:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c17b5:	eb 25                	jmp    2c17dc <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c17b7:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c17ba:	83 c8 20             	or     $0x20,%eax
  2c17bd:	89 c6                	mov    %eax,%esi
  2c17bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17c3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17c7:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c17cb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c17cf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c17d3:	89 f2                	mov    %esi,%edx
  2c17d5:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c17d8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c17dc:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c17e0:	75 d5                	jne    2c17b7 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c17e2:	eb 24                	jmp    2c1808 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c17e4:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c17e8:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c17eb:	09 d0                	or     %edx,%eax
  2c17ed:	89 c6                	mov    %eax,%esi
  2c17ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c17f3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c17f7:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c17fb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c17ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1803:	89 f2                	mov    %esi,%edx
  2c1805:	66 89 10             	mov    %dx,(%rax)
}
  2c1808:	90                   	nop
  2c1809:	c9                   	leave  
  2c180a:	c3                   	ret    

00000000002c180b <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c180b:	55                   	push   %rbp
  2c180c:	48 89 e5             	mov    %rsp,%rbp
  2c180f:	48 83 ec 30          	sub    $0x30,%rsp
  2c1813:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1816:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1819:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c181d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1821:	48 c7 45 f0 2c 17 2c 	movq   $0x2c172c,-0x10(%rbp)
  2c1828:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1829:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c182d:	78 09                	js     2c1838 <console_vprintf+0x2d>
  2c182f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1836:	7e 07                	jle    2c183f <console_vprintf+0x34>
        cpos = 0;
  2c1838:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c183f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1842:	48 98                	cltq   
  2c1844:	48 01 c0             	add    %rax,%rax
  2c1847:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c184d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1851:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1855:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1859:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c185c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1860:	48 89 c7             	mov    %rax,%rdi
  2c1863:	e8 f4 f4 ff ff       	call   2c0d5c <printer_vprintf>
    return cp.cursor - console;
  2c1868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c186c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1872:	48 d1 f8             	sar    %rax
}
  2c1875:	c9                   	leave  
  2c1876:	c3                   	ret    

00000000002c1877 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1877:	55                   	push   %rbp
  2c1878:	48 89 e5             	mov    %rsp,%rbp
  2c187b:	48 83 ec 60          	sub    $0x60,%rsp
  2c187f:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1882:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1885:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1889:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c188d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c1891:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c1895:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c189c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c18a0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c18a4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c18a8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c18ac:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c18b0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c18b4:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c18b7:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c18ba:	89 c7                	mov    %eax,%edi
  2c18bc:	e8 4a ff ff ff       	call   2c180b <console_vprintf>
  2c18c1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c18c4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c18c7:	c9                   	leave  
  2c18c8:	c3                   	ret    

00000000002c18c9 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c18c9:	55                   	push   %rbp
  2c18ca:	48 89 e5             	mov    %rsp,%rbp
  2c18cd:	48 83 ec 20          	sub    $0x20,%rsp
  2c18d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c18d5:	89 f0                	mov    %esi,%eax
  2c18d7:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c18da:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c18dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c18e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c18e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c18e9:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c18ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c18f1:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c18f5:	48 39 c2             	cmp    %rax,%rdx
  2c18f8:	73 1a                	jae    2c1914 <string_putc+0x4b>
        *sp->s++ = c;
  2c18fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c18fe:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1902:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1906:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c190a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c190e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1912:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1914:	90                   	nop
  2c1915:	c9                   	leave  
  2c1916:	c3                   	ret    

00000000002c1917 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1917:	55                   	push   %rbp
  2c1918:	48 89 e5             	mov    %rsp,%rbp
  2c191b:	48 83 ec 40          	sub    $0x40,%rsp
  2c191f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1923:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1927:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c192b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c192f:	48 c7 45 e8 c9 18 2c 	movq   $0x2c18c9,-0x18(%rbp)
  2c1936:	00 
    sp.s = s;
  2c1937:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c193b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c193f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1944:	74 33                	je     2c1979 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1946:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c194a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c194e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1952:	48 01 d0             	add    %rdx,%rax
  2c1955:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1959:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c195d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1961:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1965:	be 00 00 00 00       	mov    $0x0,%esi
  2c196a:	48 89 c7             	mov    %rax,%rdi
  2c196d:	e8 ea f3 ff ff       	call   2c0d5c <printer_vprintf>
        *sp.s = 0;
  2c1972:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1976:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1979:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c197d:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1981:	c9                   	leave  
  2c1982:	c3                   	ret    

00000000002c1983 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1983:	55                   	push   %rbp
  2c1984:	48 89 e5             	mov    %rsp,%rbp
  2c1987:	48 83 ec 70          	sub    $0x70,%rsp
  2c198b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c198f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c1993:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c1997:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c199b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c199f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c19a3:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c19aa:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c19ae:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c19b2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c19b6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c19ba:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c19be:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c19c2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c19c6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c19ca:	48 89 c7             	mov    %rax,%rdi
  2c19cd:	e8 45 ff ff ff       	call   2c1917 <vsnprintf>
  2c19d2:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c19d5:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c19d8:	c9                   	leave  
  2c19d9:	c3                   	ret    

00000000002c19da <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c19da:	55                   	push   %rbp
  2c19db:	48 89 e5             	mov    %rsp,%rbp
  2c19de:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c19e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c19e9:	eb 13                	jmp    2c19fe <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c19eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c19ee:	48 98                	cltq   
  2c19f0:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c19f7:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c19fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c19fe:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1a05:	7e e4                	jle    2c19eb <console_clear+0x11>
    }
    cursorpos = 0;
  2c1a07:	c7 05 eb 75 df ff 00 	movl   $0x0,-0x208a15(%rip)        # b8ffc <cursorpos>
  2c1a0e:	00 00 00 
}
  2c1a11:	90                   	nop
  2c1a12:	c9                   	leave  
  2c1a13:	c3                   	ret    
