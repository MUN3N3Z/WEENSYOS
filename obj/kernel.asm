
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 d2 07 00 00       	call   40895 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 33 16 00 00       	call   417ab <hardware_init>
    pageinfo_init();
   40178:	e8 a7 0c 00 00       	call   40e24 <pageinfo_init>
    console_clear();
   4017d:	e8 0e 4c 00 00       	call   44d90 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 0b 1b 00 00       	call   41c97 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 00 05 00       	mov    $0x50000,%edi
   4019b:	e8 d6 3c 00 00       	call   43e76 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 00 05 00 	lea    0x50000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 06 4e 04 00       	mov    $0x44e06,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 64 3d 00 00       	call   43f6f <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 0d 4e 04 00       	mov    $0x44e0d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 34 3d 00 00       	call   43f6f <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be 18 4e 04 00       	mov    $0x44e18,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 07 3d 00 00       	call   43f6f <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be 1d 4e 04 00       	mov    $0x44e1d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 da 3c 00 00       	call   43f6f <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 00 05 00       	mov    $0x500f0,%edi
   402d1:	e8 bd 0a 00 00       	call   40d93 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 00 05 00    	add    $0x50000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 1d 1c 00 00       	call   41f28 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 2a 33 00 00       	call   4363f <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 28 4e 04 00       	mov    $0x44e28,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40328:	e8 c9 23 00 00       	call   426f6 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 00 05 00 	lea    0x50000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 38 36 00 00       	call   4398d <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 58 4e 04 00       	mov    $0x44e58,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40368:	e8 89 23 00 00       	call   426f6 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 00 05 00    	add    $0x50000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 36 36 00 00       	call   439c5 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 0f 05 00 	movb   $0x1,0x50f21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 0f 05 00 	mov    %dl,0x50f20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf 0a 01 00 	mov    0x10acf(%rip),%rax        # 50f00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 3f 36 00 00       	call   43a78 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba 0a 01 00 	mov    0x10aba(%rip),%rax        # 50f00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 0e 2f 00 00       	call   4335d <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b 0a 01 00 	mov    0x10a9b(%rip),%rax        # 50f00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 96 38 00 00       	call   43d0a <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <heap_manager_helper>:

/**
 * Helper function for sbrk() and brk() system calls
 * Increase/Decrease program_break 
*/
void heap_manager_helper(uintptr_t previous_break, uintptr_t new_program_break){
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 40          	sub    $0x40,%rsp
   4047e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40482:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    uintptr_t page_aligned_addr;
    // Heap increment
    if (new_program_break >= previous_break)
   40486:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4048a:	48 3b 45 c8          	cmp    -0x38(%rbp),%rax
   4048e:	72 14                	jb     404a4 <heap_manager_helper+0x2e>
    {
        // Set brk_process
        current->program_break = new_program_break;
   40490:	48 8b 05 69 0a 01 00 	mov    0x10a69(%rip),%rax        # 50f00 <current>
   40497:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4049b:	48 89 50 08          	mov    %rdx,0x8(%rax)

        }
        // Set new program break
        current->program_break = new_program_break;
    }
}
   4049f:	e9 f1 00 00 00       	jmp    40595 <heap_manager_helper+0x11f>
        if ((previous_break % PAGESIZE) != 0)
   404a4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404a8:	25 ff 0f 00 00       	and    $0xfff,%eax
   404ad:	48 85 c0             	test   %rax,%rax
   404b0:	74 10                	je     404c2 <heap_manager_helper+0x4c>
            page_aligned_addr = previous_break - (previous_break % PAGESIZE);
   404b2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404b6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   404bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   404c0:	eb 08                	jmp    404ca <heap_manager_helper+0x54>
            page_aligned_addr = previous_break;
   404c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        for (uintptr_t addr = page_aligned_addr; addr >= new_program_break; addr-=PAGESIZE)
   404ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404ce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   404d2:	e9 a1 00 00 00       	jmp    40578 <heap_manager_helper+0x102>
            vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   404d7:	48 8b 05 22 0a 01 00 	mov    0x10a22(%rip),%rax        # 50f00 <current>
   404de:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404e5:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   404e9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   404ed:	48 89 ce             	mov    %rcx,%rsi
   404f0:	48 89 c7             	mov    %rax,%rdi
   404f3:	e8 c0 28 00 00       	call   42db8 <virtual_memory_lookup>
            if (map.pn != -1)
   404f8:	8b 45 d8             	mov    -0x28(%rbp),%eax
   404fb:	83 f8 ff             	cmp    $0xffffffff,%eax
   404fe:	74 70                	je     40570 <heap_manager_helper+0xfa>
                if (map.perm & PTE_P)
   40500:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40503:	48 98                	cltq   
   40505:	83 e0 01             	and    $0x1,%eax
   40508:	48 85 c0             	test   %rax,%rax
   4050b:	74 1c                	je     40529 <heap_manager_helper+0xb3>
                    pageinfo[map.pn].refcount -= 1;
   4050d:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40510:	48 98                	cltq   
   40512:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   40519:	00 
   4051a:	8d 50 ff             	lea    -0x1(%rax),%edx
   4051d:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40520:	48 98                	cltq   
   40522:	88 94 00 21 0f 05 00 	mov    %dl,0x50f21(%rax,%rax,1)
                if(pageinfo[map.pn].refcount == 0)
   40529:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4052c:	48 98                	cltq   
   4052e:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   40535:	00 
   40536:	84 c0                	test   %al,%al
   40538:	75 0d                	jne    40547 <heap_manager_helper+0xd1>
                    pageinfo[map.pn].owner = PO_FREE;
   4053a:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4053d:	48 98                	cltq   
   4053f:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   40546:	00 
                virtual_memory_map(current->p_pagetable, addr, map.pa, PAGESIZE, PTE_U | PTE_W);
   40547:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4054b:	48 8b 05 ae 09 01 00 	mov    0x109ae(%rip),%rax        # 50f00 <current>
   40552:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40559:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4055d:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   40563:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40568:	48 89 c7             	mov    %rax,%rdi
   4056b:	e8 85 24 00 00       	call   429f5 <virtual_memory_map>
        for (uintptr_t addr = page_aligned_addr; addr >= new_program_break; addr-=PAGESIZE)
   40570:	48 81 6d f0 00 10 00 	subq   $0x1000,-0x10(%rbp)
   40577:	00 
   40578:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4057c:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   40580:	0f 83 51 ff ff ff    	jae    404d7 <heap_manager_helper+0x61>
        current->program_break = new_program_break;
   40586:	48 8b 05 73 09 01 00 	mov    0x10973(%rip),%rax        # 50f00 <current>
   4058d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40591:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   40595:	90                   	nop
   40596:	c9                   	leave  
   40597:	c3                   	ret    

0000000000040598 <syscall_mapping>:


void syscall_mapping(proc* p){
   40598:	55                   	push   %rbp
   40599:	48 89 e5             	mov    %rsp,%rbp
   4059c:	48 83 ec 70          	sub    $0x70,%rsp
   405a0:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   405a4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405a8:	48 8b 40 48          	mov    0x48(%rax),%rax
   405ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   405b0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405b4:	48 8b 40 40          	mov    0x40(%rax),%rax
   405b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   405bc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405c0:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   405c7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   405cb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   405cf:	48 89 ce             	mov    %rcx,%rsi
   405d2:	48 89 c7             	mov    %rax,%rdi
   405d5:	e8 de 27 00 00       	call   42db8 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   405da:	8b 45 e0             	mov    -0x20(%rbp),%eax
   405dd:	48 98                	cltq   
   405df:	83 e0 06             	and    $0x6,%eax
   405e2:	48 83 f8 06          	cmp    $0x6,%rax
   405e6:	0f 85 89 00 00 00    	jne    40675 <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   405ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405f0:	48 83 c0 17          	add    $0x17,%rax
   405f4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   405f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40600:	89 c2                	mov    %eax,%edx
   40602:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40606:	48 c1 e8 0c          	shr    $0xc,%rax
   4060a:	39 c2                	cmp    %eax,%edx
   4060c:	74 2c                	je     4063a <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4060e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40612:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40619:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4061d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40621:	48 89 ce             	mov    %rcx,%rsi
   40624:	48 89 c7             	mov    %rax,%rdi
   40627:	e8 8c 27 00 00       	call   42db8 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4062c:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4062f:	48 98                	cltq   
   40631:	83 e0 03             	and    $0x3,%eax
   40634:	48 83 f8 03          	cmp    $0x3,%rax
   40638:	75 3e                	jne    40678 <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4063a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4063e:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40645:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40649:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4064d:	48 89 ce             	mov    %rcx,%rsi
   40650:	48 89 c7             	mov    %rax,%rdi
   40653:	e8 60 27 00 00       	call   42db8 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40658:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4065c:	48 89 c1             	mov    %rax,%rcx
   4065f:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40663:	ba 18 00 00 00       	mov    $0x18,%edx
   40668:	48 89 c6             	mov    %rax,%rsi
   4066b:	48 89 cf             	mov    %rcx,%rdi
   4066e:	e8 05 37 00 00       	call   43d78 <memcpy>
   40673:	eb 04                	jmp    40679 <syscall_mapping+0xe1>
        return;
   40675:	90                   	nop
   40676:	eb 01                	jmp    40679 <syscall_mapping+0xe1>
            return; 
   40678:	90                   	nop
}
   40679:	c9                   	leave  
   4067a:	c3                   	ret    

000000000004067b <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4067b:	55                   	push   %rbp
   4067c:	48 89 e5             	mov    %rsp,%rbp
   4067f:	48 83 ec 18          	sub    $0x18,%rsp
   40683:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4068b:	48 8b 40 48          	mov    0x48(%rax),%rax
   4068f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40692:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40696:	75 14                	jne    406ac <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40698:	0f b6 05 61 59 00 00 	movzbl 0x5961(%rip),%eax        # 46000 <disp_global>
   4069f:	84 c0                	test   %al,%al
   406a1:	0f 94 c0             	sete   %al
   406a4:	88 05 56 59 00 00    	mov    %al,0x5956(%rip)        # 46000 <disp_global>
   406aa:	eb 36                	jmp    406e2 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   406ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   406b0:	78 2f                	js     406e1 <syscall_mem_tog+0x66>
   406b2:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   406b6:	7f 29                	jg     406e1 <syscall_mem_tog+0x66>
   406b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406bc:	8b 00                	mov    (%rax),%eax
   406be:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   406c1:	75 1e                	jne    406e1 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   406c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406c7:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   406ce:	84 c0                	test   %al,%al
   406d0:	0f 94 c0             	sete   %al
   406d3:	89 c2                	mov    %eax,%edx
   406d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406d9:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   406df:	eb 01                	jmp    406e2 <syscall_mem_tog+0x67>
            return;
   406e1:	90                   	nop
    }
}
   406e2:	c9                   	leave  
   406e3:	c3                   	ret    

00000000000406e4 <sbrk_brk_helper>:

/**
 * INT_SYS_BRK & INT_SYS_SBRK helper function
 * Allocates and maps a physical page(s) in case of a page fault within allocated heap space
*/
void sbrk_brk_helper(uintptr_t invalid_addr){
   406e4:	55                   	push   %rbp
   406e5:	48 89 e5             	mov    %rsp,%rbp
   406e8:	48 83 ec 60          	sub    $0x60,%rsp
   406ec:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
uintptr_t page_aligned_addr;
    // Address is not page-aligned
    if(invalid_addr % PAGESIZE != 0)
   406f0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   406f4:	25 ff 0f 00 00       	and    $0xfff,%eax
   406f9:	48 85 c0             	test   %rax,%rax
   406fc:	0f 84 14 01 00 00    	je     40816 <sbrk_brk_helper+0x132>
    {
        page_aligned_addr = (invalid_addr - (invalid_addr % PAGESIZE));
   40702:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40706:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4070c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        // Allocate physical page
        void* ret = palloc(current->p_pid);
   40710:	48 8b 05 e9 07 01 00 	mov    0x107e9(%rip),%rax        # 50f00 <current>
   40717:	8b 00                	mov    (%rax),%eax
   40719:	89 c7                	mov    %eax,%edi
   4071b:	e8 24 2b 00 00       	call   43244 <palloc>
   40720:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        // Kill process and free its memory in case page allocation fails
        if(ret == NULL)
   40724:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40729:	75 0c                	jne    40737 <sbrk_brk_helper+0x53>
        {
            syscall_exit();
   4072b:	b8 00 00 00 00       	mov    $0x0,%eax
   40730:	e8 06 fd ff ff       	call   4043b <syscall_exit>
   40735:	eb 3c                	jmp    40773 <sbrk_brk_helper+0x8f>
        }
        else
        {
            // Map page to process' pagetable
            int ret2 = virtual_memory_map(current->p_pagetable, page_aligned_addr, ((uintptr_t) ret), PAGESIZE, PTE_W | PTE_U | PTE_P);
   40737:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4073b:	48 8b 05 be 07 01 00 	mov    0x107be(%rip),%rax        # 50f00 <current>
   40742:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40749:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4074d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40753:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40758:	48 89 c7             	mov    %rax,%rdi
   4075b:	e8 95 22 00 00       	call   429f5 <virtual_memory_map>
   40760:	89 45 dc             	mov    %eax,-0x24(%rbp)
            if(ret2 == -1)
   40763:	83 7d dc ff          	cmpl   $0xffffffff,-0x24(%rbp)
   40767:	75 0a                	jne    40773 <sbrk_brk_helper+0x8f>
            {
                syscall_exit();
   40769:	b8 00 00 00 00       	mov    $0x0,%eax
   4076e:	e8 c8 fc ff ff       	call   4043b <syscall_exit>
            }
        }
        // Allocate and map subsequent page-sized address if not already done so
        vamapping map = virtual_memory_lookup(current->p_pagetable, (page_aligned_addr + PAGESIZE));
   40773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40777:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
   4077e:	48 8b 05 7b 07 01 00 	mov    0x1077b(%rip),%rax        # 50f00 <current>
   40785:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4078c:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40790:	48 89 ce             	mov    %rcx,%rsi
   40793:	48 89 c7             	mov    %rax,%rdi
   40796:	e8 1d 26 00 00       	call   42db8 <virtual_memory_lookup>
        if(map.pn != -1)
   4079b:	8b 45 b0             	mov    -0x50(%rbp),%eax
   4079e:	83 f8 ff             	cmp    $0xffffffff,%eax
   407a1:	0f 84 da 00 00 00    	je     40881 <sbrk_brk_helper+0x19d>
        {
            // Allocate physical page
            void* ret2 = palloc(current->p_pid);
   407a7:	48 8b 05 52 07 01 00 	mov    0x10752(%rip),%rax        # 50f00 <current>
   407ae:	8b 00                	mov    (%rax),%eax
   407b0:	89 c7                	mov    %eax,%edi
   407b2:	e8 8d 2a 00 00       	call   43244 <palloc>
   407b7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
            // Kill process and free its memory in case page allocation fails
            if(ret2 == NULL)
   407bb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   407c0:	75 0f                	jne    407d1 <sbrk_brk_helper+0xed>
            {
                syscall_exit();
   407c2:	b8 00 00 00 00       	mov    $0x0,%eax
   407c7:	e8 6f fc ff ff       	call   4043b <syscall_exit>
   407cc:	e9 b0 00 00 00       	jmp    40881 <sbrk_brk_helper+0x19d>
            }
            else
            {
                // Map page to process' pagetable
                int ret3 = virtual_memory_map(current->p_pagetable, (page_aligned_addr + PAGESIZE), ((uintptr_t) ret2), PAGESIZE, PTE_W | PTE_U | PTE_P);
   407d1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   407d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407d9:	48 8d b0 00 10 00 00 	lea    0x1000(%rax),%rsi
   407e0:	48 8b 05 19 07 01 00 	mov    0x10719(%rip),%rax        # 50f00 <current>
   407e7:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   407ee:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   407f4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   407f9:	48 89 c7             	mov    %rax,%rdi
   407fc:	e8 f4 21 00 00       	call   429f5 <virtual_memory_map>
   40801:	89 45 cc             	mov    %eax,-0x34(%rbp)
                if(ret3 == -1)
   40804:	83 7d cc ff          	cmpl   $0xffffffff,-0x34(%rbp)
   40808:	75 77                	jne    40881 <sbrk_brk_helper+0x19d>
                {
                    syscall_exit();
   4080a:	b8 00 00 00 00       	mov    $0x0,%eax
   4080f:	e8 27 fc ff ff       	call   4043b <syscall_exit>
   40814:	eb 6b                	jmp    40881 <sbrk_brk_helper+0x19d>
        }
        
    }
    else // Address is page-aligned
    {
        page_aligned_addr = invalid_addr;
   40816:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4081a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        void* ret = palloc(current->p_pid);
   4081e:	48 8b 05 db 06 01 00 	mov    0x106db(%rip),%rax        # 50f00 <current>
   40825:	8b 00                	mov    (%rax),%eax
   40827:	89 c7                	mov    %eax,%edi
   40829:	e8 16 2a 00 00       	call   43244 <palloc>
   4082e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        // Kill process and free its memory in case page allocation fails
        if(ret == NULL)
   40832:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40837:	75 0c                	jne    40845 <sbrk_brk_helper+0x161>
        {
            syscall_exit();
   40839:	b8 00 00 00 00       	mov    $0x0,%eax
   4083e:	e8 f8 fb ff ff       	call   4043b <syscall_exit>
   40843:	eb 3c                	jmp    40881 <sbrk_brk_helper+0x19d>
        }
        else
        {
            // Map page to process' pagetable
            int ret2 = virtual_memory_map(current->p_pagetable, page_aligned_addr, ((uintptr_t) ret), PAGESIZE, PTE_W | PTE_U | PTE_P);
   40845:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40849:	48 8b 05 b0 06 01 00 	mov    0x106b0(%rip),%rax        # 50f00 <current>
   40850:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40857:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4085b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40861:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40866:	48 89 c7             	mov    %rax,%rdi
   40869:	e8 87 21 00 00       	call   429f5 <virtual_memory_map>
   4086e:	89 45 ec             	mov    %eax,-0x14(%rbp)
            if(ret2 == -1)
   40871:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   40875:	75 0a                	jne    40881 <sbrk_brk_helper+0x19d>
            {
                syscall_exit();
   40877:	b8 00 00 00 00       	mov    $0x0,%eax
   4087c:	e8 ba fb ff ff       	call   4043b <syscall_exit>
            }
        }
    }
    // Set process as runnable
    current->p_state = P_RUNNABLE;
   40881:	48 8b 05 78 06 01 00 	mov    0x10678(%rip),%rax        # 50f00 <current>
   40888:	c7 80 d8 00 00 00 01 	movl   $0x1,0xd8(%rax)
   4088f:	00 00 00 
}
   40892:	90                   	nop
   40893:	c9                   	leave  
   40894:	c3                   	ret    

0000000000040895 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40895:	55                   	push   %rbp
   40896:	48 89 e5             	mov    %rsp,%rbp
   40899:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   408a0:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   408a7:	48 8b 05 52 06 01 00 	mov    0x10652(%rip),%rax        # 50f00 <current>
   408ae:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   408b5:	48 83 c0 18          	add    $0x18,%rax
   408b9:	48 89 d6             	mov    %rdx,%rsi
   408bc:	ba 18 00 00 00       	mov    $0x18,%edx
   408c1:	48 89 c7             	mov    %rax,%rdi
   408c4:	48 89 d1             	mov    %rdx,%rcx
   408c7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   408ca:	48 8b 05 2f 27 01 00 	mov    0x1272f(%rip),%rax        # 53000 <kernel_pagetable>
   408d1:	48 89 c7             	mov    %rax,%rdi
   408d4:	e8 eb 1f 00 00       	call   428c4 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   408d9:	8b 05 1d 87 07 00    	mov    0x7871d(%rip),%eax        # b8ffc <cursorpos>
   408df:	89 c7                	mov    %eax,%edi
   408e1:	e8 0c 17 00 00       	call   41ff2 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   408e6:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   408ed:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408f4:	48 83 f8 0e          	cmp    $0xe,%rax
   408f8:	74 14                	je     4090e <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   408fa:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40901:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40908:	48 83 f8 0d          	cmp    $0xd,%rax
   4090c:	75 16                	jne    40924 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   4090e:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40915:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4091c:	83 e0 04             	and    $0x4,%eax
   4091f:	48 85 c0             	test   %rax,%rax
   40922:	74 1a                	je     4093e <exception+0xa9>
        check_virtual_memory();
   40924:	e8 92 08 00 00       	call   411bb <check_virtual_memory>
        if(disp_global){
   40929:	0f b6 05 d0 56 00 00 	movzbl 0x56d0(%rip),%eax        # 46000 <disp_global>
   40930:	84 c0                	test   %al,%al
   40932:	74 0a                	je     4093e <exception+0xa9>
            memshow_physical();
   40934:	e8 fa 09 00 00       	call   41333 <memshow_physical>
            memshow_virtual_animate();
   40939:	e8 24 0d 00 00       	call   41662 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4093e:	e8 92 1b 00 00       	call   424d5 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40943:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   4094a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40951:	48 83 e8 0e          	sub    $0xe,%rax
   40955:	48 83 f8 2c          	cmp    $0x2c,%rax
   40959:	0f 87 85 03 00 00    	ja     40ce4 <exception+0x44f>
   4095f:	48 8b 04 c5 18 4f 04 	mov    0x44f18(,%rax,8),%rax
   40966:	00 
   40967:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   40969:	48 8b 05 90 05 01 00 	mov    0x10590(%rip),%rax        # 50f00 <current>
   40970:	48 8b 40 48          	mov    0x48(%rax),%rax
   40974:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                    if((void *)addr == NULL)
   40978:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   4097d:	75 0f                	jne    4098e <exception+0xf9>
                        kernel_panic(NULL);
   4097f:	bf 00 00 00 00       	mov    $0x0,%edi
   40984:	b8 00 00 00 00       	mov    $0x0,%eax
   40989:	e8 88 1c 00 00       	call   42616 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4098e:	48 8b 05 6b 05 01 00 	mov    0x1056b(%rip),%rax        # 50f00 <current>
   40995:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4099c:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   409a0:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   409a4:	48 89 ce             	mov    %rcx,%rsi
   409a7:	48 89 c7             	mov    %rax,%rdi
   409aa:	e8 09 24 00 00       	call   42db8 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   409af:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   409b3:	48 89 c1             	mov    %rax,%rcx
   409b6:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   409bd:	ba a0 00 00 00       	mov    $0xa0,%edx
   409c2:	48 89 ce             	mov    %rcx,%rsi
   409c5:	48 89 c7             	mov    %rax,%rdi
   409c8:	e8 ab 33 00 00       	call   43d78 <memcpy>
                    kernel_panic(msg);
   409cd:	48 8d 85 f8 fe ff ff 	lea    -0x108(%rbp),%rax
   409d4:	48 89 c7             	mov    %rax,%rdi
   409d7:	b8 00 00 00 00       	mov    $0x0,%eax
   409dc:	e8 35 1c 00 00       	call   42616 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   409e1:	48 8b 05 18 05 01 00 	mov    0x10518(%rip),%rax        # 50f00 <current>
   409e8:	8b 10                	mov    (%rax),%edx
   409ea:	48 8b 05 0f 05 01 00 	mov    0x1050f(%rip),%rax        # 50f00 <current>
   409f1:	48 63 d2             	movslq %edx,%rdx
   409f4:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   409f8:	e9 f7 02 00 00       	jmp    40cf4 <exception+0x45f>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   409fd:	b8 00 00 00 00       	mov    $0x0,%eax
   40a02:	e8 1f fa ff ff       	call   40426 <syscall_fork>
   40a07:	89 c2                	mov    %eax,%edx
   40a09:	48 8b 05 f0 04 01 00 	mov    0x104f0(%rip),%rax        # 50f00 <current>
   40a10:	48 63 d2             	movslq %edx,%rdx
   40a13:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40a17:	e9 d8 02 00 00       	jmp    40cf4 <exception+0x45f>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40a1c:	48 8b 05 dd 04 01 00 	mov    0x104dd(%rip),%rax        # 50f00 <current>
   40a23:	48 89 c7             	mov    %rax,%rdi
   40a26:	e8 6d fb ff ff       	call   40598 <syscall_mapping>
                break;
   40a2b:	e9 c4 02 00 00       	jmp    40cf4 <exception+0x45f>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40a30:	b8 00 00 00 00       	mov    $0x0,%eax
   40a35:	e8 01 fa ff ff       	call   4043b <syscall_exit>
                schedule();
   40a3a:	e8 de 02 00 00       	call   40d1d <schedule>
                break;
   40a3f:	e9 b0 02 00 00       	jmp    40cf4 <exception+0x45f>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40a44:	e8 d4 02 00 00       	call   40d1d <schedule>
                break;                  /* will not be reached */
   40a49:	e9 a6 02 00 00       	jmp    40cf4 <exception+0x45f>
            }

        case INT_SYS_BRK:
            {
                uintptr_t addr = reg->reg_rdi;
   40a4e:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40a55:	48 8b 40 30          	mov    0x30(%rax),%rax
   40a59:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                // Ensure new address is within the heap space i.e not greater than stack pointer and not lower than original program break
                if ((addr >= (MEMSIZE_VIRTUAL - PAGESIZE)) || (addr < current->original_break))
   40a5d:	48 81 7d e0 ff ef 2f 	cmpq   $0x2fefff,-0x20(%rbp)
   40a64:	00 
   40a65:	77 11                	ja     40a78 <exception+0x1e3>
   40a67:	48 8b 05 92 04 01 00 	mov    0x10492(%rip),%rax        # 50f00 <current>
   40a6e:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a72:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
   40a76:	73 14                	jae    40a8c <exception+0x1f7>
                {
                    current->p_registers.reg_rax = ((uint64_t)-1);
   40a78:	48 8b 05 81 04 01 00 	mov    0x10481(%rip),%rax        # 50f00 <current>
   40a7f:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40a86:	ff 
                {
                    heap_manager_helper(current->program_break, addr);
                    // Return value to caller
                    current->p_registers.reg_rax = 0;
                }
		        break;
   40a87:	e9 68 02 00 00       	jmp    40cf4 <exception+0x45f>
                    heap_manager_helper(current->program_break, addr);
   40a8c:	48 8b 05 6d 04 01 00 	mov    0x1046d(%rip),%rax        # 50f00 <current>
   40a93:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a97:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a9b:	48 89 d6             	mov    %rdx,%rsi
   40a9e:	48 89 c7             	mov    %rax,%rdi
   40aa1:	e8 d0 f9 ff ff       	call   40476 <heap_manager_helper>
                    current->p_registers.reg_rax = 0;
   40aa6:	48 8b 05 53 04 01 00 	mov    0x10453(%rip),%rax        # 50f00 <current>
   40aad:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   40ab4:	00 
		        break;
   40ab5:	e9 3a 02 00 00       	jmp    40cf4 <exception+0x45f>
            }

        case INT_SYS_SBRK:
            {
                intptr_t difference = reg->reg_rdi;
   40aba:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40ac1:	48 8b 40 30          	mov    0x30(%rax),%rax
   40ac5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
                if (difference == 0)
   40ac9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   40ace:	75 1b                	jne    40aeb <exception+0x256>
                {
                    current->p_registers.reg_rax = current->program_break;
   40ad0:	48 8b 15 29 04 01 00 	mov    0x10429(%rip),%rdx        # 50f00 <current>
   40ad7:	48 8b 05 22 04 01 00 	mov    0x10422(%rip),%rax        # 50f00 <current>
   40ade:	48 8b 52 08          	mov    0x8(%rdx),%rdx
   40ae2:	48 89 50 18          	mov    %rdx,0x18(%rax)
                    break;
   40ae6:	e9 09 02 00 00       	jmp    40cf4 <exception+0x45f>
                }
                
                uintptr_t previous_break = current->program_break;
   40aeb:	48 8b 05 0e 04 01 00 	mov    0x1040e(%rip),%rax        # 50f00 <current>
   40af2:	48 8b 40 08          	mov    0x8(%rax),%rax
   40af6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                uintptr_t new_program_break = current->program_break + ((uintptr_t)difference);
   40afa:	48 8b 05 ff 03 01 00 	mov    0x103ff(%rip),%rax        # 50f00 <current>
   40b01:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40b05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b09:	48 01 d0             	add    %rdx,%rax
   40b0c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                // Ensure new break does not overlap with stack space or go below original heap
                if (new_program_break >= (MEMSIZE_VIRTUAL - PAGESIZE) || new_program_break < current->original_break)
   40b10:	48 81 7d e8 ff ef 2f 	cmpq   $0x2fefff,-0x18(%rbp)
   40b17:	00 
   40b18:	77 11                	ja     40b2b <exception+0x296>
   40b1a:	48 8b 05 df 03 01 00 	mov    0x103df(%rip),%rax        # 50f00 <current>
   40b21:	48 8b 40 10          	mov    0x10(%rax),%rax
   40b25:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40b29:	73 14                	jae    40b3f <exception+0x2aa>
                {
                    current->p_registers.reg_rax = ((uint64_t)((void*)-1));
   40b2b:	48 8b 05 ce 03 01 00 	mov    0x103ce(%rip),%rax        # 50f00 <current>
   40b32:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40b39:	ff 
                    heap_manager_helper(previous_break, new_program_break);
                    // Return value to caller
                    current->p_registers.reg_rax = (uint64_t)previous_break;
                }
                
                break;
   40b3a:	e9 b5 01 00 00       	jmp    40cf4 <exception+0x45f>
                    heap_manager_helper(previous_break, new_program_break);
   40b3f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40b43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40b47:	48 89 d6             	mov    %rdx,%rsi
   40b4a:	48 89 c7             	mov    %rax,%rdi
   40b4d:	e8 24 f9 ff ff       	call   40476 <heap_manager_helper>
                    current->p_registers.reg_rax = (uint64_t)previous_break;
   40b52:	48 8b 05 a7 03 01 00 	mov    0x103a7(%rip),%rax        # 50f00 <current>
   40b59:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40b5d:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40b61:	e9 8e 01 00 00       	jmp    40cf4 <exception+0x45f>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40b66:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40b6d:	48 8b 40 30          	mov    0x30(%rax),%rax
   40b71:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		syscall_page_alloc(addr);
   40b75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b79:	48 89 c7             	mov    %rax,%rdi
   40b7c:	e8 d1 f8 ff ff       	call   40452 <syscall_page_alloc>
		break;
   40b81:	e9 6e 01 00 00       	jmp    40cf4 <exception+0x45f>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40b86:	48 8b 05 73 03 01 00 	mov    0x10373(%rip),%rax        # 50f00 <current>
   40b8d:	48 89 c7             	mov    %rax,%rdi
   40b90:	e8 e6 fa ff ff       	call   4067b <syscall_mem_tog>
                break;
   40b95:	e9 5a 01 00 00       	jmp    40cf4 <exception+0x45f>
            }

        case INT_TIMER:
            {
                ++ticks;
   40b9a:	8b 05 80 07 01 00    	mov    0x10780(%rip),%eax        # 51320 <ticks>
   40ba0:	83 c0 01             	add    $0x1,%eax
   40ba3:	89 05 77 07 01 00    	mov    %eax,0x10777(%rip)        # 51320 <ticks>
                schedule();
   40ba9:	e8 6f 01 00 00       	call   40d1d <schedule>
                break;                  /* will not be reached */
   40bae:	e9 41 01 00 00       	jmp    40cf4 <exception+0x45f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40bb3:	0f 20 d0             	mov    %cr2,%rax
   40bb6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    return val;
   40bba:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   40bbe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
                // Check for "missing page" faults
                if ((addr <= (MEMSIZE_VIRTUAL - PAGESIZE)) && (addr >= current->original_break))
   40bc2:	48 81 7d c8 00 f0 2f 	cmpq   $0x2ff000,-0x38(%rbp)
   40bc9:	00 
   40bca:	77 22                	ja     40bee <exception+0x359>
   40bcc:	48 8b 05 2d 03 01 00 	mov    0x1032d(%rip),%rax        # 50f00 <current>
   40bd3:	48 8b 40 10          	mov    0x10(%rax),%rax
   40bd7:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   40bdb:	72 11                	jb     40bee <exception+0x359>
                {
                    // Allocate and map "missing page"
                    sbrk_brk_helper(addr);
   40bdd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40be1:	48 89 c7             	mov    %rax,%rdi
   40be4:	e8 fb fa ff ff       	call   406e4 <sbrk_brk_helper>
                    break;
   40be9:	e9 06 01 00 00       	jmp    40cf4 <exception+0x45f>
                }
                const char* operation = reg->reg_err & PFERR_WRITE
   40bee:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40bf5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40bfc:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40bff:	48 85 c0             	test   %rax,%rax
   40c02:	74 07                	je     40c0b <exception+0x376>
   40c04:	b8 8b 4e 04 00       	mov    $0x44e8b,%eax
   40c09:	eb 05                	jmp    40c10 <exception+0x37b>
   40c0b:	b8 91 4e 04 00       	mov    $0x44e91,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40c10:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40c14:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c1b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c22:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40c25:	48 85 c0             	test   %rax,%rax
   40c28:	74 07                	je     40c31 <exception+0x39c>
   40c2a:	b8 96 4e 04 00       	mov    $0x44e96,%eax
   40c2f:	eb 05                	jmp    40c36 <exception+0x3a1>
   40c31:	b8 a9 4e 04 00       	mov    $0x44ea9,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40c36:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
                if (!(reg->reg_err & PFERR_USER)) {
   40c3a:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c41:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c48:	83 e0 04             	and    $0x4,%eax
   40c4b:	48 85 c0             	test   %rax,%rax
   40c4e:	75 2f                	jne    40c7f <exception+0x3ea>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40c50:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c57:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40c5e:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c62:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   40c66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40c6a:	49 89 f0             	mov    %rsi,%r8
   40c6d:	48 89 c6             	mov    %rax,%rsi
   40c70:	bf b8 4e 04 00       	mov    $0x44eb8,%edi
   40c75:	b8 00 00 00 00       	mov    $0x0,%eax
   40c7a:	e8 97 19 00 00       	call   42616 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40c7f:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c86:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40c8d:	48 8b 05 6c 02 01 00 	mov    0x1026c(%rip),%rax        # 50f00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40c94:	8b 00                	mov    (%rax),%eax
   40c96:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   40c9a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40c9e:	52                   	push   %rdx
   40c9f:	ff 75 b8             	push   -0x48(%rbp)
   40ca2:	49 89 f1             	mov    %rsi,%r9
   40ca5:	49 89 c8             	mov    %rcx,%r8
   40ca8:	89 c1                	mov    %eax,%ecx
   40caa:	ba e8 4e 04 00       	mov    $0x44ee8,%edx
   40caf:	be 00 0c 00 00       	mov    $0xc00,%esi
   40cb4:	bf 80 07 00 00       	mov    $0x780,%edi
   40cb9:	b8 00 00 00 00       	mov    $0x0,%eax
   40cbe:	e8 6a 3f 00 00       	call   44c2d <console_printf>
   40cc3:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40cc7:	48 8b 05 32 02 01 00 	mov    0x10232(%rip),%rax        # 50f00 <current>
   40cce:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40cd5:	00 00 00 
                
                syscall_exit();
   40cd8:	b8 00 00 00 00       	mov    $0x0,%eax
   40cdd:	e8 59 f7 ff ff       	call   4043b <syscall_exit>
                break;
   40ce2:	eb 10                	jmp    40cf4 <exception+0x45f>
            }

        default:
            default_exception(current);
   40ce4:	48 8b 05 15 02 01 00 	mov    0x10215(%rip),%rax        # 50f00 <current>
   40ceb:	48 89 c7             	mov    %rax,%rdi
   40cee:	e8 33 1a 00 00       	call   42726 <default_exception>
            break;                  /* will not be reached */
   40cf3:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40cf4:	48 8b 05 05 02 01 00 	mov    0x10205(%rip),%rax        # 50f00 <current>
   40cfb:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40d01:	83 f8 01             	cmp    $0x1,%eax
   40d04:	75 0f                	jne    40d15 <exception+0x480>
        run(current);
   40d06:	48 8b 05 f3 01 01 00 	mov    0x101f3(%rip),%rax        # 50f00 <current>
   40d0d:	48 89 c7             	mov    %rax,%rdi
   40d10:	e8 7e 00 00 00       	call   40d93 <run>
    } else {
        schedule();
   40d15:	e8 03 00 00 00       	call   40d1d <schedule>
    }
}
   40d1a:	90                   	nop
   40d1b:	c9                   	leave  
   40d1c:	c3                   	ret    

0000000000040d1d <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40d1d:	55                   	push   %rbp
   40d1e:	48 89 e5             	mov    %rsp,%rbp
   40d21:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40d25:	48 8b 05 d4 01 01 00 	mov    0x101d4(%rip),%rax        # 50f00 <current>
   40d2c:	8b 00                	mov    (%rax),%eax
   40d2e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40d31:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d34:	8d 50 01             	lea    0x1(%rax),%edx
   40d37:	89 d0                	mov    %edx,%eax
   40d39:	c1 f8 1f             	sar    $0x1f,%eax
   40d3c:	c1 e8 1c             	shr    $0x1c,%eax
   40d3f:	01 c2                	add    %eax,%edx
   40d41:	83 e2 0f             	and    $0xf,%edx
   40d44:	29 c2                	sub    %eax,%edx
   40d46:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40d49:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d4c:	48 63 d0             	movslq %eax,%rdx
   40d4f:	48 89 d0             	mov    %rdx,%rax
   40d52:	48 c1 e0 04          	shl    $0x4,%rax
   40d56:	48 29 d0             	sub    %rdx,%rax
   40d59:	48 c1 e0 04          	shl    $0x4,%rax
   40d5d:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   40d63:	8b 00                	mov    (%rax),%eax
   40d65:	83 f8 01             	cmp    $0x1,%eax
   40d68:	75 22                	jne    40d8c <schedule+0x6f>
            run(&processes[pid]);
   40d6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d6d:	48 63 d0             	movslq %eax,%rdx
   40d70:	48 89 d0             	mov    %rdx,%rax
   40d73:	48 c1 e0 04          	shl    $0x4,%rax
   40d77:	48 29 d0             	sub    %rdx,%rax
   40d7a:	48 c1 e0 04          	shl    $0x4,%rax
   40d7e:	48 05 00 00 05 00    	add    $0x50000,%rax
   40d84:	48 89 c7             	mov    %rax,%rdi
   40d87:	e8 07 00 00 00       	call   40d93 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d8c:	e8 44 17 00 00       	call   424d5 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d91:	eb 9e                	jmp    40d31 <schedule+0x14>

0000000000040d93 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d93:	55                   	push   %rbp
   40d94:	48 89 e5             	mov    %rsp,%rbp
   40d97:	48 83 ec 10          	sub    $0x10,%rsp
   40d9b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da3:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40da9:	83 f8 01             	cmp    $0x1,%eax
   40dac:	74 14                	je     40dc2 <run+0x2f>
   40dae:	ba 80 50 04 00       	mov    $0x45080,%edx
   40db3:	be 18 02 00 00       	mov    $0x218,%esi
   40db8:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40dbd:	e8 34 19 00 00       	call   426f6 <assert_fail>
    current = p;
   40dc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc6:	48 89 05 33 01 01 00 	mov    %rax,0x10133(%rip)        # 50f00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40dcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dd1:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40dd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dd7:	8b 00                	mov    (%rax),%eax
   40dd9:	83 c0 02             	add    $0x2,%eax
   40ddc:	48 98                	cltq   
   40dde:	0f b7 84 00 e0 4d 04 	movzwl 0x44de0(%rax,%rax,1),%eax
   40de5:	00 
    console_printf(CPOS(24, 79),
   40de6:	0f b7 c0             	movzwl %ax,%eax
   40de9:	89 d1                	mov    %edx,%ecx
   40deb:	ba 99 50 04 00       	mov    $0x45099,%edx
   40df0:	89 c6                	mov    %eax,%esi
   40df2:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40df7:	b8 00 00 00 00       	mov    $0x0,%eax
   40dfc:	e8 2c 3e 00 00       	call   44c2d <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e05:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40e0c:	48 89 c7             	mov    %rax,%rdi
   40e0f:	e8 b0 1a 00 00       	call   428c4 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40e14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e18:	48 83 c0 18          	add    $0x18,%rax
   40e1c:	48 89 c7             	mov    %rax,%rdi
   40e1f:	e8 9f f2 ff ff       	call   400c3 <exception_return>

0000000000040e24 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40e24:	55                   	push   %rbp
   40e25:	48 89 e5             	mov    %rsp,%rbp
   40e28:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e2c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40e33:	00 
   40e34:	e9 81 00 00 00       	jmp    40eba <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40e39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e3d:	48 89 c7             	mov    %rax,%rdi
   40e40:	e8 1e 0f 00 00       	call   41d63 <physical_memory_isreserved>
   40e45:	85 c0                	test   %eax,%eax
   40e47:	74 09                	je     40e52 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40e49:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e50:	eb 2f                	jmp    40e81 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40e52:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40e59:	00 
   40e5a:	76 0b                	jbe    40e67 <pageinfo_init+0x43>
   40e5c:	b8 10 90 05 00       	mov    $0x59010,%eax
   40e61:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e65:	72 0a                	jb     40e71 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40e67:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e6e:	00 
   40e6f:	75 09                	jne    40e7a <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40e71:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e78:	eb 07                	jmp    40e81 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40e7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e85:	48 c1 e8 0c          	shr    $0xc,%rax
   40e89:	89 c1                	mov    %eax,%ecx
   40e8b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e8e:	89 c2                	mov    %eax,%edx
   40e90:	48 63 c1             	movslq %ecx,%rax
   40e93:	88 94 00 20 0f 05 00 	mov    %dl,0x50f20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e9a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e9e:	0f 95 c2             	setne  %dl
   40ea1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ea5:	48 c1 e8 0c          	shr    $0xc,%rax
   40ea9:	48 98                	cltq   
   40eab:	88 94 00 21 0f 05 00 	mov    %dl,0x50f21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40eb2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40eb9:	00 
   40eba:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40ec1:	00 
   40ec2:	0f 86 71 ff ff ff    	jbe    40e39 <pageinfo_init+0x15>
    }
}
   40ec8:	90                   	nop
   40ec9:	90                   	nop
   40eca:	c9                   	leave  
   40ecb:	c3                   	ret    

0000000000040ecc <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40ecc:	55                   	push   %rbp
   40ecd:	48 89 e5             	mov    %rsp,%rbp
   40ed0:	48 83 ec 50          	sub    $0x50,%rsp
   40ed4:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40ed8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40edc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40ee2:	48 89 c2             	mov    %rax,%rdx
   40ee5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40ee9:	48 39 c2             	cmp    %rax,%rdx
   40eec:	74 14                	je     40f02 <check_page_table_mappings+0x36>
   40eee:	ba a0 50 04 00       	mov    $0x450a0,%edx
   40ef3:	be 46 02 00 00       	mov    $0x246,%esi
   40ef8:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40efd:	e8 f4 17 00 00       	call   426f6 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f02:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40f09:	00 
   40f0a:	e9 9a 00 00 00       	jmp    40fa9 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40f0f:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40f13:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40f17:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f1b:	48 89 ce             	mov    %rcx,%rsi
   40f1e:	48 89 c7             	mov    %rax,%rdi
   40f21:	e8 92 1e 00 00       	call   42db8 <virtual_memory_lookup>
        if (vam.pa != va) {
   40f26:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f2e:	74 27                	je     40f57 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40f30:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40f34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f38:	49 89 d0             	mov    %rdx,%r8
   40f3b:	48 89 c1             	mov    %rax,%rcx
   40f3e:	ba bf 50 04 00       	mov    $0x450bf,%edx
   40f43:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f48:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f4d:	b8 00 00 00 00       	mov    $0x0,%eax
   40f52:	e8 d6 3c 00 00       	call   44c2d <console_printf>
        }
        assert(vam.pa == va);
   40f57:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f5b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f5f:	74 14                	je     40f75 <check_page_table_mappings+0xa9>
   40f61:	ba c9 50 04 00       	mov    $0x450c9,%edx
   40f66:	be 4f 02 00 00       	mov    $0x24f,%esi
   40f6b:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40f70:	e8 81 17 00 00       	call   426f6 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f75:	b8 00 60 04 00       	mov    $0x46000,%eax
   40f7a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f7e:	72 21                	jb     40fa1 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40f80:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f83:	48 98                	cltq   
   40f85:	83 e0 02             	and    $0x2,%eax
   40f88:	48 85 c0             	test   %rax,%rax
   40f8b:	75 14                	jne    40fa1 <check_page_table_mappings+0xd5>
   40f8d:	ba d6 50 04 00       	mov    $0x450d6,%edx
   40f92:	be 51 02 00 00       	mov    $0x251,%esi
   40f97:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40f9c:	e8 55 17 00 00       	call   426f6 <assert_fail>
         va += PAGESIZE) {
   40fa1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40fa8:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40fa9:	b8 10 90 05 00       	mov    $0x59010,%eax
   40fae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fb2:	0f 82 57 ff ff ff    	jb     40f0f <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40fb8:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40fbf:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40fc0:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40fc4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40fc8:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40fcc:	48 89 ce             	mov    %rcx,%rsi
   40fcf:	48 89 c7             	mov    %rax,%rdi
   40fd2:	e8 e1 1d 00 00       	call   42db8 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40fd7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40fdb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40fdf:	74 14                	je     40ff5 <check_page_table_mappings+0x129>
   40fe1:	ba e7 50 04 00       	mov    $0x450e7,%edx
   40fe6:	be 58 02 00 00       	mov    $0x258,%esi
   40feb:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   40ff0:	e8 01 17 00 00       	call   426f6 <assert_fail>
    assert(vam.perm & PTE_W);
   40ff5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ff8:	48 98                	cltq   
   40ffa:	83 e0 02             	and    $0x2,%eax
   40ffd:	48 85 c0             	test   %rax,%rax
   41000:	75 14                	jne    41016 <check_page_table_mappings+0x14a>
   41002:	ba d6 50 04 00       	mov    $0x450d6,%edx
   41007:	be 59 02 00 00       	mov    $0x259,%esi
   4100c:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   41011:	e8 e0 16 00 00       	call   426f6 <assert_fail>
}
   41016:	90                   	nop
   41017:	c9                   	leave  
   41018:	c3                   	ret    

0000000000041019 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41019:	55                   	push   %rbp
   4101a:	48 89 e5             	mov    %rsp,%rbp
   4101d:	48 83 ec 20          	sub    $0x20,%rsp
   41021:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41025:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41028:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4102b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4102e:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41035:	48 8b 05 c4 1f 01 00 	mov    0x11fc4(%rip),%rax        # 53000 <kernel_pagetable>
   4103c:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41040:	75 67                	jne    410a9 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   41042:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41049:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41050:	eb 51                	jmp    410a3 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41052:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41055:	48 63 d0             	movslq %eax,%rdx
   41058:	48 89 d0             	mov    %rdx,%rax
   4105b:	48 c1 e0 04          	shl    $0x4,%rax
   4105f:	48 29 d0             	sub    %rdx,%rax
   41062:	48 c1 e0 04          	shl    $0x4,%rax
   41066:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   4106c:	8b 00                	mov    (%rax),%eax
   4106e:	85 c0                	test   %eax,%eax
   41070:	74 2d                	je     4109f <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41072:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41075:	48 63 d0             	movslq %eax,%rdx
   41078:	48 89 d0             	mov    %rdx,%rax
   4107b:	48 c1 e0 04          	shl    $0x4,%rax
   4107f:	48 29 d0             	sub    %rdx,%rax
   41082:	48 c1 e0 04          	shl    $0x4,%rax
   41086:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   4108c:	48 8b 10             	mov    (%rax),%rdx
   4108f:	48 8b 05 6a 1f 01 00 	mov    0x11f6a(%rip),%rax        # 53000 <kernel_pagetable>
   41096:	48 39 c2             	cmp    %rax,%rdx
   41099:	75 04                	jne    4109f <check_page_table_ownership+0x86>
                ++expected_refcount;
   4109b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4109f:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   410a3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   410a7:	7e a9                	jle    41052 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   410a9:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   410ac:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410b3:	be 00 00 00 00       	mov    $0x0,%esi
   410b8:	48 89 c7             	mov    %rax,%rdi
   410bb:	e8 03 00 00 00       	call   410c3 <check_page_table_ownership_level>
}
   410c0:	90                   	nop
   410c1:	c9                   	leave  
   410c2:	c3                   	ret    

00000000000410c3 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410c3:	55                   	push   %rbp
   410c4:	48 89 e5             	mov    %rsp,%rbp
   410c7:	48 83 ec 30          	sub    $0x30,%rsp
   410cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410cf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   410d2:	89 55 e0             	mov    %edx,-0x20(%rbp)
   410d5:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410dc:	48 c1 e8 0c          	shr    $0xc,%rax
   410e0:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410e5:	7e 14                	jle    410fb <check_page_table_ownership_level+0x38>
   410e7:	ba f8 50 04 00       	mov    $0x450f8,%edx
   410ec:	be 76 02 00 00       	mov    $0x276,%esi
   410f1:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   410f6:	e8 fb 15 00 00       	call   426f6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410ff:	48 c1 e8 0c          	shr    $0xc,%rax
   41103:	48 98                	cltq   
   41105:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   4110c:	00 
   4110d:	0f be c0             	movsbl %al,%eax
   41110:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41113:	74 14                	je     41129 <check_page_table_ownership_level+0x66>
   41115:	ba 10 51 04 00       	mov    $0x45110,%edx
   4111a:	be 77 02 00 00       	mov    $0x277,%esi
   4111f:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   41124:	e8 cd 15 00 00       	call   426f6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41129:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4112d:	48 c1 e8 0c          	shr    $0xc,%rax
   41131:	48 98                	cltq   
   41133:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   4113a:	00 
   4113b:	0f be c0             	movsbl %al,%eax
   4113e:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41141:	74 14                	je     41157 <check_page_table_ownership_level+0x94>
   41143:	ba 38 51 04 00       	mov    $0x45138,%edx
   41148:	be 78 02 00 00       	mov    $0x278,%esi
   4114d:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   41152:	e8 9f 15 00 00       	call   426f6 <assert_fail>
    if (level < 3) {
   41157:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4115b:	7f 5b                	jg     411b8 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4115d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41164:	eb 49                	jmp    411af <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41166:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4116a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4116d:	48 63 d2             	movslq %edx,%rdx
   41170:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41174:	48 85 c0             	test   %rax,%rax
   41177:	74 32                	je     411ab <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41179:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4117d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41180:	48 63 d2             	movslq %edx,%rdx
   41183:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41187:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4118d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41191:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41194:	8d 70 01             	lea    0x1(%rax),%esi
   41197:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4119a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4119e:	b9 01 00 00 00       	mov    $0x1,%ecx
   411a3:	48 89 c7             	mov    %rax,%rdi
   411a6:	e8 18 ff ff ff       	call   410c3 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411af:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411b6:	7e ae                	jle    41166 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   411b8:	90                   	nop
   411b9:	c9                   	leave  
   411ba:	c3                   	ret    

00000000000411bb <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411bb:	55                   	push   %rbp
   411bc:	48 89 e5             	mov    %rsp,%rbp
   411bf:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411c3:	8b 05 0f ef 00 00    	mov    0xef0f(%rip),%eax        # 500d8 <processes+0xd8>
   411c9:	85 c0                	test   %eax,%eax
   411cb:	74 14                	je     411e1 <check_virtual_memory+0x26>
   411cd:	ba 68 51 04 00       	mov    $0x45168,%edx
   411d2:	be 8b 02 00 00       	mov    $0x28b,%esi
   411d7:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   411dc:	e8 15 15 00 00       	call   426f6 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   411e1:	48 8b 05 18 1e 01 00 	mov    0x11e18(%rip),%rax        # 53000 <kernel_pagetable>
   411e8:	48 89 c7             	mov    %rax,%rdi
   411eb:	e8 dc fc ff ff       	call   40ecc <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   411f0:	48 8b 05 09 1e 01 00 	mov    0x11e09(%rip),%rax        # 53000 <kernel_pagetable>
   411f7:	be ff ff ff ff       	mov    $0xffffffff,%esi
   411fc:	48 89 c7             	mov    %rax,%rdi
   411ff:	e8 15 fe ff ff       	call   41019 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41204:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4120b:	e9 9c 00 00 00       	jmp    412ac <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41210:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41213:	48 63 d0             	movslq %eax,%rdx
   41216:	48 89 d0             	mov    %rdx,%rax
   41219:	48 c1 e0 04          	shl    $0x4,%rax
   4121d:	48 29 d0             	sub    %rdx,%rax
   41220:	48 c1 e0 04          	shl    $0x4,%rax
   41224:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   4122a:	8b 00                	mov    (%rax),%eax
   4122c:	85 c0                	test   %eax,%eax
   4122e:	74 78                	je     412a8 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41230:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41233:	48 63 d0             	movslq %eax,%rdx
   41236:	48 89 d0             	mov    %rdx,%rax
   41239:	48 c1 e0 04          	shl    $0x4,%rax
   4123d:	48 29 d0             	sub    %rdx,%rax
   41240:	48 c1 e0 04          	shl    $0x4,%rax
   41244:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   4124a:	48 8b 10             	mov    (%rax),%rdx
   4124d:	48 8b 05 ac 1d 01 00 	mov    0x11dac(%rip),%rax        # 53000 <kernel_pagetable>
   41254:	48 39 c2             	cmp    %rax,%rdx
   41257:	74 4f                	je     412a8 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41259:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4125c:	48 63 d0             	movslq %eax,%rdx
   4125f:	48 89 d0             	mov    %rdx,%rax
   41262:	48 c1 e0 04          	shl    $0x4,%rax
   41266:	48 29 d0             	sub    %rdx,%rax
   41269:	48 c1 e0 04          	shl    $0x4,%rax
   4126d:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   41273:	48 8b 00             	mov    (%rax),%rax
   41276:	48 89 c7             	mov    %rax,%rdi
   41279:	e8 4e fc ff ff       	call   40ecc <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4127e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41281:	48 63 d0             	movslq %eax,%rdx
   41284:	48 89 d0             	mov    %rdx,%rax
   41287:	48 c1 e0 04          	shl    $0x4,%rax
   4128b:	48 29 d0             	sub    %rdx,%rax
   4128e:	48 c1 e0 04          	shl    $0x4,%rax
   41292:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   41298:	48 8b 00             	mov    (%rax),%rax
   4129b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4129e:	89 d6                	mov    %edx,%esi
   412a0:	48 89 c7             	mov    %rax,%rdi
   412a3:	e8 71 fd ff ff       	call   41019 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412a8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412ac:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412b0:	0f 8e 5a ff ff ff    	jle    41210 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   412bd:	eb 67                	jmp    41326 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   412bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412c2:	48 98                	cltq   
   412c4:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   412cb:	00 
   412cc:	84 c0                	test   %al,%al
   412ce:	7e 52                	jle    41322 <check_virtual_memory+0x167>
   412d0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412d3:	48 98                	cltq   
   412d5:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   412dc:	00 
   412dd:	84 c0                	test   %al,%al
   412df:	78 41                	js     41322 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   412e1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412e4:	48 98                	cltq   
   412e6:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   412ed:	00 
   412ee:	0f be c0             	movsbl %al,%eax
   412f1:	48 63 d0             	movslq %eax,%rdx
   412f4:	48 89 d0             	mov    %rdx,%rax
   412f7:	48 c1 e0 04          	shl    $0x4,%rax
   412fb:	48 29 d0             	sub    %rdx,%rax
   412fe:	48 c1 e0 04          	shl    $0x4,%rax
   41302:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   41308:	8b 00                	mov    (%rax),%eax
   4130a:	85 c0                	test   %eax,%eax
   4130c:	75 14                	jne    41322 <check_virtual_memory+0x167>
   4130e:	ba 88 51 04 00       	mov    $0x45188,%edx
   41313:	be a2 02 00 00       	mov    $0x2a2,%esi
   41318:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   4131d:	e8 d4 13 00 00       	call   426f6 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41322:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41326:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4132d:	7e 90                	jle    412bf <check_virtual_memory+0x104>
        }
    }
}
   4132f:	90                   	nop
   41330:	90                   	nop
   41331:	c9                   	leave  
   41332:	c3                   	ret    

0000000000041333 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41333:	55                   	push   %rbp
   41334:	48 89 e5             	mov    %rsp,%rbp
   41337:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4133b:	ba b8 51 04 00       	mov    $0x451b8,%edx
   41340:	be 00 0f 00 00       	mov    $0xf00,%esi
   41345:	bf 20 00 00 00       	mov    $0x20,%edi
   4134a:	b8 00 00 00 00       	mov    $0x0,%eax
   4134f:	e8 d9 38 00 00       	call   44c2d <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41354:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4135b:	e9 f8 00 00 00       	jmp    41458 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41360:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41363:	83 e0 3f             	and    $0x3f,%eax
   41366:	85 c0                	test   %eax,%eax
   41368:	75 3c                	jne    413a6 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4136a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4136d:	c1 e0 0c             	shl    $0xc,%eax
   41370:	89 c1                	mov    %eax,%ecx
   41372:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41375:	8d 50 3f             	lea    0x3f(%rax),%edx
   41378:	85 c0                	test   %eax,%eax
   4137a:	0f 48 c2             	cmovs  %edx,%eax
   4137d:	c1 f8 06             	sar    $0x6,%eax
   41380:	8d 50 01             	lea    0x1(%rax),%edx
   41383:	89 d0                	mov    %edx,%eax
   41385:	c1 e0 02             	shl    $0x2,%eax
   41388:	01 d0                	add    %edx,%eax
   4138a:	c1 e0 04             	shl    $0x4,%eax
   4138d:	83 c0 03             	add    $0x3,%eax
   41390:	ba c8 51 04 00       	mov    $0x451c8,%edx
   41395:	be 00 0f 00 00       	mov    $0xf00,%esi
   4139a:	89 c7                	mov    %eax,%edi
   4139c:	b8 00 00 00 00       	mov    $0x0,%eax
   413a1:	e8 87 38 00 00       	call   44c2d <console_printf>
        }

        int owner = pageinfo[pn].owner;
   413a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413a9:	48 98                	cltq   
   413ab:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   413b2:	00 
   413b3:	0f be c0             	movsbl %al,%eax
   413b6:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   413b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413bc:	48 98                	cltq   
   413be:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   413c5:	00 
   413c6:	84 c0                	test   %al,%al
   413c8:	75 07                	jne    413d1 <memshow_physical+0x9e>
            owner = PO_FREE;
   413ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   413d1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   413d4:	83 c0 02             	add    $0x2,%eax
   413d7:	48 98                	cltq   
   413d9:	0f b7 84 00 e0 4d 04 	movzwl 0x44de0(%rax,%rax,1),%eax
   413e0:	00 
   413e1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   413e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413e8:	48 98                	cltq   
   413ea:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   413f1:	00 
   413f2:	3c 01                	cmp    $0x1,%al
   413f4:	7e 1a                	jle    41410 <memshow_physical+0xdd>
   413f6:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   413fb:	48 c1 e8 0c          	shr    $0xc,%rax
   413ff:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41402:	74 0c                	je     41410 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41404:	b8 53 00 00 00       	mov    $0x53,%eax
   41409:	80 cc 0f             	or     $0xf,%ah
   4140c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41410:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41413:	8d 50 3f             	lea    0x3f(%rax),%edx
   41416:	85 c0                	test   %eax,%eax
   41418:	0f 48 c2             	cmovs  %edx,%eax
   4141b:	c1 f8 06             	sar    $0x6,%eax
   4141e:	8d 50 01             	lea    0x1(%rax),%edx
   41421:	89 d0                	mov    %edx,%eax
   41423:	c1 e0 02             	shl    $0x2,%eax
   41426:	01 d0                	add    %edx,%eax
   41428:	c1 e0 04             	shl    $0x4,%eax
   4142b:	89 c1                	mov    %eax,%ecx
   4142d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41430:	89 d0                	mov    %edx,%eax
   41432:	c1 f8 1f             	sar    $0x1f,%eax
   41435:	c1 e8 1a             	shr    $0x1a,%eax
   41438:	01 c2                	add    %eax,%edx
   4143a:	83 e2 3f             	and    $0x3f,%edx
   4143d:	29 c2                	sub    %eax,%edx
   4143f:	89 d0                	mov    %edx,%eax
   41441:	83 c0 0c             	add    $0xc,%eax
   41444:	01 c8                	add    %ecx,%eax
   41446:	48 98                	cltq   
   41448:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4144c:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41453:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41454:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41458:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4145f:	0f 8e fb fe ff ff    	jle    41360 <memshow_physical+0x2d>
    }
}
   41465:	90                   	nop
   41466:	90                   	nop
   41467:	c9                   	leave  
   41468:	c3                   	ret    

0000000000041469 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41469:	55                   	push   %rbp
   4146a:	48 89 e5             	mov    %rsp,%rbp
   4146d:	48 83 ec 40          	sub    $0x40,%rsp
   41471:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41475:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41479:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4147d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41483:	48 89 c2             	mov    %rax,%rdx
   41486:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4148a:	48 39 c2             	cmp    %rax,%rdx
   4148d:	74 14                	je     414a3 <memshow_virtual+0x3a>
   4148f:	ba d0 51 04 00       	mov    $0x451d0,%edx
   41494:	be d3 02 00 00       	mov    $0x2d3,%esi
   41499:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   4149e:	e8 53 12 00 00       	call   426f6 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   414a3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   414a7:	48 89 c1             	mov    %rax,%rcx
   414aa:	ba fd 51 04 00       	mov    $0x451fd,%edx
   414af:	be 00 0f 00 00       	mov    $0xf00,%esi
   414b4:	bf 3a 03 00 00       	mov    $0x33a,%edi
   414b9:	b8 00 00 00 00       	mov    $0x0,%eax
   414be:	e8 6a 37 00 00       	call   44c2d <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414c3:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   414ca:	00 
   414cb:	e9 80 01 00 00       	jmp    41650 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   414d0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   414d4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   414d8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   414dc:	48 89 ce             	mov    %rcx,%rsi
   414df:	48 89 c7             	mov    %rax,%rdi
   414e2:	e8 d1 18 00 00       	call   42db8 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   414e7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414ea:	85 c0                	test   %eax,%eax
   414ec:	79 0b                	jns    414f9 <memshow_virtual+0x90>
            color = ' ';
   414ee:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   414f4:	e9 d7 00 00 00       	jmp    415d0 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   414f9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   414fd:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41503:	76 14                	jbe    41519 <memshow_virtual+0xb0>
   41505:	ba 1a 52 04 00       	mov    $0x4521a,%edx
   4150a:	be dc 02 00 00       	mov    $0x2dc,%esi
   4150f:	bf 48 4e 04 00       	mov    $0x44e48,%edi
   41514:	e8 dd 11 00 00       	call   426f6 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41519:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4151c:	48 98                	cltq   
   4151e:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   41525:	00 
   41526:	0f be c0             	movsbl %al,%eax
   41529:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4152c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4152f:	48 98                	cltq   
   41531:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   41538:	00 
   41539:	84 c0                	test   %al,%al
   4153b:	75 07                	jne    41544 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4153d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41544:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41547:	83 c0 02             	add    $0x2,%eax
   4154a:	48 98                	cltq   
   4154c:	0f b7 84 00 e0 4d 04 	movzwl 0x44de0(%rax,%rax,1),%eax
   41553:	00 
   41554:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41558:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4155b:	48 98                	cltq   
   4155d:	83 e0 04             	and    $0x4,%eax
   41560:	48 85 c0             	test   %rax,%rax
   41563:	74 27                	je     4158c <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41565:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41569:	c1 e0 04             	shl    $0x4,%eax
   4156c:	66 25 00 f0          	and    $0xf000,%ax
   41570:	89 c2                	mov    %eax,%edx
   41572:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41576:	c1 f8 04             	sar    $0x4,%eax
   41579:	66 25 00 0f          	and    $0xf00,%ax
   4157d:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4157f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41583:	0f b6 c0             	movzbl %al,%eax
   41586:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41588:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4158c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4158f:	48 98                	cltq   
   41591:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   41598:	00 
   41599:	3c 01                	cmp    $0x1,%al
   4159b:	7e 33                	jle    415d0 <memshow_virtual+0x167>
   4159d:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   415a2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   415a6:	74 28                	je     415d0 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   415a8:	b8 53 00 00 00       	mov    $0x53,%eax
   415ad:	89 c2                	mov    %eax,%edx
   415af:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415b3:	66 25 00 f0          	and    $0xf000,%ax
   415b7:	09 d0                	or     %edx,%eax
   415b9:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   415bd:	8b 45 e0             	mov    -0x20(%rbp),%eax
   415c0:	48 98                	cltq   
   415c2:	83 e0 04             	and    $0x4,%eax
   415c5:	48 85 c0             	test   %rax,%rax
   415c8:	75 06                	jne    415d0 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   415ca:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   415d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415d4:	48 c1 e8 0c          	shr    $0xc,%rax
   415d8:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   415db:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415de:	83 e0 3f             	and    $0x3f,%eax
   415e1:	85 c0                	test   %eax,%eax
   415e3:	75 34                	jne    41619 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   415e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415e8:	c1 e8 06             	shr    $0x6,%eax
   415eb:	89 c2                	mov    %eax,%edx
   415ed:	89 d0                	mov    %edx,%eax
   415ef:	c1 e0 02             	shl    $0x2,%eax
   415f2:	01 d0                	add    %edx,%eax
   415f4:	c1 e0 04             	shl    $0x4,%eax
   415f7:	05 73 03 00 00       	add    $0x373,%eax
   415fc:	89 c7                	mov    %eax,%edi
   415fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41602:	48 89 c1             	mov    %rax,%rcx
   41605:	ba c8 51 04 00       	mov    $0x451c8,%edx
   4160a:	be 00 0f 00 00       	mov    $0xf00,%esi
   4160f:	b8 00 00 00 00       	mov    $0x0,%eax
   41614:	e8 14 36 00 00       	call   44c2d <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41619:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4161c:	c1 e8 06             	shr    $0x6,%eax
   4161f:	89 c2                	mov    %eax,%edx
   41621:	89 d0                	mov    %edx,%eax
   41623:	c1 e0 02             	shl    $0x2,%eax
   41626:	01 d0                	add    %edx,%eax
   41628:	c1 e0 04             	shl    $0x4,%eax
   4162b:	89 c2                	mov    %eax,%edx
   4162d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41630:	83 e0 3f             	and    $0x3f,%eax
   41633:	01 d0                	add    %edx,%eax
   41635:	05 7c 03 00 00       	add    $0x37c,%eax
   4163a:	89 c2                	mov    %eax,%edx
   4163c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41640:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41647:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41648:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4164f:	00 
   41650:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41657:	00 
   41658:	0f 86 72 fe ff ff    	jbe    414d0 <memshow_virtual+0x67>
    }
}
   4165e:	90                   	nop
   4165f:	90                   	nop
   41660:	c9                   	leave  
   41661:	c3                   	ret    

0000000000041662 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41662:	55                   	push   %rbp
   41663:	48 89 e5             	mov    %rsp,%rbp
   41666:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4166a:	8b 05 b4 fc 00 00    	mov    0xfcb4(%rip),%eax        # 51324 <last_ticks.1>
   41670:	85 c0                	test   %eax,%eax
   41672:	74 13                	je     41687 <memshow_virtual_animate+0x25>
   41674:	8b 15 a6 fc 00 00    	mov    0xfca6(%rip),%edx        # 51320 <ticks>
   4167a:	8b 05 a4 fc 00 00    	mov    0xfca4(%rip),%eax        # 51324 <last_ticks.1>
   41680:	29 c2                	sub    %eax,%edx
   41682:	83 fa 31             	cmp    $0x31,%edx
   41685:	76 2c                	jbe    416b3 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41687:	8b 05 93 fc 00 00    	mov    0xfc93(%rip),%eax        # 51320 <ticks>
   4168d:	89 05 91 fc 00 00    	mov    %eax,0xfc91(%rip)        # 51324 <last_ticks.1>
        ++showing;
   41693:	8b 05 6b 49 00 00    	mov    0x496b(%rip),%eax        # 46004 <showing.0>
   41699:	83 c0 01             	add    $0x1,%eax
   4169c:	89 05 62 49 00 00    	mov    %eax,0x4962(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   416a2:	eb 0f                	jmp    416b3 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   416a4:	8b 05 5a 49 00 00    	mov    0x495a(%rip),%eax        # 46004 <showing.0>
   416aa:	83 c0 01             	add    $0x1,%eax
   416ad:	89 05 51 49 00 00    	mov    %eax,0x4951(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   416b3:	8b 05 4b 49 00 00    	mov    0x494b(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   416b9:	83 f8 20             	cmp    $0x20,%eax
   416bc:	7f 34                	jg     416f2 <memshow_virtual_animate+0x90>
   416be:	8b 15 40 49 00 00    	mov    0x4940(%rip),%edx        # 46004 <showing.0>
   416c4:	89 d0                	mov    %edx,%eax
   416c6:	c1 f8 1f             	sar    $0x1f,%eax
   416c9:	c1 e8 1c             	shr    $0x1c,%eax
   416cc:	01 c2                	add    %eax,%edx
   416ce:	83 e2 0f             	and    $0xf,%edx
   416d1:	29 c2                	sub    %eax,%edx
   416d3:	89 d0                	mov    %edx,%eax
   416d5:	48 63 d0             	movslq %eax,%rdx
   416d8:	48 89 d0             	mov    %rdx,%rax
   416db:	48 c1 e0 04          	shl    $0x4,%rax
   416df:	48 29 d0             	sub    %rdx,%rax
   416e2:	48 c1 e0 04          	shl    $0x4,%rax
   416e6:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   416ec:	8b 00                	mov    (%rax),%eax
   416ee:	85 c0                	test   %eax,%eax
   416f0:	74 b2                	je     416a4 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   416f2:	8b 15 0c 49 00 00    	mov    0x490c(%rip),%edx        # 46004 <showing.0>
   416f8:	89 d0                	mov    %edx,%eax
   416fa:	c1 f8 1f             	sar    $0x1f,%eax
   416fd:	c1 e8 1c             	shr    $0x1c,%eax
   41700:	01 c2                	add    %eax,%edx
   41702:	83 e2 0f             	and    $0xf,%edx
   41705:	29 c2                	sub    %eax,%edx
   41707:	89 d0                	mov    %edx,%eax
   41709:	89 05 f5 48 00 00    	mov    %eax,0x48f5(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4170f:	8b 05 ef 48 00 00    	mov    0x48ef(%rip),%eax        # 46004 <showing.0>
   41715:	48 63 d0             	movslq %eax,%rdx
   41718:	48 89 d0             	mov    %rdx,%rax
   4171b:	48 c1 e0 04          	shl    $0x4,%rax
   4171f:	48 29 d0             	sub    %rdx,%rax
   41722:	48 c1 e0 04          	shl    $0x4,%rax
   41726:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   4172c:	8b 00                	mov    (%rax),%eax
   4172e:	85 c0                	test   %eax,%eax
   41730:	74 76                	je     417a8 <memshow_virtual_animate+0x146>
   41732:	8b 05 cc 48 00 00    	mov    0x48cc(%rip),%eax        # 46004 <showing.0>
   41738:	48 63 d0             	movslq %eax,%rdx
   4173b:	48 89 d0             	mov    %rdx,%rax
   4173e:	48 c1 e0 04          	shl    $0x4,%rax
   41742:	48 29 d0             	sub    %rdx,%rax
   41745:	48 c1 e0 04          	shl    $0x4,%rax
   41749:	48 05 e8 00 05 00    	add    $0x500e8,%rax
   4174f:	0f b6 00             	movzbl (%rax),%eax
   41752:	84 c0                	test   %al,%al
   41754:	74 52                	je     417a8 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41756:	8b 15 a8 48 00 00    	mov    0x48a8(%rip),%edx        # 46004 <showing.0>
   4175c:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41760:	89 d1                	mov    %edx,%ecx
   41762:	ba 34 52 04 00       	mov    $0x45234,%edx
   41767:	be 04 00 00 00       	mov    $0x4,%esi
   4176c:	48 89 c7             	mov    %rax,%rdi
   4176f:	b8 00 00 00 00       	mov    $0x0,%eax
   41774:	e8 c0 35 00 00       	call   44d39 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41779:	8b 05 85 48 00 00    	mov    0x4885(%rip),%eax        # 46004 <showing.0>
   4177f:	48 63 d0             	movslq %eax,%rdx
   41782:	48 89 d0             	mov    %rdx,%rax
   41785:	48 c1 e0 04          	shl    $0x4,%rax
   41789:	48 29 d0             	sub    %rdx,%rax
   4178c:	48 c1 e0 04          	shl    $0x4,%rax
   41790:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   41796:	48 8b 00             	mov    (%rax),%rax
   41799:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4179d:	48 89 d6             	mov    %rdx,%rsi
   417a0:	48 89 c7             	mov    %rax,%rdi
   417a3:	e8 c1 fc ff ff       	call   41469 <memshow_virtual>
    }
}
   417a8:	90                   	nop
   417a9:	c9                   	leave  
   417aa:	c3                   	ret    

00000000000417ab <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   417ab:	55                   	push   %rbp
   417ac:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   417af:	e8 4f 01 00 00       	call   41903 <segments_init>
    interrupt_init();
   417b4:	e8 d0 03 00 00       	call   41b89 <interrupt_init>
    virtual_memory_init();
   417b9:	e8 f3 0f 00 00       	call   427b1 <virtual_memory_init>
}
   417be:	90                   	nop
   417bf:	5d                   	pop    %rbp
   417c0:	c3                   	ret    

00000000000417c1 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   417c1:	55                   	push   %rbp
   417c2:	48 89 e5             	mov    %rsp,%rbp
   417c5:	48 83 ec 18          	sub    $0x18,%rsp
   417c9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417cd:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417d1:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   417d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417d7:	48 98                	cltq   
   417d9:	48 c1 e0 2d          	shl    $0x2d,%rax
   417dd:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   417e1:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   417e8:	90 00 00 
   417eb:	48 09 c2             	or     %rax,%rdx
    *segment = type
   417ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417f2:	48 89 10             	mov    %rdx,(%rax)
}
   417f5:	90                   	nop
   417f6:	c9                   	leave  
   417f7:	c3                   	ret    

00000000000417f8 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   417f8:	55                   	push   %rbp
   417f9:	48 89 e5             	mov    %rsp,%rbp
   417fc:	48 83 ec 28          	sub    $0x28,%rsp
   41800:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41804:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41808:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4180b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4180f:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41813:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41817:	48 c1 e0 10          	shl    $0x10,%rax
   4181b:	48 89 c2             	mov    %rax,%rdx
   4181e:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41825:	00 00 00 
   41828:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4182b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4182f:	48 c1 e0 20          	shl    $0x20,%rax
   41833:	48 89 c1             	mov    %rax,%rcx
   41836:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4183d:	00 00 ff 
   41840:	48 21 c8             	and    %rcx,%rax
   41843:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41846:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4184a:	48 83 e8 01          	sub    $0x1,%rax
   4184e:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41851:	48 09 d0             	or     %rdx,%rax
        | type
   41854:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41858:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4185b:	48 63 d2             	movslq %edx,%rdx
   4185e:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41862:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41865:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4186c:	80 00 00 
   4186f:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41872:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41876:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41879:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4187d:	48 83 c0 08          	add    $0x8,%rax
   41881:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41885:	48 c1 ea 20          	shr    $0x20,%rdx
   41889:	48 89 10             	mov    %rdx,(%rax)
}
   4188c:	90                   	nop
   4188d:	c9                   	leave  
   4188e:	c3                   	ret    

000000000004188f <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4188f:	55                   	push   %rbp
   41890:	48 89 e5             	mov    %rsp,%rbp
   41893:	48 83 ec 20          	sub    $0x20,%rsp
   41897:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4189b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4189f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418a2:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418aa:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   418ad:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   418b1:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418b4:	48 63 d2             	movslq %edx,%rdx
   418b7:	48 c1 e2 2d          	shl    $0x2d,%rdx
   418bb:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   418be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418c2:	48 c1 e0 20          	shl    $0x20,%rax
   418c6:	48 89 c1             	mov    %rax,%rcx
   418c9:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   418d0:	00 ff ff 
   418d3:	48 21 c8             	and    %rcx,%rax
   418d6:	48 09 c2             	or     %rax,%rdx
   418d9:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   418e0:	80 00 00 
   418e3:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418ea:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   418ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418f1:	48 c1 e8 20          	shr    $0x20,%rax
   418f5:	48 89 c2             	mov    %rax,%rdx
   418f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418fc:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41900:	90                   	nop
   41901:	c9                   	leave  
   41902:	c3                   	ret    

0000000000041903 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41903:	55                   	push   %rbp
   41904:	48 89 e5             	mov    %rsp,%rbp
   41907:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4190b:	48 c7 05 2a fa 00 00 	movq   $0x0,0xfa2a(%rip)        # 51340 <segments>
   41912:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41916:	ba 00 00 00 00       	mov    $0x0,%edx
   4191b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41922:	08 20 00 
   41925:	48 89 c6             	mov    %rax,%rsi
   41928:	bf 48 13 05 00       	mov    $0x51348,%edi
   4192d:	e8 8f fe ff ff       	call   417c1 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41932:	ba 03 00 00 00       	mov    $0x3,%edx
   41937:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4193e:	08 20 00 
   41941:	48 89 c6             	mov    %rax,%rsi
   41944:	bf 50 13 05 00       	mov    $0x51350,%edi
   41949:	e8 73 fe ff ff       	call   417c1 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4194e:	ba 00 00 00 00       	mov    $0x0,%edx
   41953:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4195a:	02 00 00 
   4195d:	48 89 c6             	mov    %rax,%rsi
   41960:	bf 58 13 05 00       	mov    $0x51358,%edi
   41965:	e8 57 fe ff ff       	call   417c1 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4196a:	ba 03 00 00 00       	mov    $0x3,%edx
   4196f:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41976:	02 00 00 
   41979:	48 89 c6             	mov    %rax,%rsi
   4197c:	bf 60 13 05 00       	mov    $0x51360,%edi
   41981:	e8 3b fe ff ff       	call   417c1 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41986:	b8 80 23 05 00       	mov    $0x52380,%eax
   4198b:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41991:	48 89 c1             	mov    %rax,%rcx
   41994:	ba 00 00 00 00       	mov    $0x0,%edx
   41999:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   419a0:	09 00 00 
   419a3:	48 89 c6             	mov    %rax,%rsi
   419a6:	bf 68 13 05 00       	mov    $0x51368,%edi
   419ab:	e8 48 fe ff ff       	call   417f8 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   419b0:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   419b6:	b8 40 13 05 00       	mov    $0x51340,%eax
   419bb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   419bf:	ba 60 00 00 00       	mov    $0x60,%edx
   419c4:	be 00 00 00 00       	mov    $0x0,%esi
   419c9:	bf 80 23 05 00       	mov    $0x52380,%edi
   419ce:	e8 a3 24 00 00       	call   43e76 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   419d3:	48 c7 05 a6 09 01 00 	movq   $0x80000,0x109a6(%rip)        # 52384 <kernel_task_descriptor+0x4>
   419da:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   419de:	ba 00 10 00 00       	mov    $0x1000,%edx
   419e3:	be 00 00 00 00       	mov    $0x0,%esi
   419e8:	bf 80 13 05 00       	mov    $0x51380,%edi
   419ed:	e8 84 24 00 00       	call   43e76 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   419f2:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   419f9:	eb 30                	jmp    41a2b <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   419fb:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41a00:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a03:	48 c1 e0 04          	shl    $0x4,%rax
   41a07:	48 05 80 13 05 00    	add    $0x51380,%rax
   41a0d:	48 89 d1             	mov    %rdx,%rcx
   41a10:	ba 00 00 00 00       	mov    $0x0,%edx
   41a15:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a1c:	0e 00 00 
   41a1f:	48 89 c7             	mov    %rax,%rdi
   41a22:	e8 68 fe ff ff       	call   4188f <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a27:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a2b:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41a32:	76 c7                	jbe    419fb <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41a34:	b8 36 00 04 00       	mov    $0x40036,%eax
   41a39:	48 89 c1             	mov    %rax,%rcx
   41a3c:	ba 00 00 00 00       	mov    $0x0,%edx
   41a41:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a48:	0e 00 00 
   41a4b:	48 89 c6             	mov    %rax,%rsi
   41a4e:	bf 80 15 05 00       	mov    $0x51580,%edi
   41a53:	e8 37 fe ff ff       	call   4188f <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41a58:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41a5d:	48 89 c1             	mov    %rax,%rcx
   41a60:	ba 00 00 00 00       	mov    $0x0,%edx
   41a65:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a6c:	0e 00 00 
   41a6f:	48 89 c6             	mov    %rax,%rsi
   41a72:	bf 50 14 05 00       	mov    $0x51450,%edi
   41a77:	e8 13 fe ff ff       	call   4188f <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41a7c:	b8 32 00 04 00       	mov    $0x40032,%eax
   41a81:	48 89 c1             	mov    %rax,%rcx
   41a84:	ba 00 00 00 00       	mov    $0x0,%edx
   41a89:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a90:	0e 00 00 
   41a93:	48 89 c6             	mov    %rax,%rsi
   41a96:	bf 60 14 05 00       	mov    $0x51460,%edi
   41a9b:	e8 ef fd ff ff       	call   4188f <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41aa0:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41aa7:	eb 3e                	jmp    41ae7 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41aa9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41aac:	83 e8 30             	sub    $0x30,%eax
   41aaf:	89 c0                	mov    %eax,%eax
   41ab1:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41ab8:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41ab9:	48 89 c2             	mov    %rax,%rdx
   41abc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41abf:	48 c1 e0 04          	shl    $0x4,%rax
   41ac3:	48 05 80 13 05 00    	add    $0x51380,%rax
   41ac9:	48 89 d1             	mov    %rdx,%rcx
   41acc:	ba 03 00 00 00       	mov    $0x3,%edx
   41ad1:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41ad8:	0e 00 00 
   41adb:	48 89 c7             	mov    %rax,%rdi
   41ade:	e8 ac fd ff ff       	call   4188f <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41ae3:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ae7:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41aeb:	76 bc                	jbe    41aa9 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41aed:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41af3:	b8 80 13 05 00       	mov    $0x51380,%eax
   41af8:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41afc:	b8 28 00 00 00       	mov    $0x28,%eax
   41b01:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41b05:	0f 00 d8             	ltr    %ax
   41b08:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41b0c:	0f 20 c0             	mov    %cr0,%rax
   41b0f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41b13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41b17:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41b1a:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41b21:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b24:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41b27:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b2a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41b2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b32:	0f 22 c0             	mov    %rax,%cr0
}
   41b35:	90                   	nop
    lcr0(cr0);
}
   41b36:	90                   	nop
   41b37:	c9                   	leave  
   41b38:	c3                   	ret    

0000000000041b39 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41b39:	55                   	push   %rbp
   41b3a:	48 89 e5             	mov    %rsp,%rbp
   41b3d:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41b41:	0f b7 05 98 08 01 00 	movzwl 0x10898(%rip),%eax        # 523e0 <interrupts_enabled>
   41b48:	f7 d0                	not    %eax
   41b4a:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41b4e:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b52:	0f b6 c0             	movzbl %al,%eax
   41b55:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41b5c:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b5f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41b63:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41b66:	ee                   	out    %al,(%dx)
}
   41b67:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41b68:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b6c:	66 c1 e8 08          	shr    $0x8,%ax
   41b70:	0f b6 c0             	movzbl %al,%eax
   41b73:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41b7a:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b7d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41b81:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41b84:	ee                   	out    %al,(%dx)
}
   41b85:	90                   	nop
}
   41b86:	90                   	nop
   41b87:	c9                   	leave  
   41b88:	c3                   	ret    

0000000000041b89 <interrupt_init>:

void interrupt_init(void) {
   41b89:	55                   	push   %rbp
   41b8a:	48 89 e5             	mov    %rsp,%rbp
   41b8d:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41b91:	66 c7 05 46 08 01 00 	movw   $0x0,0x10846(%rip)        # 523e0 <interrupts_enabled>
   41b98:	00 00 
    interrupt_mask();
   41b9a:	e8 9a ff ff ff       	call   41b39 <interrupt_mask>
   41b9f:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41ba6:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41baa:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41bae:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41bb1:	ee                   	out    %al,(%dx)
}
   41bb2:	90                   	nop
   41bb3:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41bba:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bbe:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41bc2:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41bc5:	ee                   	out    %al,(%dx)
}
   41bc6:	90                   	nop
   41bc7:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41bce:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd2:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41bd6:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41bd9:	ee                   	out    %al,(%dx)
}
   41bda:	90                   	nop
   41bdb:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41be2:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41be6:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41bea:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41bed:	ee                   	out    %al,(%dx)
}
   41bee:	90                   	nop
   41bef:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41bf6:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bfa:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41bfe:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41c01:	ee                   	out    %al,(%dx)
}
   41c02:	90                   	nop
   41c03:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41c0a:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c0e:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41c12:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41c15:	ee                   	out    %al,(%dx)
}
   41c16:	90                   	nop
   41c17:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41c1e:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c22:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41c26:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41c29:	ee                   	out    %al,(%dx)
}
   41c2a:	90                   	nop
   41c2b:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41c32:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c36:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41c3a:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c3d:	ee                   	out    %al,(%dx)
}
   41c3e:	90                   	nop
   41c3f:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41c46:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c4a:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c4e:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c51:	ee                   	out    %al,(%dx)
}
   41c52:	90                   	nop
   41c53:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41c5a:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c5e:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c62:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c65:	ee                   	out    %al,(%dx)
}
   41c66:	90                   	nop
   41c67:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41c6e:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c72:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c76:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c79:	ee                   	out    %al,(%dx)
}
   41c7a:	90                   	nop
   41c7b:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41c82:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c86:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c8d:	ee                   	out    %al,(%dx)
}
   41c8e:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41c8f:	e8 a5 fe ff ff       	call   41b39 <interrupt_mask>
}
   41c94:	90                   	nop
   41c95:	c9                   	leave  
   41c96:	c3                   	ret    

0000000000041c97 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41c97:	55                   	push   %rbp
   41c98:	48 89 e5             	mov    %rsp,%rbp
   41c9b:	48 83 ec 28          	sub    $0x28,%rsp
   41c9f:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41ca2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ca6:	0f 8e 9e 00 00 00    	jle    41d4a <timer_init+0xb3>
   41cac:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41cb3:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41cbb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cbe:	ee                   	out    %al,(%dx)
}
   41cbf:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41cc0:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41cc3:	89 c2                	mov    %eax,%edx
   41cc5:	c1 ea 1f             	shr    $0x1f,%edx
   41cc8:	01 d0                	add    %edx,%eax
   41cca:	d1 f8                	sar    %eax
   41ccc:	05 de 34 12 00       	add    $0x1234de,%eax
   41cd1:	99                   	cltd   
   41cd2:	f7 7d dc             	idivl  -0x24(%rbp)
   41cd5:	89 c2                	mov    %eax,%edx
   41cd7:	89 d0                	mov    %edx,%eax
   41cd9:	c1 f8 1f             	sar    $0x1f,%eax
   41cdc:	c1 e8 18             	shr    $0x18,%eax
   41cdf:	01 c2                	add    %eax,%edx
   41ce1:	0f b6 d2             	movzbl %dl,%edx
   41ce4:	29 c2                	sub    %eax,%edx
   41ce6:	89 d0                	mov    %edx,%eax
   41ce8:	0f b6 c0             	movzbl %al,%eax
   41ceb:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41cf2:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cf5:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cf9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cfc:	ee                   	out    %al,(%dx)
}
   41cfd:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41cfe:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d01:	89 c2                	mov    %eax,%edx
   41d03:	c1 ea 1f             	shr    $0x1f,%edx
   41d06:	01 d0                	add    %edx,%eax
   41d08:	d1 f8                	sar    %eax
   41d0a:	05 de 34 12 00       	add    $0x1234de,%eax
   41d0f:	99                   	cltd   
   41d10:	f7 7d dc             	idivl  -0x24(%rbp)
   41d13:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41d19:	85 c0                	test   %eax,%eax
   41d1b:	0f 48 c2             	cmovs  %edx,%eax
   41d1e:	c1 f8 08             	sar    $0x8,%eax
   41d21:	0f b6 c0             	movzbl %al,%eax
   41d24:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41d2b:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d2e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d32:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d35:	ee                   	out    %al,(%dx)
}
   41d36:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41d37:	0f b7 05 a2 06 01 00 	movzwl 0x106a2(%rip),%eax        # 523e0 <interrupts_enabled>
   41d3e:	83 c8 01             	or     $0x1,%eax
   41d41:	66 89 05 98 06 01 00 	mov    %ax,0x10698(%rip)        # 523e0 <interrupts_enabled>
   41d48:	eb 11                	jmp    41d5b <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41d4a:	0f b7 05 8f 06 01 00 	movzwl 0x1068f(%rip),%eax        # 523e0 <interrupts_enabled>
   41d51:	83 e0 fe             	and    $0xfffffffe,%eax
   41d54:	66 89 05 85 06 01 00 	mov    %ax,0x10685(%rip)        # 523e0 <interrupts_enabled>
    }
    interrupt_mask();
   41d5b:	e8 d9 fd ff ff       	call   41b39 <interrupt_mask>
}
   41d60:	90                   	nop
   41d61:	c9                   	leave  
   41d62:	c3                   	ret    

0000000000041d63 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41d63:	55                   	push   %rbp
   41d64:	48 89 e5             	mov    %rsp,%rbp
   41d67:	48 83 ec 08          	sub    $0x8,%rsp
   41d6b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41d6f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41d74:	74 14                	je     41d8a <physical_memory_isreserved+0x27>
   41d76:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41d7d:	00 
   41d7e:	76 11                	jbe    41d91 <physical_memory_isreserved+0x2e>
   41d80:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41d87:	00 
   41d88:	77 07                	ja     41d91 <physical_memory_isreserved+0x2e>
   41d8a:	b8 01 00 00 00       	mov    $0x1,%eax
   41d8f:	eb 05                	jmp    41d96 <physical_memory_isreserved+0x33>
   41d91:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41d96:	c9                   	leave  
   41d97:	c3                   	ret    

0000000000041d98 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41d98:	55                   	push   %rbp
   41d99:	48 89 e5             	mov    %rsp,%rbp
   41d9c:	48 83 ec 10          	sub    $0x10,%rsp
   41da0:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41da3:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41da6:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41da9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dac:	c1 e0 10             	shl    $0x10,%eax
   41daf:	89 c2                	mov    %eax,%edx
   41db1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41db4:	c1 e0 0b             	shl    $0xb,%eax
   41db7:	09 c2                	or     %eax,%edx
   41db9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41dbc:	c1 e0 08             	shl    $0x8,%eax
   41dbf:	09 d0                	or     %edx,%eax
}
   41dc1:	c9                   	leave  
   41dc2:	c3                   	ret    

0000000000041dc3 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41dc3:	55                   	push   %rbp
   41dc4:	48 89 e5             	mov    %rsp,%rbp
   41dc7:	48 83 ec 18          	sub    $0x18,%rsp
   41dcb:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41dce:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41dd1:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41dd4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41dd7:	09 d0                	or     %edx,%eax
   41dd9:	0d 00 00 00 80       	or     $0x80000000,%eax
   41dde:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41de5:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41de8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41deb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dee:	ef                   	out    %eax,(%dx)
}
   41def:	90                   	nop
   41df0:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41df7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dfa:	89 c2                	mov    %eax,%edx
   41dfc:	ed                   	in     (%dx),%eax
   41dfd:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41e00:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41e03:	c9                   	leave  
   41e04:	c3                   	ret    

0000000000041e05 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41e05:	55                   	push   %rbp
   41e06:	48 89 e5             	mov    %rsp,%rbp
   41e09:	48 83 ec 28          	sub    $0x28,%rsp
   41e0d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41e10:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41e13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e1a:	eb 73                	jmp    41e8f <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41e1c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41e23:	eb 60                	jmp    41e85 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41e25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41e2c:	eb 4a                	jmp    41e78 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41e2e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e31:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41e34:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e37:	89 ce                	mov    %ecx,%esi
   41e39:	89 c7                	mov    %eax,%edi
   41e3b:	e8 58 ff ff ff       	call   41d98 <pci_make_configaddr>
   41e40:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41e43:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e46:	be 00 00 00 00       	mov    $0x0,%esi
   41e4b:	89 c7                	mov    %eax,%edi
   41e4d:	e8 71 ff ff ff       	call   41dc3 <pci_config_readl>
   41e52:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41e55:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41e58:	c1 e0 10             	shl    $0x10,%eax
   41e5b:	0b 45 dc             	or     -0x24(%rbp),%eax
   41e5e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41e61:	75 05                	jne    41e68 <pci_find_device+0x63>
                    return configaddr;
   41e63:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e66:	eb 35                	jmp    41e9d <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41e68:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41e6c:	75 06                	jne    41e74 <pci_find_device+0x6f>
   41e6e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41e72:	74 0c                	je     41e80 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41e74:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41e78:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41e7c:	75 b0                	jne    41e2e <pci_find_device+0x29>
   41e7e:	eb 01                	jmp    41e81 <pci_find_device+0x7c>
                    break;
   41e80:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41e81:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41e85:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41e89:	75 9a                	jne    41e25 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41e8b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41e8f:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41e96:	75 84                	jne    41e1c <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41e98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41e9d:	c9                   	leave  
   41e9e:	c3                   	ret    

0000000000041e9f <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41e9f:	55                   	push   %rbp
   41ea0:	48 89 e5             	mov    %rsp,%rbp
   41ea3:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41ea7:	be 13 71 00 00       	mov    $0x7113,%esi
   41eac:	bf 86 80 00 00       	mov    $0x8086,%edi
   41eb1:	e8 4f ff ff ff       	call   41e05 <pci_find_device>
   41eb6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41eb9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41ebd:	78 30                	js     41eef <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41ebf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ec2:	be 40 00 00 00       	mov    $0x40,%esi
   41ec7:	89 c7                	mov    %eax,%edi
   41ec9:	e8 f5 fe ff ff       	call   41dc3 <pci_config_readl>
   41ece:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41ed3:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41ed6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ed9:	83 c0 04             	add    $0x4,%eax
   41edc:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41edf:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ee5:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41ee9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eec:	66 ef                	out    %ax,(%dx)
}
   41eee:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41eef:	ba 40 52 04 00       	mov    $0x45240,%edx
   41ef4:	be 00 c0 00 00       	mov    $0xc000,%esi
   41ef9:	bf 80 07 00 00       	mov    $0x780,%edi
   41efe:	b8 00 00 00 00       	mov    $0x0,%eax
   41f03:	e8 25 2d 00 00       	call   44c2d <console_printf>
 spinloop: goto spinloop;
   41f08:	eb fe                	jmp    41f08 <poweroff+0x69>

0000000000041f0a <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41f0a:	55                   	push   %rbp
   41f0b:	48 89 e5             	mov    %rsp,%rbp
   41f0e:	48 83 ec 10          	sub    $0x10,%rsp
   41f12:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41f19:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f1d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f21:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f24:	ee                   	out    %al,(%dx)
}
   41f25:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41f26:	eb fe                	jmp    41f26 <reboot+0x1c>

0000000000041f28 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41f28:	55                   	push   %rbp
   41f29:	48 89 e5             	mov    %rsp,%rbp
   41f2c:	48 83 ec 10          	sub    $0x10,%rsp
   41f30:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f34:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41f37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f3b:	48 83 c0 18          	add    $0x18,%rax
   41f3f:	ba c0 00 00 00       	mov    $0xc0,%edx
   41f44:	be 00 00 00 00       	mov    $0x0,%esi
   41f49:	48 89 c7             	mov    %rax,%rdi
   41f4c:	e8 25 1f 00 00       	call   43e76 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41f51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f55:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41f5c:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41f5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f62:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41f69:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41f6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f71:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41f78:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41f7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f80:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41f87:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41f89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f8d:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41f94:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41f98:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f9b:	83 e0 01             	and    $0x1,%eax
   41f9e:	85 c0                	test   %eax,%eax
   41fa0:	74 1c                	je     41fbe <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41fa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fa6:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41fad:	80 cc 30             	or     $0x30,%ah
   41fb0:	48 89 c2             	mov    %rax,%rdx
   41fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fb7:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41fbe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fc1:	83 e0 02             	and    $0x2,%eax
   41fc4:	85 c0                	test   %eax,%eax
   41fc6:	74 1c                	je     41fe4 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41fc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fcc:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41fd3:	80 e4 fd             	and    $0xfd,%ah
   41fd6:	48 89 c2             	mov    %rax,%rdx
   41fd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fdd:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fe8:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41fef:	90                   	nop
   41ff0:	c9                   	leave  
   41ff1:	c3                   	ret    

0000000000041ff2 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41ff2:	55                   	push   %rbp
   41ff3:	48 89 e5             	mov    %rsp,%rbp
   41ff6:	48 83 ec 28          	sub    $0x28,%rsp
   41ffa:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41ffd:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42001:	78 09                	js     4200c <console_show_cursor+0x1a>
   42003:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4200a:	7e 07                	jle    42013 <console_show_cursor+0x21>
        cpos = 0;
   4200c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42013:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4201a:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4201e:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42022:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42025:	ee                   	out    %al,(%dx)
}
   42026:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42027:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4202a:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42030:	85 c0                	test   %eax,%eax
   42032:	0f 48 c2             	cmovs  %edx,%eax
   42035:	c1 f8 08             	sar    $0x8,%eax
   42038:	0f b6 c0             	movzbl %al,%eax
   4203b:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42042:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42045:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42049:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4204c:	ee                   	out    %al,(%dx)
}
   4204d:	90                   	nop
   4204e:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42055:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42059:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4205d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42060:	ee                   	out    %al,(%dx)
}
   42061:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42062:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42065:	89 d0                	mov    %edx,%eax
   42067:	c1 f8 1f             	sar    $0x1f,%eax
   4206a:	c1 e8 18             	shr    $0x18,%eax
   4206d:	01 c2                	add    %eax,%edx
   4206f:	0f b6 d2             	movzbl %dl,%edx
   42072:	29 c2                	sub    %eax,%edx
   42074:	89 d0                	mov    %edx,%eax
   42076:	0f b6 c0             	movzbl %al,%eax
   42079:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42080:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42083:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42087:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4208a:	ee                   	out    %al,(%dx)
}
   4208b:	90                   	nop
}
   4208c:	90                   	nop
   4208d:	c9                   	leave  
   4208e:	c3                   	ret    

000000000004208f <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4208f:	55                   	push   %rbp
   42090:	48 89 e5             	mov    %rsp,%rbp
   42093:	48 83 ec 20          	sub    $0x20,%rsp
   42097:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4209e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   420a1:	89 c2                	mov    %eax,%edx
   420a3:	ec                   	in     (%dx),%al
   420a4:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   420a7:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   420ab:	0f b6 c0             	movzbl %al,%eax
   420ae:	83 e0 01             	and    $0x1,%eax
   420b1:	85 c0                	test   %eax,%eax
   420b3:	75 0a                	jne    420bf <keyboard_readc+0x30>
        return -1;
   420b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   420ba:	e9 e7 01 00 00       	jmp    422a6 <keyboard_readc+0x217>
   420bf:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   420c6:	8b 45 e8             	mov    -0x18(%rbp),%eax
   420c9:	89 c2                	mov    %eax,%edx
   420cb:	ec                   	in     (%dx),%al
   420cc:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   420cf:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   420d3:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   420d6:	0f b6 05 05 03 01 00 	movzbl 0x10305(%rip),%eax        # 523e2 <last_escape.2>
   420dd:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   420e0:	c6 05 fb 02 01 00 00 	movb   $0x0,0x102fb(%rip)        # 523e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   420e7:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   420eb:	75 11                	jne    420fe <keyboard_readc+0x6f>
        last_escape = 0x80;
   420ed:	c6 05 ee 02 01 00 80 	movb   $0x80,0x102ee(%rip)        # 523e2 <last_escape.2>
        return 0;
   420f4:	b8 00 00 00 00       	mov    $0x0,%eax
   420f9:	e9 a8 01 00 00       	jmp    422a6 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   420fe:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42102:	84 c0                	test   %al,%al
   42104:	79 60                	jns    42166 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42106:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4210a:	83 e0 7f             	and    $0x7f,%eax
   4210d:	89 c2                	mov    %eax,%edx
   4210f:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42113:	09 d0                	or     %edx,%eax
   42115:	48 98                	cltq   
   42117:	0f b6 80 60 52 04 00 	movzbl 0x45260(%rax),%eax
   4211e:	0f b6 c0             	movzbl %al,%eax
   42121:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42124:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4212b:	7e 2f                	jle    4215c <keyboard_readc+0xcd>
   4212d:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42134:	7f 26                	jg     4215c <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42136:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42139:	2d fa 00 00 00       	sub    $0xfa,%eax
   4213e:	ba 01 00 00 00       	mov    $0x1,%edx
   42143:	89 c1                	mov    %eax,%ecx
   42145:	d3 e2                	shl    %cl,%edx
   42147:	89 d0                	mov    %edx,%eax
   42149:	f7 d0                	not    %eax
   4214b:	89 c2                	mov    %eax,%edx
   4214d:	0f b6 05 8f 02 01 00 	movzbl 0x1028f(%rip),%eax        # 523e3 <modifiers.1>
   42154:	21 d0                	and    %edx,%eax
   42156:	88 05 87 02 01 00    	mov    %al,0x10287(%rip)        # 523e3 <modifiers.1>
        }
        return 0;
   4215c:	b8 00 00 00 00       	mov    $0x0,%eax
   42161:	e9 40 01 00 00       	jmp    422a6 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42166:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4216a:	0a 45 fa             	or     -0x6(%rbp),%al
   4216d:	0f b6 c0             	movzbl %al,%eax
   42170:	48 98                	cltq   
   42172:	0f b6 80 60 52 04 00 	movzbl 0x45260(%rax),%eax
   42179:	0f b6 c0             	movzbl %al,%eax
   4217c:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4217f:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42183:	7e 57                	jle    421dc <keyboard_readc+0x14d>
   42185:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42189:	7f 51                	jg     421dc <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   4218b:	0f b6 05 51 02 01 00 	movzbl 0x10251(%rip),%eax        # 523e3 <modifiers.1>
   42192:	0f b6 c0             	movzbl %al,%eax
   42195:	83 e0 02             	and    $0x2,%eax
   42198:	85 c0                	test   %eax,%eax
   4219a:	74 09                	je     421a5 <keyboard_readc+0x116>
            ch -= 0x60;
   4219c:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   421a0:	e9 fd 00 00 00       	jmp    422a2 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   421a5:	0f b6 05 37 02 01 00 	movzbl 0x10237(%rip),%eax        # 523e3 <modifiers.1>
   421ac:	0f b6 c0             	movzbl %al,%eax
   421af:	83 e0 01             	and    $0x1,%eax
   421b2:	85 c0                	test   %eax,%eax
   421b4:	0f 94 c2             	sete   %dl
   421b7:	0f b6 05 25 02 01 00 	movzbl 0x10225(%rip),%eax        # 523e3 <modifiers.1>
   421be:	0f b6 c0             	movzbl %al,%eax
   421c1:	83 e0 08             	and    $0x8,%eax
   421c4:	85 c0                	test   %eax,%eax
   421c6:	0f 94 c0             	sete   %al
   421c9:	31 d0                	xor    %edx,%eax
   421cb:	84 c0                	test   %al,%al
   421cd:	0f 84 cf 00 00 00    	je     422a2 <keyboard_readc+0x213>
            ch -= 0x20;
   421d3:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   421d7:	e9 c6 00 00 00       	jmp    422a2 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   421dc:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   421e3:	7e 30                	jle    42215 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   421e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421e8:	2d fa 00 00 00       	sub    $0xfa,%eax
   421ed:	ba 01 00 00 00       	mov    $0x1,%edx
   421f2:	89 c1                	mov    %eax,%ecx
   421f4:	d3 e2                	shl    %cl,%edx
   421f6:	89 d0                	mov    %edx,%eax
   421f8:	89 c2                	mov    %eax,%edx
   421fa:	0f b6 05 e2 01 01 00 	movzbl 0x101e2(%rip),%eax        # 523e3 <modifiers.1>
   42201:	31 d0                	xor    %edx,%eax
   42203:	88 05 da 01 01 00    	mov    %al,0x101da(%rip)        # 523e3 <modifiers.1>
        ch = 0;
   42209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42210:	e9 8e 00 00 00       	jmp    422a3 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42215:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4221c:	7e 2d                	jle    4224b <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4221e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42221:	2d fa 00 00 00       	sub    $0xfa,%eax
   42226:	ba 01 00 00 00       	mov    $0x1,%edx
   4222b:	89 c1                	mov    %eax,%ecx
   4222d:	d3 e2                	shl    %cl,%edx
   4222f:	89 d0                	mov    %edx,%eax
   42231:	89 c2                	mov    %eax,%edx
   42233:	0f b6 05 a9 01 01 00 	movzbl 0x101a9(%rip),%eax        # 523e3 <modifiers.1>
   4223a:	09 d0                	or     %edx,%eax
   4223c:	88 05 a1 01 01 00    	mov    %al,0x101a1(%rip)        # 523e3 <modifiers.1>
        ch = 0;
   42242:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42249:	eb 58                	jmp    422a3 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4224b:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4224f:	7e 31                	jle    42282 <keyboard_readc+0x1f3>
   42251:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42258:	7f 28                	jg     42282 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   4225a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4225d:	8d 50 80             	lea    -0x80(%rax),%edx
   42260:	0f b6 05 7c 01 01 00 	movzbl 0x1017c(%rip),%eax        # 523e3 <modifiers.1>
   42267:	0f b6 c0             	movzbl %al,%eax
   4226a:	83 e0 03             	and    $0x3,%eax
   4226d:	48 98                	cltq   
   4226f:	48 63 d2             	movslq %edx,%rdx
   42272:	0f b6 84 90 60 53 04 	movzbl 0x45360(%rax,%rdx,4),%eax
   42279:	00 
   4227a:	0f b6 c0             	movzbl %al,%eax
   4227d:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42280:	eb 21                	jmp    422a3 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42282:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42286:	7f 1b                	jg     422a3 <keyboard_readc+0x214>
   42288:	0f b6 05 54 01 01 00 	movzbl 0x10154(%rip),%eax        # 523e3 <modifiers.1>
   4228f:	0f b6 c0             	movzbl %al,%eax
   42292:	83 e0 02             	and    $0x2,%eax
   42295:	85 c0                	test   %eax,%eax
   42297:	74 0a                	je     422a3 <keyboard_readc+0x214>
        ch = 0;
   42299:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422a0:	eb 01                	jmp    422a3 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   422a2:	90                   	nop
    }

    return ch;
   422a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   422a6:	c9                   	leave  
   422a7:	c3                   	ret    

00000000000422a8 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   422a8:	55                   	push   %rbp
   422a9:	48 89 e5             	mov    %rsp,%rbp
   422ac:	48 83 ec 20          	sub    $0x20,%rsp
   422b0:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   422b7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   422ba:	89 c2                	mov    %eax,%edx
   422bc:	ec                   	in     (%dx),%al
   422bd:	88 45 e3             	mov    %al,-0x1d(%rbp)
   422c0:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   422c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   422ca:	89 c2                	mov    %eax,%edx
   422cc:	ec                   	in     (%dx),%al
   422cd:	88 45 eb             	mov    %al,-0x15(%rbp)
   422d0:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   422d7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422da:	89 c2                	mov    %eax,%edx
   422dc:	ec                   	in     (%dx),%al
   422dd:	88 45 f3             	mov    %al,-0xd(%rbp)
   422e0:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   422e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422ea:	89 c2                	mov    %eax,%edx
   422ec:	ec                   	in     (%dx),%al
   422ed:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   422f0:	90                   	nop
   422f1:	c9                   	leave  
   422f2:	c3                   	ret    

00000000000422f3 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   422f3:	55                   	push   %rbp
   422f4:	48 89 e5             	mov    %rsp,%rbp
   422f7:	48 83 ec 40          	sub    $0x40,%rsp
   422fb:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   422ff:	89 f0                	mov    %esi,%eax
   42301:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42304:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42307:	8b 05 d7 00 01 00    	mov    0x100d7(%rip),%eax        # 523e4 <initialized.0>
   4230d:	85 c0                	test   %eax,%eax
   4230f:	75 1e                	jne    4232f <parallel_port_putc+0x3c>
   42311:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42318:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4231c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42320:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42323:	ee                   	out    %al,(%dx)
}
   42324:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42325:	c7 05 b5 00 01 00 01 	movl   $0x1,0x100b5(%rip)        # 523e4 <initialized.0>
   4232c:	00 00 00 
    }

    for (int i = 0;
   4232f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42336:	eb 09                	jmp    42341 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42338:	e8 6b ff ff ff       	call   422a8 <delay>
         ++i) {
   4233d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42341:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42348:	7f 18                	jg     42362 <parallel_port_putc+0x6f>
   4234a:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42351:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42354:	89 c2                	mov    %eax,%edx
   42356:	ec                   	in     (%dx),%al
   42357:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4235a:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4235e:	84 c0                	test   %al,%al
   42360:	79 d6                	jns    42338 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42362:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42366:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4236d:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42370:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42374:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42377:	ee                   	out    %al,(%dx)
}
   42378:	90                   	nop
   42379:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42380:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42384:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42388:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4238b:	ee                   	out    %al,(%dx)
}
   4238c:	90                   	nop
   4238d:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42394:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42398:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4239c:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4239f:	ee                   	out    %al,(%dx)
}
   423a0:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   423a1:	90                   	nop
   423a2:	c9                   	leave  
   423a3:	c3                   	ret    

00000000000423a4 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   423a4:	55                   	push   %rbp
   423a5:	48 89 e5             	mov    %rsp,%rbp
   423a8:	48 83 ec 20          	sub    $0x20,%rsp
   423ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   423b0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   423b4:	48 c7 45 f8 f3 22 04 	movq   $0x422f3,-0x8(%rbp)
   423bb:	00 
    printer_vprintf(&p, 0, format, val);
   423bc:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   423c0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   423c4:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   423c8:	be 00 00 00 00       	mov    $0x0,%esi
   423cd:	48 89 c7             	mov    %rax,%rdi
   423d0:	e8 3d 1d 00 00       	call   44112 <printer_vprintf>
}
   423d5:	90                   	nop
   423d6:	c9                   	leave  
   423d7:	c3                   	ret    

00000000000423d8 <log_printf>:

void log_printf(const char* format, ...) {
   423d8:	55                   	push   %rbp
   423d9:	48 89 e5             	mov    %rsp,%rbp
   423dc:	48 83 ec 60          	sub    $0x60,%rsp
   423e0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   423e4:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   423e8:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   423ec:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423f0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423f4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423f8:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   423ff:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42403:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42407:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4240b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4240f:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42413:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42417:	48 89 d6             	mov    %rdx,%rsi
   4241a:	48 89 c7             	mov    %rax,%rdi
   4241d:	e8 82 ff ff ff       	call   423a4 <log_vprintf>
    va_end(val);
}
   42422:	90                   	nop
   42423:	c9                   	leave  
   42424:	c3                   	ret    

0000000000042425 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42425:	55                   	push   %rbp
   42426:	48 89 e5             	mov    %rsp,%rbp
   42429:	48 83 ec 40          	sub    $0x40,%rsp
   4242d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42430:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42433:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42437:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4243b:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4243f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42443:	48 8b 0a             	mov    (%rdx),%rcx
   42446:	48 89 08             	mov    %rcx,(%rax)
   42449:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4244d:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42451:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42455:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42459:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4245d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42461:	48 89 d6             	mov    %rdx,%rsi
   42464:	48 89 c7             	mov    %rax,%rdi
   42467:	e8 38 ff ff ff       	call   423a4 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4246c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42470:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42474:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42477:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4247a:	89 c7                	mov    %eax,%edi
   4247c:	e8 40 27 00 00       	call   44bc1 <console_vprintf>
}
   42481:	c9                   	leave  
   42482:	c3                   	ret    

0000000000042483 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42483:	55                   	push   %rbp
   42484:	48 89 e5             	mov    %rsp,%rbp
   42487:	48 83 ec 60          	sub    $0x60,%rsp
   4248b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4248e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42491:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42495:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42499:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4249d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424a1:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   424a8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424ac:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   424b0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424b4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   424b8:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   424bc:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   424c0:	8b 75 a8             	mov    -0x58(%rbp),%esi
   424c3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   424c6:	89 c7                	mov    %eax,%edi
   424c8:	e8 58 ff ff ff       	call   42425 <error_vprintf>
   424cd:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   424d0:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   424d3:	c9                   	leave  
   424d4:	c3                   	ret    

00000000000424d5 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   424d5:	55                   	push   %rbp
   424d6:	48 89 e5             	mov    %rsp,%rbp
   424d9:	53                   	push   %rbx
   424da:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   424de:	e8 ac fb ff ff       	call   4208f <keyboard_readc>
   424e3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   424e6:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   424ea:	74 1c                	je     42508 <check_keyboard+0x33>
   424ec:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   424f0:	74 16                	je     42508 <check_keyboard+0x33>
   424f2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   424f6:	74 10                	je     42508 <check_keyboard+0x33>
   424f8:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424fc:	74 0a                	je     42508 <check_keyboard+0x33>
   424fe:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42502:	0f 85 e9 00 00 00    	jne    425f1 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42508:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4250f:	00 
        memset(pt, 0, PAGESIZE * 3);
   42510:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42514:	ba 00 30 00 00       	mov    $0x3000,%edx
   42519:	be 00 00 00 00       	mov    $0x0,%esi
   4251e:	48 89 c7             	mov    %rax,%rdi
   42521:	e8 50 19 00 00       	call   43e76 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42526:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4252a:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42531:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42535:	48 05 00 10 00 00    	add    $0x1000,%rax
   4253b:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42542:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42546:	48 05 00 20 00 00    	add    $0x2000,%rax
   4254c:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42553:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42557:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4255b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4255f:	0f 22 d8             	mov    %rax,%cr3
}
   42562:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42563:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   4256a:	48 c7 45 e8 b8 53 04 	movq   $0x453b8,-0x18(%rbp)
   42571:	00 
        if (c == 'a') {
   42572:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42576:	75 0a                	jne    42582 <check_keyboard+0xad>
            argument = "allocator";
   42578:	48 c7 45 e8 bf 53 04 	movq   $0x453bf,-0x18(%rbp)
   4257f:	00 
   42580:	eb 2e                	jmp    425b0 <check_keyboard+0xdb>
        } else if (c == 'c') {
   42582:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42586:	75 0a                	jne    42592 <check_keyboard+0xbd>
            argument = "alloctests";
   42588:	48 c7 45 e8 c9 53 04 	movq   $0x453c9,-0x18(%rbp)
   4258f:	00 
   42590:	eb 1e                	jmp    425b0 <check_keyboard+0xdb>
        } else if(c == 't'){
   42592:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42596:	75 0a                	jne    425a2 <check_keyboard+0xcd>
            argument = "test";
   42598:	48 c7 45 e8 d4 53 04 	movq   $0x453d4,-0x18(%rbp)
   4259f:	00 
   425a0:	eb 0e                	jmp    425b0 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   425a2:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   425a6:	75 08                	jne    425b0 <check_keyboard+0xdb>
            argument = "test2";
   425a8:	48 c7 45 e8 d9 53 04 	movq   $0x453d9,-0x18(%rbp)
   425af:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   425b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425b4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   425b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   425bd:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   425c1:	73 14                	jae    425d7 <check_keyboard+0x102>
   425c3:	ba df 53 04 00       	mov    $0x453df,%edx
   425c8:	be 5c 02 00 00       	mov    $0x25c,%esi
   425cd:	bf fb 53 04 00       	mov    $0x453fb,%edi
   425d2:	e8 1f 01 00 00       	call   426f6 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   425d7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   425db:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   425de:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   425e2:	48 89 c3             	mov    %rax,%rbx
   425e5:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   425ea:	e9 11 da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   425ef:	eb 11                	jmp    42602 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   425f1:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   425f5:	74 06                	je     425fd <check_keyboard+0x128>
   425f7:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   425fb:	75 05                	jne    42602 <check_keyboard+0x12d>
        poweroff();
   425fd:	e8 9d f8 ff ff       	call   41e9f <poweroff>
    }
    return c;
   42602:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42605:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42609:	c9                   	leave  
   4260a:	c3                   	ret    

000000000004260b <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4260b:	55                   	push   %rbp
   4260c:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4260f:	e8 c1 fe ff ff       	call   424d5 <check_keyboard>
   42614:	eb f9                	jmp    4260f <fail+0x4>

0000000000042616 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42616:	55                   	push   %rbp
   42617:	48 89 e5             	mov    %rsp,%rbp
   4261a:	48 83 ec 60          	sub    $0x60,%rsp
   4261e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42622:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42626:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4262a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4262e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42632:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42636:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4263d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42641:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42645:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42649:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4264d:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42652:	0f 84 80 00 00 00    	je     426d8 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42658:	ba 0f 54 04 00       	mov    $0x4540f,%edx
   4265d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42662:	bf 30 07 00 00       	mov    $0x730,%edi
   42667:	b8 00 00 00 00       	mov    $0x0,%eax
   4266c:	e8 12 fe ff ff       	call   42483 <error_printf>
   42671:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42674:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42678:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4267c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4267f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42684:	89 c7                	mov    %eax,%edi
   42686:	e8 9a fd ff ff       	call   42425 <error_vprintf>
   4268b:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4268e:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42691:	48 63 c1             	movslq %ecx,%rax
   42694:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4269b:	48 c1 e8 20          	shr    $0x20,%rax
   4269f:	89 c2                	mov    %eax,%edx
   426a1:	c1 fa 05             	sar    $0x5,%edx
   426a4:	89 c8                	mov    %ecx,%eax
   426a6:	c1 f8 1f             	sar    $0x1f,%eax
   426a9:	29 c2                	sub    %eax,%edx
   426ab:	89 d0                	mov    %edx,%eax
   426ad:	c1 e0 02             	shl    $0x2,%eax
   426b0:	01 d0                	add    %edx,%eax
   426b2:	c1 e0 04             	shl    $0x4,%eax
   426b5:	29 c1                	sub    %eax,%ecx
   426b7:	89 ca                	mov    %ecx,%edx
   426b9:	85 d2                	test   %edx,%edx
   426bb:	74 34                	je     426f1 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   426bd:	8b 45 cc             	mov    -0x34(%rbp),%eax
   426c0:	ba 17 54 04 00       	mov    $0x45417,%edx
   426c5:	be 00 c0 00 00       	mov    $0xc000,%esi
   426ca:	89 c7                	mov    %eax,%edi
   426cc:	b8 00 00 00 00       	mov    $0x0,%eax
   426d1:	e8 ad fd ff ff       	call   42483 <error_printf>
   426d6:	eb 19                	jmp    426f1 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   426d8:	ba 19 54 04 00       	mov    $0x45419,%edx
   426dd:	be 00 c0 00 00       	mov    $0xc000,%esi
   426e2:	bf 30 07 00 00       	mov    $0x730,%edi
   426e7:	b8 00 00 00 00       	mov    $0x0,%eax
   426ec:	e8 92 fd ff ff       	call   42483 <error_printf>
    }

    va_end(val);
    fail();
   426f1:	e8 15 ff ff ff       	call   4260b <fail>

00000000000426f6 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   426f6:	55                   	push   %rbp
   426f7:	48 89 e5             	mov    %rsp,%rbp
   426fa:	48 83 ec 20          	sub    $0x20,%rsp
   426fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42702:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42705:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42709:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4270d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42710:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42714:	48 89 c6             	mov    %rax,%rsi
   42717:	bf 1f 54 04 00       	mov    $0x4541f,%edi
   4271c:	b8 00 00 00 00       	mov    $0x0,%eax
   42721:	e8 f0 fe ff ff       	call   42616 <kernel_panic>

0000000000042726 <default_exception>:
}

void default_exception(proc* p){
   42726:	55                   	push   %rbp
   42727:	48 89 e5             	mov    %rsp,%rbp
   4272a:	48 83 ec 20          	sub    $0x20,%rsp
   4272e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42732:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42736:	48 83 c0 18          	add    $0x18,%rax
   4273a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   4273e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42742:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42749:	48 89 c6             	mov    %rax,%rsi
   4274c:	bf 3d 54 04 00       	mov    $0x4543d,%edi
   42751:	b8 00 00 00 00       	mov    $0x0,%eax
   42756:	e8 bb fe ff ff       	call   42616 <kernel_panic>

000000000004275b <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4275b:	55                   	push   %rbp
   4275c:	48 89 e5             	mov    %rsp,%rbp
   4275f:	48 83 ec 10          	sub    $0x10,%rsp
   42763:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42767:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4276a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4276e:	78 06                	js     42776 <pageindex+0x1b>
   42770:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42774:	7e 14                	jle    4278a <pageindex+0x2f>
   42776:	ba 58 54 04 00       	mov    $0x45458,%edx
   4277b:	be 1e 00 00 00       	mov    $0x1e,%esi
   42780:	bf 71 54 04 00       	mov    $0x45471,%edi
   42785:	e8 6c ff ff ff       	call   426f6 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4278a:	b8 03 00 00 00       	mov    $0x3,%eax
   4278f:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42792:	89 c2                	mov    %eax,%edx
   42794:	89 d0                	mov    %edx,%eax
   42796:	c1 e0 03             	shl    $0x3,%eax
   42799:	01 d0                	add    %edx,%eax
   4279b:	83 c0 0c             	add    $0xc,%eax
   4279e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   427a2:	89 c1                	mov    %eax,%ecx
   427a4:	48 d3 ea             	shr    %cl,%rdx
   427a7:	48 89 d0             	mov    %rdx,%rax
   427aa:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   427af:	c9                   	leave  
   427b0:	c3                   	ret    

00000000000427b1 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   427b1:	55                   	push   %rbp
   427b2:	48 89 e5             	mov    %rsp,%rbp
   427b5:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   427b9:	48 c7 05 3c 08 01 00 	movq   $0x54000,0x1083c(%rip)        # 53000 <kernel_pagetable>
   427c0:	00 40 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   427c4:	ba 00 50 00 00       	mov    $0x5000,%edx
   427c9:	be 00 00 00 00       	mov    $0x0,%esi
   427ce:	bf 00 40 05 00       	mov    $0x54000,%edi
   427d3:	e8 9e 16 00 00       	call   43e76 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   427d8:	b8 00 50 05 00       	mov    $0x55000,%eax
   427dd:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   427e1:	48 89 05 18 18 01 00 	mov    %rax,0x11818(%rip)        # 54000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   427e8:	b8 00 60 05 00       	mov    $0x56000,%eax
   427ed:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   427f1:	48 89 05 08 28 01 00 	mov    %rax,0x12808(%rip)        # 55000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   427f8:	b8 00 70 05 00       	mov    $0x57000,%eax
   427fd:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42801:	48 89 05 f8 37 01 00 	mov    %rax,0x137f8(%rip)        # 56000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42808:	b8 00 80 05 00       	mov    $0x58000,%eax
   4280d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42811:	48 89 05 f0 37 01 00 	mov    %rax,0x137f0(%rip)        # 56008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42818:	48 8b 05 e1 07 01 00 	mov    0x107e1(%rip),%rax        # 53000 <kernel_pagetable>
   4281f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42825:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4282a:	ba 00 00 00 00       	mov    $0x0,%edx
   4282f:	be 00 00 00 00       	mov    $0x0,%esi
   42834:	48 89 c7             	mov    %rax,%rdi
   42837:	e8 b9 01 00 00       	call   429f5 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4283c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42843:	00 
   42844:	eb 62                	jmp    428a8 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42846:	48 8b 0d b3 07 01 00 	mov    0x107b3(%rip),%rcx        # 53000 <kernel_pagetable>
   4284d:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42851:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42855:	48 89 ce             	mov    %rcx,%rsi
   42858:	48 89 c7             	mov    %rax,%rdi
   4285b:	e8 58 05 00 00       	call   42db8 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42860:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42864:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42868:	74 14                	je     4287e <virtual_memory_init+0xcd>
   4286a:	ba 85 54 04 00       	mov    $0x45485,%edx
   4286f:	be 2d 00 00 00       	mov    $0x2d,%esi
   42874:	bf 95 54 04 00       	mov    $0x45495,%edi
   42879:	e8 78 fe ff ff       	call   426f6 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4287e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42881:	48 98                	cltq   
   42883:	83 e0 03             	and    $0x3,%eax
   42886:	48 83 f8 03          	cmp    $0x3,%rax
   4288a:	74 14                	je     428a0 <virtual_memory_init+0xef>
   4288c:	ba a8 54 04 00       	mov    $0x454a8,%edx
   42891:	be 2e 00 00 00       	mov    $0x2e,%esi
   42896:	bf 95 54 04 00       	mov    $0x45495,%edi
   4289b:	e8 56 fe ff ff       	call   426f6 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   428a0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   428a7:	00 
   428a8:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   428af:	00 
   428b0:	76 94                	jbe    42846 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   428b2:	48 8b 05 47 07 01 00 	mov    0x10747(%rip),%rax        # 53000 <kernel_pagetable>
   428b9:	48 89 c7             	mov    %rax,%rdi
   428bc:	e8 03 00 00 00       	call   428c4 <set_pagetable>
}
   428c1:	90                   	nop
   428c2:	c9                   	leave  
   428c3:	c3                   	ret    

00000000000428c4 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   428c4:	55                   	push   %rbp
   428c5:	48 89 e5             	mov    %rsp,%rbp
   428c8:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   428cc:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   428d0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428d4:	25 ff 0f 00 00       	and    $0xfff,%eax
   428d9:	48 85 c0             	test   %rax,%rax
   428dc:	74 14                	je     428f2 <set_pagetable+0x2e>
   428de:	ba d5 54 04 00       	mov    $0x454d5,%edx
   428e3:	be 3d 00 00 00       	mov    $0x3d,%esi
   428e8:	bf 95 54 04 00       	mov    $0x45495,%edi
   428ed:	e8 04 fe ff ff       	call   426f6 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   428f2:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   428f7:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   428fb:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428ff:	48 89 ce             	mov    %rcx,%rsi
   42902:	48 89 c7             	mov    %rax,%rdi
   42905:	e8 ae 04 00 00       	call   42db8 <virtual_memory_lookup>
   4290a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4290e:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42913:	48 39 d0             	cmp    %rdx,%rax
   42916:	74 14                	je     4292c <set_pagetable+0x68>
   42918:	ba f0 54 04 00       	mov    $0x454f0,%edx
   4291d:	be 3f 00 00 00       	mov    $0x3f,%esi
   42922:	bf 95 54 04 00       	mov    $0x45495,%edi
   42927:	e8 ca fd ff ff       	call   426f6 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4292c:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42930:	48 8b 0d c9 06 01 00 	mov    0x106c9(%rip),%rcx        # 53000 <kernel_pagetable>
   42937:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4293b:	48 89 ce             	mov    %rcx,%rsi
   4293e:	48 89 c7             	mov    %rax,%rdi
   42941:	e8 72 04 00 00       	call   42db8 <virtual_memory_lookup>
   42946:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4294a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4294e:	48 39 c2             	cmp    %rax,%rdx
   42951:	74 14                	je     42967 <set_pagetable+0xa3>
   42953:	ba 58 55 04 00       	mov    $0x45558,%edx
   42958:	be 41 00 00 00       	mov    $0x41,%esi
   4295d:	bf 95 54 04 00       	mov    $0x45495,%edi
   42962:	e8 8f fd ff ff       	call   426f6 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42967:	48 8b 05 92 06 01 00 	mov    0x10692(%rip),%rax        # 53000 <kernel_pagetable>
   4296e:	48 89 c2             	mov    %rax,%rdx
   42971:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42975:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42979:	48 89 ce             	mov    %rcx,%rsi
   4297c:	48 89 c7             	mov    %rax,%rdi
   4297f:	e8 34 04 00 00       	call   42db8 <virtual_memory_lookup>
   42984:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42988:	48 8b 15 71 06 01 00 	mov    0x10671(%rip),%rdx        # 53000 <kernel_pagetable>
   4298f:	48 39 d0             	cmp    %rdx,%rax
   42992:	74 14                	je     429a8 <set_pagetable+0xe4>
   42994:	ba b8 55 04 00       	mov    $0x455b8,%edx
   42999:	be 43 00 00 00       	mov    $0x43,%esi
   4299e:	bf 95 54 04 00       	mov    $0x45495,%edi
   429a3:	e8 4e fd ff ff       	call   426f6 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   429a8:	ba f5 29 04 00       	mov    $0x429f5,%edx
   429ad:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   429b1:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   429b5:	48 89 ce             	mov    %rcx,%rsi
   429b8:	48 89 c7             	mov    %rax,%rdi
   429bb:	e8 f8 03 00 00       	call   42db8 <virtual_memory_lookup>
   429c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429c4:	ba f5 29 04 00       	mov    $0x429f5,%edx
   429c9:	48 39 d0             	cmp    %rdx,%rax
   429cc:	74 14                	je     429e2 <set_pagetable+0x11e>
   429ce:	ba 20 56 04 00       	mov    $0x45620,%edx
   429d3:	be 45 00 00 00       	mov    $0x45,%esi
   429d8:	bf 95 54 04 00       	mov    $0x45495,%edi
   429dd:	e8 14 fd ff ff       	call   426f6 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   429e2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429ee:	0f 22 d8             	mov    %rax,%cr3
}
   429f1:	90                   	nop
}
   429f2:	90                   	nop
   429f3:	c9                   	leave  
   429f4:	c3                   	ret    

00000000000429f5 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   429f5:	55                   	push   %rbp
   429f6:	48 89 e5             	mov    %rsp,%rbp
   429f9:	53                   	push   %rbx
   429fa:	48 83 ec 58          	sub    $0x58,%rsp
   429fe:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42a02:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42a06:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42a0a:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42a0e:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42a12:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a16:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a1b:	48 85 c0             	test   %rax,%rax
   42a1e:	74 14                	je     42a34 <virtual_memory_map+0x3f>
   42a20:	ba 86 56 04 00       	mov    $0x45686,%edx
   42a25:	be 66 00 00 00       	mov    $0x66,%esi
   42a2a:	bf 95 54 04 00       	mov    $0x45495,%edi
   42a2f:	e8 c2 fc ff ff       	call   426f6 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a34:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a38:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a3d:	48 85 c0             	test   %rax,%rax
   42a40:	74 14                	je     42a56 <virtual_memory_map+0x61>
   42a42:	ba 99 56 04 00       	mov    $0x45699,%edx
   42a47:	be 67 00 00 00       	mov    $0x67,%esi
   42a4c:	bf 95 54 04 00       	mov    $0x45495,%edi
   42a51:	e8 a0 fc ff ff       	call   426f6 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42a56:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a5a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a5e:	48 01 d0             	add    %rdx,%rax
   42a61:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42a65:	73 24                	jae    42a8b <virtual_memory_map+0x96>
   42a67:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a6b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a6f:	48 01 d0             	add    %rdx,%rax
   42a72:	48 85 c0             	test   %rax,%rax
   42a75:	74 14                	je     42a8b <virtual_memory_map+0x96>
   42a77:	ba ac 56 04 00       	mov    $0x456ac,%edx
   42a7c:	be 68 00 00 00       	mov    $0x68,%esi
   42a81:	bf 95 54 04 00       	mov    $0x45495,%edi
   42a86:	e8 6b fc ff ff       	call   426f6 <assert_fail>
    if (perm & PTE_P) {
   42a8b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a8e:	48 98                	cltq   
   42a90:	83 e0 01             	and    $0x1,%eax
   42a93:	48 85 c0             	test   %rax,%rax
   42a96:	74 6e                	je     42b06 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42a98:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a9c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42aa1:	48 85 c0             	test   %rax,%rax
   42aa4:	74 14                	je     42aba <virtual_memory_map+0xc5>
   42aa6:	ba ca 56 04 00       	mov    $0x456ca,%edx
   42aab:	be 6a 00 00 00       	mov    $0x6a,%esi
   42ab0:	bf 95 54 04 00       	mov    $0x45495,%edi
   42ab5:	e8 3c fc ff ff       	call   426f6 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42aba:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42abe:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ac2:	48 01 d0             	add    %rdx,%rax
   42ac5:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42ac9:	73 14                	jae    42adf <virtual_memory_map+0xea>
   42acb:	ba dd 56 04 00       	mov    $0x456dd,%edx
   42ad0:	be 6b 00 00 00       	mov    $0x6b,%esi
   42ad5:	bf 95 54 04 00       	mov    $0x45495,%edi
   42ada:	e8 17 fc ff ff       	call   426f6 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42adf:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ae3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ae7:	48 01 d0             	add    %rdx,%rax
   42aea:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42af0:	76 14                	jbe    42b06 <virtual_memory_map+0x111>
   42af2:	ba eb 56 04 00       	mov    $0x456eb,%edx
   42af7:	be 6c 00 00 00       	mov    $0x6c,%esi
   42afc:	bf 95 54 04 00       	mov    $0x45495,%edi
   42b01:	e8 f0 fb ff ff       	call   426f6 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42b06:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42b0a:	78 09                	js     42b15 <virtual_memory_map+0x120>
   42b0c:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42b13:	7e 14                	jle    42b29 <virtual_memory_map+0x134>
   42b15:	ba 07 57 04 00       	mov    $0x45707,%edx
   42b1a:	be 6e 00 00 00       	mov    $0x6e,%esi
   42b1f:	bf 95 54 04 00       	mov    $0x45495,%edi
   42b24:	e8 cd fb ff ff       	call   426f6 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b29:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b2d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b32:	48 85 c0             	test   %rax,%rax
   42b35:	74 14                	je     42b4b <virtual_memory_map+0x156>
   42b37:	ba 28 57 04 00       	mov    $0x45728,%edx
   42b3c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42b41:	bf 95 54 04 00       	mov    $0x45495,%edi
   42b46:	e8 ab fb ff ff       	call   426f6 <assert_fail>

    int last_index123 = -1;
   42b4b:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42b52:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42b59:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b5a:	e9 e1 00 00 00       	jmp    42c40 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42b5f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b63:	48 c1 e8 15          	shr    $0x15,%rax
   42b67:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42b6a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b6d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42b70:	74 20                	je     42b92 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42b72:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42b75:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42b79:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b7d:	48 89 ce             	mov    %rcx,%rsi
   42b80:	48 89 c7             	mov    %rax,%rdi
   42b83:	e8 ce 00 00 00       	call   42c56 <lookup_l4pagetable>
   42b88:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42b8c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b8f:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42b92:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b95:	48 98                	cltq   
   42b97:	83 e0 01             	and    $0x1,%eax
   42b9a:	48 85 c0             	test   %rax,%rax
   42b9d:	74 34                	je     42bd3 <virtual_memory_map+0x1de>
   42b9f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ba4:	74 2d                	je     42bd3 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42ba6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ba9:	48 63 d8             	movslq %eax,%rbx
   42bac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bb0:	be 03 00 00 00       	mov    $0x3,%esi
   42bb5:	48 89 c7             	mov    %rax,%rdi
   42bb8:	e8 9e fb ff ff       	call   4275b <pageindex>
   42bbd:	89 c2                	mov    %eax,%edx
   42bbf:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42bc3:	48 89 d9             	mov    %rbx,%rcx
   42bc6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42bca:	48 63 d2             	movslq %edx,%rdx
   42bcd:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42bd1:	eb 55                	jmp    42c28 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42bd3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42bd8:	74 26                	je     42c00 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42bda:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bde:	be 03 00 00 00       	mov    $0x3,%esi
   42be3:	48 89 c7             	mov    %rax,%rdi
   42be6:	e8 70 fb ff ff       	call   4275b <pageindex>
   42beb:	89 c2                	mov    %eax,%edx
   42bed:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bf0:	48 63 c8             	movslq %eax,%rcx
   42bf3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42bf7:	48 63 d2             	movslq %edx,%rdx
   42bfa:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42bfe:	eb 28                	jmp    42c28 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42c00:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c03:	48 98                	cltq   
   42c05:	83 e0 01             	and    $0x1,%eax
   42c08:	48 85 c0             	test   %rax,%rax
   42c0b:	74 1b                	je     42c28 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c0d:	be 84 00 00 00       	mov    $0x84,%esi
   42c12:	bf 50 57 04 00       	mov    $0x45750,%edi
   42c17:	b8 00 00 00 00       	mov    $0x0,%eax
   42c1c:	e8 b7 f7 ff ff       	call   423d8 <log_printf>
            return -1;
   42c21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c26:	eb 28                	jmp    42c50 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c28:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42c2f:	00 
   42c30:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42c37:	00 
   42c38:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42c3f:	00 
   42c40:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42c45:	0f 85 14 ff ff ff    	jne    42b5f <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42c4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c50:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42c54:	c9                   	leave  
   42c55:	c3                   	ret    

0000000000042c56 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42c56:	55                   	push   %rbp
   42c57:	48 89 e5             	mov    %rsp,%rbp
   42c5a:	48 83 ec 40          	sub    $0x40,%rsp
   42c5e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c62:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c66:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c69:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c6d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42c71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42c78:	e9 2b 01 00 00       	jmp    42da8 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42c7d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42c80:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c84:	89 d6                	mov    %edx,%esi
   42c86:	48 89 c7             	mov    %rax,%rdi
   42c89:	e8 cd fa ff ff       	call   4275b <pageindex>
   42c8e:	89 c2                	mov    %eax,%edx
   42c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c94:	48 63 d2             	movslq %edx,%rdx
   42c97:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42c9b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42c9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ca3:	83 e0 01             	and    $0x1,%eax
   42ca6:	48 85 c0             	test   %rax,%rax
   42ca9:	75 63                	jne    42d0e <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42cab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42cae:	8d 48 02             	lea    0x2(%rax),%ecx
   42cb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cb5:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cba:	48 89 c2             	mov    %rax,%rdx
   42cbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cc1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cc7:	48 89 c6             	mov    %rax,%rsi
   42cca:	bf 98 57 04 00       	mov    $0x45798,%edi
   42ccf:	b8 00 00 00 00       	mov    $0x0,%eax
   42cd4:	e8 ff f6 ff ff       	call   423d8 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42cd9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42cdc:	48 98                	cltq   
   42cde:	83 e0 01             	and    $0x1,%eax
   42ce1:	48 85 c0             	test   %rax,%rax
   42ce4:	75 0a                	jne    42cf0 <lookup_l4pagetable+0x9a>
                return NULL;
   42ce6:	b8 00 00 00 00       	mov    $0x0,%eax
   42ceb:	e9 c6 00 00 00       	jmp    42db6 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42cf0:	be a7 00 00 00       	mov    $0xa7,%esi
   42cf5:	bf 00 58 04 00       	mov    $0x45800,%edi
   42cfa:	b8 00 00 00 00       	mov    $0x0,%eax
   42cff:	e8 d4 f6 ff ff       	call   423d8 <log_printf>
            return NULL;
   42d04:	b8 00 00 00 00       	mov    $0x0,%eax
   42d09:	e9 a8 00 00 00       	jmp    42db6 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42d0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d12:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d18:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d1e:	76 14                	jbe    42d34 <lookup_l4pagetable+0xde>
   42d20:	ba 48 58 04 00       	mov    $0x45848,%edx
   42d25:	be ac 00 00 00       	mov    $0xac,%esi
   42d2a:	bf 95 54 04 00       	mov    $0x45495,%edi
   42d2f:	e8 c2 f9 ff ff       	call   426f6 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42d34:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d37:	48 98                	cltq   
   42d39:	83 e0 02             	and    $0x2,%eax
   42d3c:	48 85 c0             	test   %rax,%rax
   42d3f:	74 20                	je     42d61 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42d41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d45:	83 e0 02             	and    $0x2,%eax
   42d48:	48 85 c0             	test   %rax,%rax
   42d4b:	75 14                	jne    42d61 <lookup_l4pagetable+0x10b>
   42d4d:	ba 68 58 04 00       	mov    $0x45868,%edx
   42d52:	be ae 00 00 00       	mov    $0xae,%esi
   42d57:	bf 95 54 04 00       	mov    $0x45495,%edi
   42d5c:	e8 95 f9 ff ff       	call   426f6 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42d61:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d64:	48 98                	cltq   
   42d66:	83 e0 04             	and    $0x4,%eax
   42d69:	48 85 c0             	test   %rax,%rax
   42d6c:	74 20                	je     42d8e <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42d6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d72:	83 e0 04             	and    $0x4,%eax
   42d75:	48 85 c0             	test   %rax,%rax
   42d78:	75 14                	jne    42d8e <lookup_l4pagetable+0x138>
   42d7a:	ba 73 58 04 00       	mov    $0x45873,%edx
   42d7f:	be b1 00 00 00       	mov    $0xb1,%esi
   42d84:	bf 95 54 04 00       	mov    $0x45495,%edi
   42d89:	e8 68 f9 ff ff       	call   426f6 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42d8e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42d95:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42d96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d9a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42da0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42da4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42da8:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42dac:	0f 8e cb fe ff ff    	jle    42c7d <lookup_l4pagetable+0x27>
    }
    return pt;
   42db2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42db6:	c9                   	leave  
   42db7:	c3                   	ret    

0000000000042db8 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42db8:	55                   	push   %rbp
   42db9:	48 89 e5             	mov    %rsp,%rbp
   42dbc:	48 83 ec 50          	sub    $0x50,%rsp
   42dc0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42dc4:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42dc8:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42dcc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42dd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42dd4:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42ddb:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42ddc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42de3:	eb 41                	jmp    42e26 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42de5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42de8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42dec:	89 d6                	mov    %edx,%esi
   42dee:	48 89 c7             	mov    %rax,%rdi
   42df1:	e8 65 f9 ff ff       	call   4275b <pageindex>
   42df6:	89 c2                	mov    %eax,%edx
   42df8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dfc:	48 63 d2             	movslq %edx,%rdx
   42dff:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42e03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e07:	83 e0 06             	and    $0x6,%eax
   42e0a:	48 f7 d0             	not    %rax
   42e0d:	48 21 d0             	and    %rdx,%rax
   42e10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e18:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e22:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e26:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42e2a:	7f 0c                	jg     42e38 <virtual_memory_lookup+0x80>
   42e2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e30:	83 e0 01             	and    $0x1,%eax
   42e33:	48 85 c0             	test   %rax,%rax
   42e36:	75 ad                	jne    42de5 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42e38:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42e3f:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42e46:	ff 
   42e47:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42e4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e52:	83 e0 01             	and    $0x1,%eax
   42e55:	48 85 c0             	test   %rax,%rax
   42e58:	74 34                	je     42e8e <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42e5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5e:	48 c1 e8 0c          	shr    $0xc,%rax
   42e62:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42e65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e69:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e6f:	48 89 c2             	mov    %rax,%rdx
   42e72:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e76:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e7b:	48 09 d0             	or     %rdx,%rax
   42e7e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42e82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e86:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e8b:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42e8e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e92:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42e96:	48 89 10             	mov    %rdx,(%rax)
   42e99:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42e9d:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42ea1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42ea5:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42ea9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ead:	c9                   	leave  
   42eae:	c3                   	ret    

0000000000042eaf <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42eaf:	55                   	push   %rbp
   42eb0:	48 89 e5             	mov    %rsp,%rbp
   42eb3:	48 83 ec 40          	sub    $0x40,%rsp
   42eb7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ebb:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42ebe:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42ec2:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42ec9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42ecd:	78 08                	js     42ed7 <program_load+0x28>
   42ecf:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42ed2:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42ed5:	7c 14                	jl     42eeb <program_load+0x3c>
   42ed7:	ba 80 58 04 00       	mov    $0x45880,%edx
   42edc:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ee1:	bf b0 58 04 00       	mov    $0x458b0,%edi
   42ee6:	e8 0b f8 ff ff       	call   426f6 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42eeb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42eee:	48 98                	cltq   
   42ef0:	48 c1 e0 04          	shl    $0x4,%rax
   42ef4:	48 05 20 60 04 00    	add    $0x46020,%rax
   42efa:	48 8b 00             	mov    (%rax),%rax
   42efd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42f01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f05:	8b 00                	mov    (%rax),%eax
   42f07:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42f0c:	74 14                	je     42f22 <program_load+0x73>
   42f0e:	ba c2 58 04 00       	mov    $0x458c2,%edx
   42f13:	be 30 00 00 00       	mov    $0x30,%esi
   42f18:	bf b0 58 04 00       	mov    $0x458b0,%edi
   42f1d:	e8 d4 f7 ff ff       	call   426f6 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42f22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f26:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f2e:	48 01 d0             	add    %rdx,%rax
   42f31:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42f3c:	e9 94 00 00 00       	jmp    42fd5 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42f41:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f44:	48 63 d0             	movslq %eax,%rdx
   42f47:	48 89 d0             	mov    %rdx,%rax
   42f4a:	48 c1 e0 03          	shl    $0x3,%rax
   42f4e:	48 29 d0             	sub    %rdx,%rax
   42f51:	48 c1 e0 03          	shl    $0x3,%rax
   42f55:	48 89 c2             	mov    %rax,%rdx
   42f58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f5c:	48 01 d0             	add    %rdx,%rax
   42f5f:	8b 00                	mov    (%rax),%eax
   42f61:	83 f8 01             	cmp    $0x1,%eax
   42f64:	75 6b                	jne    42fd1 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42f66:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f69:	48 63 d0             	movslq %eax,%rdx
   42f6c:	48 89 d0             	mov    %rdx,%rax
   42f6f:	48 c1 e0 03          	shl    $0x3,%rax
   42f73:	48 29 d0             	sub    %rdx,%rax
   42f76:	48 c1 e0 03          	shl    $0x3,%rax
   42f7a:	48 89 c2             	mov    %rax,%rdx
   42f7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f81:	48 01 d0             	add    %rdx,%rax
   42f84:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42f88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f8c:	48 01 d0             	add    %rdx,%rax
   42f8f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42f93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f96:	48 63 d0             	movslq %eax,%rdx
   42f99:	48 89 d0             	mov    %rdx,%rax
   42f9c:	48 c1 e0 03          	shl    $0x3,%rax
   42fa0:	48 29 d0             	sub    %rdx,%rax
   42fa3:	48 c1 e0 03          	shl    $0x3,%rax
   42fa7:	48 89 c2             	mov    %rax,%rdx
   42faa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fae:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42fb2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42fb6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42fba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fbe:	48 89 c7             	mov    %rax,%rdi
   42fc1:	e8 3d 00 00 00       	call   43003 <program_load_segment>
   42fc6:	85 c0                	test   %eax,%eax
   42fc8:	79 07                	jns    42fd1 <program_load+0x122>
                return -1;
   42fca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42fcf:	eb 30                	jmp    43001 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42fd1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42fd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fd9:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42fdd:	0f b7 c0             	movzwl %ax,%eax
   42fe0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42fe3:	0f 8c 58 ff ff ff    	jl     42f41 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42fe9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fed:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42ff1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ff5:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42ffc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43001:	c9                   	leave  
   43002:	c3                   	ret    

0000000000043003 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43003:	55                   	push   %rbp
   43004:	48 89 e5             	mov    %rsp,%rbp
   43007:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   4300e:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   43012:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   43016:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   4301d:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43024:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43028:	48 8b 40 10          	mov    0x10(%rax),%rax
   4302c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43030:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43034:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43038:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4303c:	48 01 d0             	add    %rdx,%rax
   4303f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43043:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43047:	48 8b 50 28          	mov    0x28(%rax),%rdx
   4304b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4304f:	48 01 d0             	add    %rdx,%rax
   43052:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43056:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4305d:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4305e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43062:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43066:	eb 7c                	jmp    430e4 <program_load_segment+0xe1>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   43068:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4306c:	8b 00                	mov    (%rax),%eax
   4306e:	89 c7                	mov    %eax,%edi
   43070:	e8 cf 01 00 00       	call   43244 <palloc>
   43075:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   43079:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4307e:	74 2a                	je     430aa <program_load_segment+0xa7>
   43080:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43084:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4308b:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   4308f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43093:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43099:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4309e:	48 89 c7             	mov    %rax,%rdi
   430a1:	e8 4f f9 ff ff       	call   429f5 <virtual_memory_map>
   430a6:	85 c0                	test   %eax,%eax
   430a8:	79 32                	jns    430dc <program_load_segment+0xd9>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   430aa:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430ae:	8b 00                	mov    (%rax),%eax
   430b0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   430b4:	49 89 d0             	mov    %rdx,%r8
   430b7:	89 c1                	mov    %eax,%ecx
   430b9:	ba e0 58 04 00       	mov    $0x458e0,%edx
   430be:	be 00 c0 00 00       	mov    $0xc000,%esi
   430c3:	bf e0 06 00 00       	mov    $0x6e0,%edi
   430c8:	b8 00 00 00 00       	mov    $0x0,%eax
   430cd:	e8 5b 1b 00 00       	call   44c2d <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   430d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   430d7:	e9 66 01 00 00       	jmp    43242 <program_load_segment+0x23f>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430dc:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430e3:	00 
   430e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430e8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   430ec:	0f 82 76 ff ff ff    	jb     43068 <program_load_segment+0x65>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   430f2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430f6:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   430fd:	48 89 c7             	mov    %rax,%rdi
   43100:	e8 bf f7 ff ff       	call   428c4 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43105:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43109:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4310d:	48 89 c2             	mov    %rax,%rdx
   43110:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43114:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   4311b:	48 89 ce             	mov    %rcx,%rsi
   4311e:	48 89 c7             	mov    %rax,%rdi
   43121:	e8 52 0c 00 00       	call   43d78 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43126:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4312a:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4312e:	48 89 c2             	mov    %rax,%rdx
   43131:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43135:	be 00 00 00 00       	mov    $0x0,%esi
   4313a:	48 89 c7             	mov    %rax,%rdi
   4313d:	e8 34 0d 00 00       	call   43e76 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43142:	48 8b 05 b7 fe 00 00 	mov    0xfeb7(%rip),%rax        # 53000 <kernel_pagetable>
   43149:	48 89 c7             	mov    %rax,%rdi
   4314c:	e8 73 f7 ff ff       	call   428c4 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43151:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43155:	8b 40 04             	mov    0x4(%rax),%eax
   43158:	83 e0 02             	and    $0x2,%eax
   4315b:	85 c0                	test   %eax,%eax
   4315d:	75 60                	jne    431bf <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4315f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43163:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43167:	eb 4c                	jmp    431b5 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43169:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4316d:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43174:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43178:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4317c:	48 89 ce             	mov    %rcx,%rsi
   4317f:	48 89 c7             	mov    %rax,%rdi
   43182:	e8 31 fc ff ff       	call   42db8 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43187:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4318b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4318f:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43196:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4319a:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   431a0:	b9 00 10 00 00       	mov    $0x1000,%ecx
   431a5:	48 89 c7             	mov    %rax,%rdi
   431a8:	e8 48 f8 ff ff       	call   429f5 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431ad:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   431b4:	00 
   431b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431b9:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   431bd:	72 aa                	jb     43169 <program_load_segment+0x166>
        }
    }
    // TODO : Add code here
    // Calculate the break's starting postion
    // Starting point of empty heap should be next page following the code and data segments 
    p->original_break = ROUNDUP(end_file + PAGESIZE, PAGESIZE);
   431bf:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   431c6:	00 
   431c7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431cb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431cf:	48 01 d0             	add    %rdx,%rax
   431d2:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   431d8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   431dc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431e0:	ba 00 00 00 00       	mov    $0x0,%edx
   431e5:	48 f7 75 d0          	divq   -0x30(%rbp)
   431e9:	48 89 d1             	mov    %rdx,%rcx
   431ec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431f0:	48 29 c8             	sub    %rcx,%rax
   431f3:	48 89 c2             	mov    %rax,%rdx
   431f6:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   431fa:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = ROUNDUP(end_file + PAGESIZE, PAGESIZE);
   431fe:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   43205:	00 
   43206:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4320a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4320e:	48 01 d0             	add    %rdx,%rax
   43211:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   43217:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4321b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4321f:	ba 00 00 00 00       	mov    $0x0,%edx
   43224:	48 f7 75 c0          	divq   -0x40(%rbp)
   43228:	48 89 d1             	mov    %rdx,%rcx
   4322b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4322f:	48 29 c8             	sub    %rcx,%rax
   43232:	48 89 c2             	mov    %rax,%rdx
   43235:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43239:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return 0;
   4323d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43242:	c9                   	leave  
   43243:	c3                   	ret    

0000000000043244 <palloc>:
   43244:	55                   	push   %rbp
   43245:	48 89 e5             	mov    %rsp,%rbp
   43248:	48 83 ec 20          	sub    $0x20,%rsp
   4324c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4324f:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43256:	00 
   43257:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4325b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4325f:	e9 95 00 00 00       	jmp    432f9 <palloc+0xb5>
   43264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43268:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4326c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43273:	00 
   43274:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43278:	48 c1 e8 0c          	shr    $0xc,%rax
   4327c:	48 98                	cltq   
   4327e:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   43285:	00 
   43286:	84 c0                	test   %al,%al
   43288:	75 6f                	jne    432f9 <palloc+0xb5>
   4328a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4328e:	48 c1 e8 0c          	shr    $0xc,%rax
   43292:	48 98                	cltq   
   43294:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   4329b:	00 
   4329c:	84 c0                	test   %al,%al
   4329e:	75 59                	jne    432f9 <palloc+0xb5>
   432a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a4:	48 c1 e8 0c          	shr    $0xc,%rax
   432a8:	89 c2                	mov    %eax,%edx
   432aa:	48 63 c2             	movslq %edx,%rax
   432ad:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   432b4:	00 
   432b5:	83 c0 01             	add    $0x1,%eax
   432b8:	89 c1                	mov    %eax,%ecx
   432ba:	48 63 c2             	movslq %edx,%rax
   432bd:	88 8c 00 21 0f 05 00 	mov    %cl,0x50f21(%rax,%rax,1)
   432c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432c8:	48 c1 e8 0c          	shr    $0xc,%rax
   432cc:	89 c1                	mov    %eax,%ecx
   432ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
   432d1:	89 c2                	mov    %eax,%edx
   432d3:	48 63 c1             	movslq %ecx,%rax
   432d6:	88 94 00 20 0f 05 00 	mov    %dl,0x50f20(%rax,%rax,1)
   432dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432e1:	ba 00 10 00 00       	mov    $0x1000,%edx
   432e6:	be cc 00 00 00       	mov    $0xcc,%esi
   432eb:	48 89 c7             	mov    %rax,%rdi
   432ee:	e8 83 0b 00 00       	call   43e76 <memset>
   432f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432f7:	eb 2c                	jmp    43325 <palloc+0xe1>
   432f9:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43300:	00 
   43301:	0f 86 5d ff ff ff    	jbe    43264 <palloc+0x20>
   43307:	ba 18 59 04 00       	mov    $0x45918,%edx
   4330c:	be 00 0c 00 00       	mov    $0xc00,%esi
   43311:	bf 80 07 00 00       	mov    $0x780,%edi
   43316:	b8 00 00 00 00       	mov    $0x0,%eax
   4331b:	e8 0d 19 00 00       	call   44c2d <console_printf>
   43320:	b8 00 00 00 00       	mov    $0x0,%eax
   43325:	c9                   	leave  
   43326:	c3                   	ret    

0000000000043327 <palloc_target>:
   43327:	55                   	push   %rbp
   43328:	48 89 e5             	mov    %rsp,%rbp
   4332b:	48 8b 05 ce 5c 01 00 	mov    0x15cce(%rip),%rax        # 59000 <palloc_target_proc>
   43332:	48 85 c0             	test   %rax,%rax
   43335:	75 14                	jne    4334b <palloc_target+0x24>
   43337:	ba 31 59 04 00       	mov    $0x45931,%edx
   4333c:	be 27 00 00 00       	mov    $0x27,%esi
   43341:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   43346:	e8 ab f3 ff ff       	call   426f6 <assert_fail>
   4334b:	48 8b 05 ae 5c 01 00 	mov    0x15cae(%rip),%rax        # 59000 <palloc_target_proc>
   43352:	8b 00                	mov    (%rax),%eax
   43354:	89 c7                	mov    %eax,%edi
   43356:	e8 e9 fe ff ff       	call   43244 <palloc>
   4335b:	5d                   	pop    %rbp
   4335c:	c3                   	ret    

000000000004335d <process_free>:
   4335d:	55                   	push   %rbp
   4335e:	48 89 e5             	mov    %rsp,%rbp
   43361:	48 83 ec 60          	sub    $0x60,%rsp
   43365:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43368:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4336b:	48 63 d0             	movslq %eax,%rdx
   4336e:	48 89 d0             	mov    %rdx,%rax
   43371:	48 c1 e0 04          	shl    $0x4,%rax
   43375:	48 29 d0             	sub    %rdx,%rax
   43378:	48 c1 e0 04          	shl    $0x4,%rax
   4337c:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   43382:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43388:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4338f:	00 
   43390:	e9 ad 00 00 00       	jmp    43442 <process_free+0xe5>
   43395:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43398:	48 63 d0             	movslq %eax,%rdx
   4339b:	48 89 d0             	mov    %rdx,%rax
   4339e:	48 c1 e0 04          	shl    $0x4,%rax
   433a2:	48 29 d0             	sub    %rdx,%rax
   433a5:	48 c1 e0 04          	shl    $0x4,%rax
   433a9:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   433af:	48 8b 08             	mov    (%rax),%rcx
   433b2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   433b6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433ba:	48 89 ce             	mov    %rcx,%rsi
   433bd:	48 89 c7             	mov    %rax,%rdi
   433c0:	e8 f3 f9 ff ff       	call   42db8 <virtual_memory_lookup>
   433c5:	8b 45 c8             	mov    -0x38(%rbp),%eax
   433c8:	48 98                	cltq   
   433ca:	83 e0 01             	and    $0x1,%eax
   433cd:	48 85 c0             	test   %rax,%rax
   433d0:	74 68                	je     4343a <process_free+0xdd>
   433d2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   433d5:	48 63 d0             	movslq %eax,%rdx
   433d8:	0f b6 94 12 21 0f 05 	movzbl 0x50f21(%rdx,%rdx,1),%edx
   433df:	00 
   433e0:	83 ea 01             	sub    $0x1,%edx
   433e3:	48 98                	cltq   
   433e5:	88 94 00 21 0f 05 00 	mov    %dl,0x50f21(%rax,%rax,1)
   433ec:	8b 45 b8             	mov    -0x48(%rbp),%eax
   433ef:	48 98                	cltq   
   433f1:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   433f8:	00 
   433f9:	84 c0                	test   %al,%al
   433fb:	75 0f                	jne    4340c <process_free+0xaf>
   433fd:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43400:	48 98                	cltq   
   43402:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43409:	00 
   4340a:	eb 2e                	jmp    4343a <process_free+0xdd>
   4340c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4340f:	48 98                	cltq   
   43411:	0f b6 84 00 20 0f 05 	movzbl 0x50f20(%rax,%rax,1),%eax
   43418:	00 
   43419:	0f be c0             	movsbl %al,%eax
   4341c:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   4341f:	75 19                	jne    4343a <process_free+0xdd>
   43421:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43425:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43428:	48 89 c6             	mov    %rax,%rsi
   4342b:	bf 58 59 04 00       	mov    $0x45958,%edi
   43430:	b8 00 00 00 00       	mov    $0x0,%eax
   43435:	e8 9e ef ff ff       	call   423d8 <log_printf>
   4343a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43441:	00 
   43442:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43449:	00 
   4344a:	0f 86 45 ff ff ff    	jbe    43395 <process_free+0x38>
   43450:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43453:	48 63 d0             	movslq %eax,%rdx
   43456:	48 89 d0             	mov    %rdx,%rax
   43459:	48 c1 e0 04          	shl    $0x4,%rax
   4345d:	48 29 d0             	sub    %rdx,%rax
   43460:	48 c1 e0 04          	shl    $0x4,%rax
   43464:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   4346a:	48 8b 00             	mov    (%rax),%rax
   4346d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43471:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43475:	48 8b 00             	mov    (%rax),%rax
   43478:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4347e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43482:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43486:	48 8b 00             	mov    (%rax),%rax
   43489:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4348f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43493:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43497:	48 8b 00             	mov    (%rax),%rax
   4349a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434a8:	48 8b 40 08          	mov    0x8(%rax),%rax
   434ac:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   434b2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   434b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ba:	48 c1 e8 0c          	shr    $0xc,%rax
   434be:	48 98                	cltq   
   434c0:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   434c7:	00 
   434c8:	3c 01                	cmp    $0x1,%al
   434ca:	74 14                	je     434e0 <process_free+0x183>
   434cc:	ba 90 59 04 00       	mov    $0x45990,%edx
   434d1:	be 4f 00 00 00       	mov    $0x4f,%esi
   434d6:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   434db:	e8 16 f2 ff ff       	call   426f6 <assert_fail>
   434e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434e4:	48 c1 e8 0c          	shr    $0xc,%rax
   434e8:	48 98                	cltq   
   434ea:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   434f1:	00 
   434f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434f6:	48 c1 e8 0c          	shr    $0xc,%rax
   434fa:	48 98                	cltq   
   434fc:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43503:	00 
   43504:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43508:	48 c1 e8 0c          	shr    $0xc,%rax
   4350c:	48 98                	cltq   
   4350e:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   43515:	00 
   43516:	3c 01                	cmp    $0x1,%al
   43518:	74 14                	je     4352e <process_free+0x1d1>
   4351a:	ba b8 59 04 00       	mov    $0x459b8,%edx
   4351f:	be 52 00 00 00       	mov    $0x52,%esi
   43524:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   43529:	e8 c8 f1 ff ff       	call   426f6 <assert_fail>
   4352e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43532:	48 c1 e8 0c          	shr    $0xc,%rax
   43536:	48 98                	cltq   
   43538:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   4353f:	00 
   43540:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43544:	48 c1 e8 0c          	shr    $0xc,%rax
   43548:	48 98                	cltq   
   4354a:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43551:	00 
   43552:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43556:	48 c1 e8 0c          	shr    $0xc,%rax
   4355a:	48 98                	cltq   
   4355c:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   43563:	00 
   43564:	3c 01                	cmp    $0x1,%al
   43566:	74 14                	je     4357c <process_free+0x21f>
   43568:	ba e0 59 04 00       	mov    $0x459e0,%edx
   4356d:	be 55 00 00 00       	mov    $0x55,%esi
   43572:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   43577:	e8 7a f1 ff ff       	call   426f6 <assert_fail>
   4357c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43580:	48 c1 e8 0c          	shr    $0xc,%rax
   43584:	48 98                	cltq   
   43586:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   4358d:	00 
   4358e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43592:	48 c1 e8 0c          	shr    $0xc,%rax
   43596:	48 98                	cltq   
   43598:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   4359f:	00 
   435a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435a4:	48 c1 e8 0c          	shr    $0xc,%rax
   435a8:	48 98                	cltq   
   435aa:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   435b1:	00 
   435b2:	3c 01                	cmp    $0x1,%al
   435b4:	74 14                	je     435ca <process_free+0x26d>
   435b6:	ba 08 5a 04 00       	mov    $0x45a08,%edx
   435bb:	be 58 00 00 00       	mov    $0x58,%esi
   435c0:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   435c5:	e8 2c f1 ff ff       	call   426f6 <assert_fail>
   435ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435ce:	48 c1 e8 0c          	shr    $0xc,%rax
   435d2:	48 98                	cltq   
   435d4:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   435db:	00 
   435dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435e0:	48 c1 e8 0c          	shr    $0xc,%rax
   435e4:	48 98                	cltq   
   435e6:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   435ed:	00 
   435ee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   435f2:	48 c1 e8 0c          	shr    $0xc,%rax
   435f6:	48 98                	cltq   
   435f8:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   435ff:	00 
   43600:	3c 01                	cmp    $0x1,%al
   43602:	74 14                	je     43618 <process_free+0x2bb>
   43604:	ba 30 5a 04 00       	mov    $0x45a30,%edx
   43609:	be 5b 00 00 00       	mov    $0x5b,%esi
   4360e:	bf 4c 59 04 00       	mov    $0x4594c,%edi
   43613:	e8 de f0 ff ff       	call   426f6 <assert_fail>
   43618:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4361c:	48 c1 e8 0c          	shr    $0xc,%rax
   43620:	48 98                	cltq   
   43622:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   43629:	00 
   4362a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4362e:	48 c1 e8 0c          	shr    $0xc,%rax
   43632:	48 98                	cltq   
   43634:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   4363b:	00 
   4363c:	90                   	nop
   4363d:	c9                   	leave  
   4363e:	c3                   	ret    

000000000004363f <process_config_tables>:
   4363f:	55                   	push   %rbp
   43640:	48 89 e5             	mov    %rsp,%rbp
   43643:	48 83 ec 40          	sub    $0x40,%rsp
   43647:	89 7d cc             	mov    %edi,-0x34(%rbp)
   4364a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4364d:	89 c7                	mov    %eax,%edi
   4364f:	e8 f0 fb ff ff       	call   43244 <palloc>
   43654:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43658:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4365b:	89 c7                	mov    %eax,%edi
   4365d:	e8 e2 fb ff ff       	call   43244 <palloc>
   43662:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43666:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43669:	89 c7                	mov    %eax,%edi
   4366b:	e8 d4 fb ff ff       	call   43244 <palloc>
   43670:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43674:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43677:	89 c7                	mov    %eax,%edi
   43679:	e8 c6 fb ff ff       	call   43244 <palloc>
   4367e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43682:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43685:	89 c7                	mov    %eax,%edi
   43687:	e8 b8 fb ff ff       	call   43244 <palloc>
   4368c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43690:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43695:	74 20                	je     436b7 <process_config_tables+0x78>
   43697:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4369c:	74 19                	je     436b7 <process_config_tables+0x78>
   4369e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   436a3:	74 12                	je     436b7 <process_config_tables+0x78>
   436a5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   436aa:	74 0b                	je     436b7 <process_config_tables+0x78>
   436ac:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   436b1:	0f 85 e1 00 00 00    	jne    43798 <process_config_tables+0x159>
   436b7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   436bc:	74 24                	je     436e2 <process_config_tables+0xa3>
   436be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436c2:	48 c1 e8 0c          	shr    $0xc,%rax
   436c6:	48 98                	cltq   
   436c8:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   436cf:	00 
   436d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d4:	48 c1 e8 0c          	shr    $0xc,%rax
   436d8:	48 98                	cltq   
   436da:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   436e1:	00 
   436e2:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   436e7:	74 24                	je     4370d <process_config_tables+0xce>
   436e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ed:	48 c1 e8 0c          	shr    $0xc,%rax
   436f1:	48 98                	cltq   
   436f3:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   436fa:	00 
   436fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436ff:	48 c1 e8 0c          	shr    $0xc,%rax
   43703:	48 98                	cltq   
   43705:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   4370c:	00 
   4370d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43712:	74 24                	je     43738 <process_config_tables+0xf9>
   43714:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43718:	48 c1 e8 0c          	shr    $0xc,%rax
   4371c:	48 98                	cltq   
   4371e:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43725:	00 
   43726:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4372a:	48 c1 e8 0c          	shr    $0xc,%rax
   4372e:	48 98                	cltq   
   43730:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   43737:	00 
   43738:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4373d:	74 24                	je     43763 <process_config_tables+0x124>
   4373f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43743:	48 c1 e8 0c          	shr    $0xc,%rax
   43747:	48 98                	cltq   
   43749:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43750:	00 
   43751:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43755:	48 c1 e8 0c          	shr    $0xc,%rax
   43759:	48 98                	cltq   
   4375b:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   43762:	00 
   43763:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43768:	74 24                	je     4378e <process_config_tables+0x14f>
   4376a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4376e:	48 c1 e8 0c          	shr    $0xc,%rax
   43772:	48 98                	cltq   
   43774:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   4377b:	00 
   4377c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43780:	48 c1 e8 0c          	shr    $0xc,%rax
   43784:	48 98                	cltq   
   43786:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   4378d:	00 
   4378e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43793:	e9 f3 01 00 00       	jmp    4398b <process_config_tables+0x34c>
   43798:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379c:	ba 00 10 00 00       	mov    $0x1000,%edx
   437a1:	be 00 00 00 00       	mov    $0x0,%esi
   437a6:	48 89 c7             	mov    %rax,%rdi
   437a9:	e8 c8 06 00 00       	call   43e76 <memset>
   437ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437b2:	ba 00 10 00 00       	mov    $0x1000,%edx
   437b7:	be 00 00 00 00       	mov    $0x0,%esi
   437bc:	48 89 c7             	mov    %rax,%rdi
   437bf:	e8 b2 06 00 00       	call   43e76 <memset>
   437c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c8:	ba 00 10 00 00       	mov    $0x1000,%edx
   437cd:	be 00 00 00 00       	mov    $0x0,%esi
   437d2:	48 89 c7             	mov    %rax,%rdi
   437d5:	e8 9c 06 00 00       	call   43e76 <memset>
   437da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437de:	ba 00 10 00 00       	mov    $0x1000,%edx
   437e3:	be 00 00 00 00       	mov    $0x0,%esi
   437e8:	48 89 c7             	mov    %rax,%rdi
   437eb:	e8 86 06 00 00       	call   43e76 <memset>
   437f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437f4:	ba 00 10 00 00       	mov    $0x1000,%edx
   437f9:	be 00 00 00 00       	mov    $0x0,%esi
   437fe:	48 89 c7             	mov    %rax,%rdi
   43801:	e8 70 06 00 00       	call   43e76 <memset>
   43806:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4380a:	48 83 c8 07          	or     $0x7,%rax
   4380e:	48 89 c2             	mov    %rax,%rdx
   43811:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43815:	48 89 10             	mov    %rdx,(%rax)
   43818:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4381c:	48 83 c8 07          	or     $0x7,%rax
   43820:	48 89 c2             	mov    %rax,%rdx
   43823:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43827:	48 89 10             	mov    %rdx,(%rax)
   4382a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4382e:	48 83 c8 07          	or     $0x7,%rax
   43832:	48 89 c2             	mov    %rax,%rdx
   43835:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43839:	48 89 10             	mov    %rdx,(%rax)
   4383c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43840:	48 83 c8 07          	or     $0x7,%rax
   43844:	48 89 c2             	mov    %rax,%rdx
   43847:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4384b:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4384f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43853:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43859:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4385f:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43864:	ba 00 00 00 00       	mov    $0x0,%edx
   43869:	be 00 00 00 00       	mov    $0x0,%esi
   4386e:	48 89 c7             	mov    %rax,%rdi
   43871:	e8 7f f1 ff ff       	call   429f5 <virtual_memory_map>
   43876:	85 c0                	test   %eax,%eax
   43878:	75 2f                	jne    438a9 <process_config_tables+0x26a>
   4387a:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   4387f:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43884:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43888:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4388e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43894:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43899:	48 89 c7             	mov    %rax,%rdi
   4389c:	e8 54 f1 ff ff       	call   429f5 <virtual_memory_map>
   438a1:	85 c0                	test   %eax,%eax
   438a3:	0f 84 bb 00 00 00    	je     43964 <process_config_tables+0x325>
   438a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438ad:	48 c1 e8 0c          	shr    $0xc,%rax
   438b1:	48 98                	cltq   
   438b3:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   438ba:	00 
   438bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438bf:	48 c1 e8 0c          	shr    $0xc,%rax
   438c3:	48 98                	cltq   
   438c5:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   438cc:	00 
   438cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438d1:	48 c1 e8 0c          	shr    $0xc,%rax
   438d5:	48 98                	cltq   
   438d7:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   438de:	00 
   438df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438e3:	48 c1 e8 0c          	shr    $0xc,%rax
   438e7:	48 98                	cltq   
   438e9:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   438f0:	00 
   438f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438f5:	48 c1 e8 0c          	shr    $0xc,%rax
   438f9:	48 98                	cltq   
   438fb:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43902:	00 
   43903:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43907:	48 c1 e8 0c          	shr    $0xc,%rax
   4390b:	48 98                	cltq   
   4390d:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   43914:	00 
   43915:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43919:	48 c1 e8 0c          	shr    $0xc,%rax
   4391d:	48 98                	cltq   
   4391f:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   43926:	00 
   43927:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4392b:	48 c1 e8 0c          	shr    $0xc,%rax
   4392f:	48 98                	cltq   
   43931:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   43938:	00 
   43939:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4393d:	48 c1 e8 0c          	shr    $0xc,%rax
   43941:	48 98                	cltq   
   43943:	c6 84 00 20 0f 05 00 	movb   $0x0,0x50f20(%rax,%rax,1)
   4394a:	00 
   4394b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4394f:	48 c1 e8 0c          	shr    $0xc,%rax
   43953:	48 98                	cltq   
   43955:	c6 84 00 21 0f 05 00 	movb   $0x0,0x50f21(%rax,%rax,1)
   4395c:	00 
   4395d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43962:	eb 27                	jmp    4398b <process_config_tables+0x34c>
   43964:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43967:	48 63 d0             	movslq %eax,%rdx
   4396a:	48 89 d0             	mov    %rdx,%rax
   4396d:	48 c1 e0 04          	shl    $0x4,%rax
   43971:	48 29 d0             	sub    %rdx,%rax
   43974:	48 c1 e0 04          	shl    $0x4,%rax
   43978:	48 8d 90 e0 00 05 00 	lea    0x500e0(%rax),%rdx
   4397f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43983:	48 89 02             	mov    %rax,(%rdx)
   43986:	b8 00 00 00 00       	mov    $0x0,%eax
   4398b:	c9                   	leave  
   4398c:	c3                   	ret    

000000000004398d <process_load>:
   4398d:	55                   	push   %rbp
   4398e:	48 89 e5             	mov    %rsp,%rbp
   43991:	48 83 ec 20          	sub    $0x20,%rsp
   43995:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43999:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4399c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439a0:	48 89 05 59 56 01 00 	mov    %rax,0x15659(%rip)        # 59000 <palloc_target_proc>
   439a7:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   439aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439ae:	ba 27 33 04 00       	mov    $0x43327,%edx
   439b3:	89 ce                	mov    %ecx,%esi
   439b5:	48 89 c7             	mov    %rax,%rdi
   439b8:	e8 f2 f4 ff ff       	call   42eaf <program_load>
   439bd:	89 45 fc             	mov    %eax,-0x4(%rbp)
   439c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   439c3:	c9                   	leave  
   439c4:	c3                   	ret    

00000000000439c5 <process_setup_stack>:
   439c5:	55                   	push   %rbp
   439c6:	48 89 e5             	mov    %rsp,%rbp
   439c9:	48 83 ec 20          	sub    $0x20,%rsp
   439cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439d5:	8b 00                	mov    (%rax),%eax
   439d7:	89 c7                	mov    %eax,%edi
   439d9:	e8 66 f8 ff ff       	call   43244 <palloc>
   439de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   439e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439e6:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   439ed:	00 00 30 00 
   439f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439f5:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   439fc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43a00:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a06:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a0c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a11:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43a16:	48 89 c7             	mov    %rax,%rdi
   43a19:	e8 d7 ef ff ff       	call   429f5 <virtual_memory_map>
   43a1e:	90                   	nop
   43a1f:	c9                   	leave  
   43a20:	c3                   	ret    

0000000000043a21 <find_free_pid>:
   43a21:	55                   	push   %rbp
   43a22:	48 89 e5             	mov    %rsp,%rbp
   43a25:	48 83 ec 10          	sub    $0x10,%rsp
   43a29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43a30:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43a37:	eb 24                	jmp    43a5d <find_free_pid+0x3c>
   43a39:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43a3c:	48 63 d0             	movslq %eax,%rdx
   43a3f:	48 89 d0             	mov    %rdx,%rax
   43a42:	48 c1 e0 04          	shl    $0x4,%rax
   43a46:	48 29 d0             	sub    %rdx,%rax
   43a49:	48 c1 e0 04          	shl    $0x4,%rax
   43a4d:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   43a53:	8b 00                	mov    (%rax),%eax
   43a55:	85 c0                	test   %eax,%eax
   43a57:	74 0c                	je     43a65 <find_free_pid+0x44>
   43a59:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43a5d:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43a61:	7e d6                	jle    43a39 <find_free_pid+0x18>
   43a63:	eb 01                	jmp    43a66 <find_free_pid+0x45>
   43a65:	90                   	nop
   43a66:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43a6a:	74 05                	je     43a71 <find_free_pid+0x50>
   43a6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43a6f:	eb 05                	jmp    43a76 <find_free_pid+0x55>
   43a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a76:	c9                   	leave  
   43a77:	c3                   	ret    

0000000000043a78 <process_fork>:
   43a78:	55                   	push   %rbp
   43a79:	48 89 e5             	mov    %rsp,%rbp
   43a7c:	48 83 ec 40          	sub    $0x40,%rsp
   43a80:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43a84:	b8 00 00 00 00       	mov    $0x0,%eax
   43a89:	e8 93 ff ff ff       	call   43a21 <find_free_pid>
   43a8e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43a91:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43a95:	75 0a                	jne    43aa1 <process_fork+0x29>
   43a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a9c:	e9 67 02 00 00       	jmp    43d08 <process_fork+0x290>
   43aa1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43aa4:	48 63 d0             	movslq %eax,%rdx
   43aa7:	48 89 d0             	mov    %rdx,%rax
   43aaa:	48 c1 e0 04          	shl    $0x4,%rax
   43aae:	48 29 d0             	sub    %rdx,%rax
   43ab1:	48 c1 e0 04          	shl    $0x4,%rax
   43ab5:	48 05 00 00 05 00    	add    $0x50000,%rax
   43abb:	be 00 00 00 00       	mov    $0x0,%esi
   43ac0:	48 89 c7             	mov    %rax,%rdi
   43ac3:	e8 60 e4 ff ff       	call   41f28 <process_init>
   43ac8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43acb:	89 c7                	mov    %eax,%edi
   43acd:	e8 6d fb ff ff       	call   4363f <process_config_tables>
   43ad2:	83 f8 ff             	cmp    $0xffffffff,%eax
   43ad5:	75 0a                	jne    43ae1 <process_fork+0x69>
   43ad7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43adc:	e9 27 02 00 00       	jmp    43d08 <process_fork+0x290>
   43ae1:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43ae8:	00 
   43ae9:	e9 79 01 00 00       	jmp    43c67 <process_fork+0x1ef>
   43aee:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43af2:	8b 00                	mov    (%rax),%eax
   43af4:	48 63 d0             	movslq %eax,%rdx
   43af7:	48 89 d0             	mov    %rdx,%rax
   43afa:	48 c1 e0 04          	shl    $0x4,%rax
   43afe:	48 29 d0             	sub    %rdx,%rax
   43b01:	48 c1 e0 04          	shl    $0x4,%rax
   43b05:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   43b0b:	48 8b 08             	mov    (%rax),%rcx
   43b0e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43b12:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b16:	48 89 ce             	mov    %rcx,%rsi
   43b19:	48 89 c7             	mov    %rax,%rdi
   43b1c:	e8 97 f2 ff ff       	call   42db8 <virtual_memory_lookup>
   43b21:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43b24:	48 98                	cltq   
   43b26:	83 e0 07             	and    $0x7,%eax
   43b29:	48 83 f8 07          	cmp    $0x7,%rax
   43b2d:	0f 85 a1 00 00 00    	jne    43bd4 <process_fork+0x15c>
   43b33:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b36:	89 c7                	mov    %eax,%edi
   43b38:	e8 07 f7 ff ff       	call   43244 <palloc>
   43b3d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43b41:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43b46:	75 14                	jne    43b5c <process_fork+0xe4>
   43b48:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b4b:	89 c7                	mov    %eax,%edi
   43b4d:	e8 0b f8 ff ff       	call   4335d <process_free>
   43b52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b57:	e9 ac 01 00 00       	jmp    43d08 <process_fork+0x290>
   43b5c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b60:	48 89 c1             	mov    %rax,%rcx
   43b63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b67:	ba 00 10 00 00       	mov    $0x1000,%edx
   43b6c:	48 89 ce             	mov    %rcx,%rsi
   43b6f:	48 89 c7             	mov    %rax,%rdi
   43b72:	e8 01 02 00 00       	call   43d78 <memcpy>
   43b77:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43b7b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b7e:	48 63 d0             	movslq %eax,%rdx
   43b81:	48 89 d0             	mov    %rdx,%rax
   43b84:	48 c1 e0 04          	shl    $0x4,%rax
   43b88:	48 29 d0             	sub    %rdx,%rax
   43b8b:	48 c1 e0 04          	shl    $0x4,%rax
   43b8f:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   43b95:	48 8b 00             	mov    (%rax),%rax
   43b98:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43b9c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ba2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43ba8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43bad:	48 89 fa             	mov    %rdi,%rdx
   43bb0:	48 89 c7             	mov    %rax,%rdi
   43bb3:	e8 3d ee ff ff       	call   429f5 <virtual_memory_map>
   43bb8:	85 c0                	test   %eax,%eax
   43bba:	0f 84 9f 00 00 00    	je     43c5f <process_fork+0x1e7>
   43bc0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bc3:	89 c7                	mov    %eax,%edi
   43bc5:	e8 93 f7 ff ff       	call   4335d <process_free>
   43bca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43bcf:	e9 34 01 00 00       	jmp    43d08 <process_fork+0x290>
   43bd4:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43bd7:	48 98                	cltq   
   43bd9:	83 e0 05             	and    $0x5,%eax
   43bdc:	48 83 f8 05          	cmp    $0x5,%rax
   43be0:	75 7d                	jne    43c5f <process_fork+0x1e7>
   43be2:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43be6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43be9:	48 63 d0             	movslq %eax,%rdx
   43bec:	48 89 d0             	mov    %rdx,%rax
   43bef:	48 c1 e0 04          	shl    $0x4,%rax
   43bf3:	48 29 d0             	sub    %rdx,%rax
   43bf6:	48 c1 e0 04          	shl    $0x4,%rax
   43bfa:	48 05 e0 00 05 00    	add    $0x500e0,%rax
   43c00:	48 8b 00             	mov    (%rax),%rax
   43c03:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43c07:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43c0d:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43c13:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43c18:	48 89 fa             	mov    %rdi,%rdx
   43c1b:	48 89 c7             	mov    %rax,%rdi
   43c1e:	e8 d2 ed ff ff       	call   429f5 <virtual_memory_map>
   43c23:	85 c0                	test   %eax,%eax
   43c25:	74 14                	je     43c3b <process_fork+0x1c3>
   43c27:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43c2a:	89 c7                	mov    %eax,%edi
   43c2c:	e8 2c f7 ff ff       	call   4335d <process_free>
   43c31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c36:	e9 cd 00 00 00       	jmp    43d08 <process_fork+0x290>
   43c3b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c3f:	48 c1 e8 0c          	shr    $0xc,%rax
   43c43:	89 c2                	mov    %eax,%edx
   43c45:	48 63 c2             	movslq %edx,%rax
   43c48:	0f b6 84 00 21 0f 05 	movzbl 0x50f21(%rax,%rax,1),%eax
   43c4f:	00 
   43c50:	83 c0 01             	add    $0x1,%eax
   43c53:	89 c1                	mov    %eax,%ecx
   43c55:	48 63 c2             	movslq %edx,%rax
   43c58:	88 8c 00 21 0f 05 00 	mov    %cl,0x50f21(%rax,%rax,1)
   43c5f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43c66:	00 
   43c67:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43c6e:	00 
   43c6f:	0f 86 79 fe ff ff    	jbe    43aee <process_fork+0x76>
   43c75:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43c79:	8b 08                	mov    (%rax),%ecx
   43c7b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43c7e:	48 63 d0             	movslq %eax,%rdx
   43c81:	48 89 d0             	mov    %rdx,%rax
   43c84:	48 c1 e0 04          	shl    $0x4,%rax
   43c88:	48 29 d0             	sub    %rdx,%rax
   43c8b:	48 c1 e0 04          	shl    $0x4,%rax
   43c8f:	48 8d b0 10 00 05 00 	lea    0x50010(%rax),%rsi
   43c96:	48 63 d1             	movslq %ecx,%rdx
   43c99:	48 89 d0             	mov    %rdx,%rax
   43c9c:	48 c1 e0 04          	shl    $0x4,%rax
   43ca0:	48 29 d0             	sub    %rdx,%rax
   43ca3:	48 c1 e0 04          	shl    $0x4,%rax
   43ca7:	48 8d 90 10 00 05 00 	lea    0x50010(%rax),%rdx
   43cae:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43cb2:	48 83 c2 08          	add    $0x8,%rdx
   43cb6:	b9 18 00 00 00       	mov    $0x18,%ecx
   43cbb:	48 89 c7             	mov    %rax,%rdi
   43cbe:	48 89 d6             	mov    %rdx,%rsi
   43cc1:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43cc4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43cc7:	48 63 d0             	movslq %eax,%rdx
   43cca:	48 89 d0             	mov    %rdx,%rax
   43ccd:	48 c1 e0 04          	shl    $0x4,%rax
   43cd1:	48 29 d0             	sub    %rdx,%rax
   43cd4:	48 c1 e0 04          	shl    $0x4,%rax
   43cd8:	48 05 18 00 05 00    	add    $0x50018,%rax
   43cde:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43ce5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ce8:	48 63 d0             	movslq %eax,%rdx
   43ceb:	48 89 d0             	mov    %rdx,%rax
   43cee:	48 c1 e0 04          	shl    $0x4,%rax
   43cf2:	48 29 d0             	sub    %rdx,%rax
   43cf5:	48 c1 e0 04          	shl    $0x4,%rax
   43cf9:	48 05 d8 00 05 00    	add    $0x500d8,%rax
   43cff:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43d05:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43d08:	c9                   	leave  
   43d09:	c3                   	ret    

0000000000043d0a <process_page_alloc>:
   43d0a:	55                   	push   %rbp
   43d0b:	48 89 e5             	mov    %rsp,%rbp
   43d0e:	48 83 ec 20          	sub    $0x20,%rsp
   43d12:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d16:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d1a:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43d21:	00 
   43d22:	77 07                	ja     43d2b <process_page_alloc+0x21>
   43d24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d29:	eb 4b                	jmp    43d76 <process_page_alloc+0x6c>
   43d2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d2f:	8b 00                	mov    (%rax),%eax
   43d31:	89 c7                	mov    %eax,%edi
   43d33:	e8 0c f5 ff ff       	call   43244 <palloc>
   43d38:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d3c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43d41:	74 2e                	je     43d71 <process_page_alloc+0x67>
   43d43:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d4b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43d52:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43d56:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43d5c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43d62:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43d67:	48 89 c7             	mov    %rax,%rdi
   43d6a:	e8 86 ec ff ff       	call   429f5 <virtual_memory_map>
   43d6f:	eb 05                	jmp    43d76 <process_page_alloc+0x6c>
   43d71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43d76:	c9                   	leave  
   43d77:	c3                   	ret    

0000000000043d78 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43d78:	55                   	push   %rbp
   43d79:	48 89 e5             	mov    %rsp,%rbp
   43d7c:	48 83 ec 28          	sub    $0x28,%rsp
   43d80:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d84:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43d88:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43d8c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43d94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43d9c:	eb 1c                	jmp    43dba <memcpy+0x42>
        *d = *s;
   43d9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43da2:	0f b6 10             	movzbl (%rax),%edx
   43da5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43da9:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43dab:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43db0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43db5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43dba:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43dbf:	75 dd                	jne    43d9e <memcpy+0x26>
    }
    return dst;
   43dc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43dc5:	c9                   	leave  
   43dc6:	c3                   	ret    

0000000000043dc7 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43dc7:	55                   	push   %rbp
   43dc8:	48 89 e5             	mov    %rsp,%rbp
   43dcb:	48 83 ec 28          	sub    $0x28,%rsp
   43dcf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dd3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43dd7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43ddb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ddf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43de3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43de7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43def:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43df3:	73 6a                	jae    43e5f <memmove+0x98>
   43df5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43df9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43dfd:	48 01 d0             	add    %rdx,%rax
   43e00:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43e04:	73 59                	jae    43e5f <memmove+0x98>
        s += n, d += n;
   43e06:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e0a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43e0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e12:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43e16:	eb 17                	jmp    43e2f <memmove+0x68>
            *--d = *--s;
   43e18:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43e1d:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43e22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e26:	0f b6 10             	movzbl (%rax),%edx
   43e29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e2d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43e2f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e33:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43e37:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43e3b:	48 85 c0             	test   %rax,%rax
   43e3e:	75 d8                	jne    43e18 <memmove+0x51>
    if (s < d && s + n > d) {
   43e40:	eb 2e                	jmp    43e70 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43e42:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e46:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43e4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43e4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e52:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e56:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43e5a:	0f b6 12             	movzbl (%rdx),%edx
   43e5d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43e5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e63:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43e67:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43e6b:	48 85 c0             	test   %rax,%rax
   43e6e:	75 d2                	jne    43e42 <memmove+0x7b>
        }
    }
    return dst;
   43e70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e74:	c9                   	leave  
   43e75:	c3                   	ret    

0000000000043e76 <memset>:

void* memset(void* v, int c, size_t n) {
   43e76:	55                   	push   %rbp
   43e77:	48 89 e5             	mov    %rsp,%rbp
   43e7a:	48 83 ec 28          	sub    $0x28,%rsp
   43e7e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e82:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43e85:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43e89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43e91:	eb 15                	jmp    43ea8 <memset+0x32>
        *p = c;
   43e93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e96:	89 c2                	mov    %eax,%edx
   43e98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e9c:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43e9e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43ea3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43ea8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43ead:	75 e4                	jne    43e93 <memset+0x1d>
    }
    return v;
   43eaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43eb3:	c9                   	leave  
   43eb4:	c3                   	ret    

0000000000043eb5 <strlen>:

size_t strlen(const char* s) {
   43eb5:	55                   	push   %rbp
   43eb6:	48 89 e5             	mov    %rsp,%rbp
   43eb9:	48 83 ec 18          	sub    $0x18,%rsp
   43ebd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43ec1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43ec8:	00 
   43ec9:	eb 0a                	jmp    43ed5 <strlen+0x20>
        ++n;
   43ecb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43ed0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43ed5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ed9:	0f b6 00             	movzbl (%rax),%eax
   43edc:	84 c0                	test   %al,%al
   43ede:	75 eb                	jne    43ecb <strlen+0x16>
    }
    return n;
   43ee0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43ee4:	c9                   	leave  
   43ee5:	c3                   	ret    

0000000000043ee6 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43ee6:	55                   	push   %rbp
   43ee7:	48 89 e5             	mov    %rsp,%rbp
   43eea:	48 83 ec 20          	sub    $0x20,%rsp
   43eee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ef2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43ef6:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43efd:	00 
   43efe:	eb 0a                	jmp    43f0a <strnlen+0x24>
        ++n;
   43f00:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43f05:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f0e:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43f12:	74 0b                	je     43f1f <strnlen+0x39>
   43f14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f18:	0f b6 00             	movzbl (%rax),%eax
   43f1b:	84 c0                	test   %al,%al
   43f1d:	75 e1                	jne    43f00 <strnlen+0x1a>
    }
    return n;
   43f1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43f23:	c9                   	leave  
   43f24:	c3                   	ret    

0000000000043f25 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43f25:	55                   	push   %rbp
   43f26:	48 89 e5             	mov    %rsp,%rbp
   43f29:	48 83 ec 20          	sub    $0x20,%rsp
   43f2d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f31:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43f35:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43f3d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43f41:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43f45:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f4d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43f51:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43f55:	0f b6 12             	movzbl (%rdx),%edx
   43f58:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43f5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f5e:	48 83 e8 01          	sub    $0x1,%rax
   43f62:	0f b6 00             	movzbl (%rax),%eax
   43f65:	84 c0                	test   %al,%al
   43f67:	75 d4                	jne    43f3d <strcpy+0x18>
    return dst;
   43f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f6d:	c9                   	leave  
   43f6e:	c3                   	ret    

0000000000043f6f <strcmp>:

int strcmp(const char* a, const char* b) {
   43f6f:	55                   	push   %rbp
   43f70:	48 89 e5             	mov    %rsp,%rbp
   43f73:	48 83 ec 10          	sub    $0x10,%rsp
   43f77:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43f7b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43f7f:	eb 0a                	jmp    43f8b <strcmp+0x1c>
        ++a, ++b;
   43f81:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43f86:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43f8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f8f:	0f b6 00             	movzbl (%rax),%eax
   43f92:	84 c0                	test   %al,%al
   43f94:	74 1d                	je     43fb3 <strcmp+0x44>
   43f96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f9a:	0f b6 00             	movzbl (%rax),%eax
   43f9d:	84 c0                	test   %al,%al
   43f9f:	74 12                	je     43fb3 <strcmp+0x44>
   43fa1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fa5:	0f b6 10             	movzbl (%rax),%edx
   43fa8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fac:	0f b6 00             	movzbl (%rax),%eax
   43faf:	38 c2                	cmp    %al,%dl
   43fb1:	74 ce                	je     43f81 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fb7:	0f b6 00             	movzbl (%rax),%eax
   43fba:	89 c2                	mov    %eax,%edx
   43fbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fc0:	0f b6 00             	movzbl (%rax),%eax
   43fc3:	38 d0                	cmp    %dl,%al
   43fc5:	0f 92 c0             	setb   %al
   43fc8:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43fcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fcf:	0f b6 00             	movzbl (%rax),%eax
   43fd2:	89 c1                	mov    %eax,%ecx
   43fd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fd8:	0f b6 00             	movzbl (%rax),%eax
   43fdb:	38 c1                	cmp    %al,%cl
   43fdd:	0f 92 c0             	setb   %al
   43fe0:	0f b6 c0             	movzbl %al,%eax
   43fe3:	29 c2                	sub    %eax,%edx
   43fe5:	89 d0                	mov    %edx,%eax
}
   43fe7:	c9                   	leave  
   43fe8:	c3                   	ret    

0000000000043fe9 <strchr>:

char* strchr(const char* s, int c) {
   43fe9:	55                   	push   %rbp
   43fea:	48 89 e5             	mov    %rsp,%rbp
   43fed:	48 83 ec 10          	sub    $0x10,%rsp
   43ff1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ff5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43ff8:	eb 05                	jmp    43fff <strchr+0x16>
        ++s;
   43ffa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43fff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44003:	0f b6 00             	movzbl (%rax),%eax
   44006:	84 c0                	test   %al,%al
   44008:	74 0e                	je     44018 <strchr+0x2f>
   4400a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4400e:	0f b6 00             	movzbl (%rax),%eax
   44011:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44014:	38 d0                	cmp    %dl,%al
   44016:	75 e2                	jne    43ffa <strchr+0x11>
    }
    if (*s == (char) c) {
   44018:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4401c:	0f b6 00             	movzbl (%rax),%eax
   4401f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   44022:	38 d0                	cmp    %dl,%al
   44024:	75 06                	jne    4402c <strchr+0x43>
        return (char*) s;
   44026:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4402a:	eb 05                	jmp    44031 <strchr+0x48>
    } else {
        return NULL;
   4402c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   44031:	c9                   	leave  
   44032:	c3                   	ret    

0000000000044033 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   44033:	55                   	push   %rbp
   44034:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   44037:	8b 05 cb 4f 01 00    	mov    0x14fcb(%rip),%eax        # 59008 <rand_seed_set>
   4403d:	85 c0                	test   %eax,%eax
   4403f:	75 0a                	jne    4404b <rand+0x18>
        srand(819234718U);
   44041:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   44046:	e8 24 00 00 00       	call   4406f <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4404b:	8b 05 bb 4f 01 00    	mov    0x14fbb(%rip),%eax        # 5900c <rand_seed>
   44051:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   44057:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4405c:	89 05 aa 4f 01 00    	mov    %eax,0x14faa(%rip)        # 5900c <rand_seed>
    return rand_seed & RAND_MAX;
   44062:	8b 05 a4 4f 01 00    	mov    0x14fa4(%rip),%eax        # 5900c <rand_seed>
   44068:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4406d:	5d                   	pop    %rbp
   4406e:	c3                   	ret    

000000000004406f <srand>:

void srand(unsigned seed) {
   4406f:	55                   	push   %rbp
   44070:	48 89 e5             	mov    %rsp,%rbp
   44073:	48 83 ec 08          	sub    $0x8,%rsp
   44077:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   4407a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4407d:	89 05 89 4f 01 00    	mov    %eax,0x14f89(%rip)        # 5900c <rand_seed>
    rand_seed_set = 1;
   44083:	c7 05 7b 4f 01 00 01 	movl   $0x1,0x14f7b(%rip)        # 59008 <rand_seed_set>
   4408a:	00 00 00 
}
   4408d:	90                   	nop
   4408e:	c9                   	leave  
   4408f:	c3                   	ret    

0000000000044090 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   44090:	55                   	push   %rbp
   44091:	48 89 e5             	mov    %rsp,%rbp
   44094:	48 83 ec 28          	sub    $0x28,%rsp
   44098:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4409c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   440a0:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   440a3:	48 c7 45 f8 40 5c 04 	movq   $0x45c40,-0x8(%rbp)
   440aa:	00 
    if (base < 0) {
   440ab:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   440af:	79 0b                	jns    440bc <fill_numbuf+0x2c>
        digits = lower_digits;
   440b1:	48 c7 45 f8 60 5c 04 	movq   $0x45c60,-0x8(%rbp)
   440b8:	00 
        base = -base;
   440b9:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   440bc:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   440c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440c5:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   440c8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   440cb:	48 63 c8             	movslq %eax,%rcx
   440ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440d2:	ba 00 00 00 00       	mov    $0x0,%edx
   440d7:	48 f7 f1             	div    %rcx
   440da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440de:	48 01 d0             	add    %rdx,%rax
   440e1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   440e6:	0f b6 10             	movzbl (%rax),%edx
   440e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   440ed:	88 10                	mov    %dl,(%rax)
        val /= base;
   440ef:	8b 45 dc             	mov    -0x24(%rbp),%eax
   440f2:	48 63 f0             	movslq %eax,%rsi
   440f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440f9:	ba 00 00 00 00       	mov    $0x0,%edx
   440fe:	48 f7 f6             	div    %rsi
   44101:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   44105:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4410a:	75 bc                	jne    440c8 <fill_numbuf+0x38>
    return numbuf_end;
   4410c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   44110:	c9                   	leave  
   44111:	c3                   	ret    

0000000000044112 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   44112:	55                   	push   %rbp
   44113:	48 89 e5             	mov    %rsp,%rbp
   44116:	53                   	push   %rbx
   44117:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4411e:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   44125:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4412b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44132:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   44139:	e9 8a 09 00 00       	jmp    44ac8 <printer_vprintf+0x9b6>
        if (*format != '%') {
   4413e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44145:	0f b6 00             	movzbl (%rax),%eax
   44148:	3c 25                	cmp    $0x25,%al
   4414a:	74 31                	je     4417d <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   4414c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44153:	4c 8b 00             	mov    (%rax),%r8
   44156:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4415d:	0f b6 00             	movzbl (%rax),%eax
   44160:	0f b6 c8             	movzbl %al,%ecx
   44163:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44169:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44170:	89 ce                	mov    %ecx,%esi
   44172:	48 89 c7             	mov    %rax,%rdi
   44175:	41 ff d0             	call   *%r8
            continue;
   44178:	e9 43 09 00 00       	jmp    44ac0 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   4417d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   44184:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4418b:	01 
   4418c:	eb 44                	jmp    441d2 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   4418e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44195:	0f b6 00             	movzbl (%rax),%eax
   44198:	0f be c0             	movsbl %al,%eax
   4419b:	89 c6                	mov    %eax,%esi
   4419d:	bf 60 5a 04 00       	mov    $0x45a60,%edi
   441a2:	e8 42 fe ff ff       	call   43fe9 <strchr>
   441a7:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   441ab:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   441b0:	74 30                	je     441e2 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   441b2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   441b6:	48 2d 60 5a 04 00    	sub    $0x45a60,%rax
   441bc:	ba 01 00 00 00       	mov    $0x1,%edx
   441c1:	89 c1                	mov    %eax,%ecx
   441c3:	d3 e2                	shl    %cl,%edx
   441c5:	89 d0                	mov    %edx,%eax
   441c7:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   441ca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441d1:	01 
   441d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441d9:	0f b6 00             	movzbl (%rax),%eax
   441dc:	84 c0                	test   %al,%al
   441de:	75 ae                	jne    4418e <printer_vprintf+0x7c>
   441e0:	eb 01                	jmp    441e3 <printer_vprintf+0xd1>
            } else {
                break;
   441e2:	90                   	nop
            }
        }

        // process width
        int width = -1;
   441e3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   441ea:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441f1:	0f b6 00             	movzbl (%rax),%eax
   441f4:	3c 30                	cmp    $0x30,%al
   441f6:	7e 67                	jle    4425f <printer_vprintf+0x14d>
   441f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ff:	0f b6 00             	movzbl (%rax),%eax
   44202:	3c 39                	cmp    $0x39,%al
   44204:	7f 59                	jg     4425f <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44206:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4420d:	eb 2e                	jmp    4423d <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   4420f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44212:	89 d0                	mov    %edx,%eax
   44214:	c1 e0 02             	shl    $0x2,%eax
   44217:	01 d0                	add    %edx,%eax
   44219:	01 c0                	add    %eax,%eax
   4421b:	89 c1                	mov    %eax,%ecx
   4421d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44224:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44228:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4422f:	0f b6 00             	movzbl (%rax),%eax
   44232:	0f be c0             	movsbl %al,%eax
   44235:	01 c8                	add    %ecx,%eax
   44237:	83 e8 30             	sub    $0x30,%eax
   4423a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4423d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44244:	0f b6 00             	movzbl (%rax),%eax
   44247:	3c 2f                	cmp    $0x2f,%al
   44249:	0f 8e 85 00 00 00    	jle    442d4 <printer_vprintf+0x1c2>
   4424f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44256:	0f b6 00             	movzbl (%rax),%eax
   44259:	3c 39                	cmp    $0x39,%al
   4425b:	7e b2                	jle    4420f <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4425d:	eb 75                	jmp    442d4 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4425f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44266:	0f b6 00             	movzbl (%rax),%eax
   44269:	3c 2a                	cmp    $0x2a,%al
   4426b:	75 68                	jne    442d5 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4426d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44274:	8b 00                	mov    (%rax),%eax
   44276:	83 f8 2f             	cmp    $0x2f,%eax
   44279:	77 30                	ja     442ab <printer_vprintf+0x199>
   4427b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44282:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44286:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4428d:	8b 00                	mov    (%rax),%eax
   4428f:	89 c0                	mov    %eax,%eax
   44291:	48 01 d0             	add    %rdx,%rax
   44294:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4429b:	8b 12                	mov    (%rdx),%edx
   4429d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a7:	89 0a                	mov    %ecx,(%rdx)
   442a9:	eb 1a                	jmp    442c5 <printer_vprintf+0x1b3>
   442ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b2:	48 8b 40 08          	mov    0x8(%rax),%rax
   442b6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442c5:	8b 00                	mov    (%rax),%eax
   442c7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   442ca:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442d1:	01 
   442d2:	eb 01                	jmp    442d5 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   442d4:	90                   	nop
        }

        // process precision
        int precision = -1;
   442d5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   442dc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442e3:	0f b6 00             	movzbl (%rax),%eax
   442e6:	3c 2e                	cmp    $0x2e,%al
   442e8:	0f 85 00 01 00 00    	jne    443ee <printer_vprintf+0x2dc>
            ++format;
   442ee:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442f5:	01 
            if (*format >= '0' && *format <= '9') {
   442f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442fd:	0f b6 00             	movzbl (%rax),%eax
   44300:	3c 2f                	cmp    $0x2f,%al
   44302:	7e 67                	jle    4436b <printer_vprintf+0x259>
   44304:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4430b:	0f b6 00             	movzbl (%rax),%eax
   4430e:	3c 39                	cmp    $0x39,%al
   44310:	7f 59                	jg     4436b <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44312:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44319:	eb 2e                	jmp    44349 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   4431b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4431e:	89 d0                	mov    %edx,%eax
   44320:	c1 e0 02             	shl    $0x2,%eax
   44323:	01 d0                	add    %edx,%eax
   44325:	01 c0                	add    %eax,%eax
   44327:	89 c1                	mov    %eax,%ecx
   44329:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44330:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44334:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4433b:	0f b6 00             	movzbl (%rax),%eax
   4433e:	0f be c0             	movsbl %al,%eax
   44341:	01 c8                	add    %ecx,%eax
   44343:	83 e8 30             	sub    $0x30,%eax
   44346:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44349:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44350:	0f b6 00             	movzbl (%rax),%eax
   44353:	3c 2f                	cmp    $0x2f,%al
   44355:	0f 8e 85 00 00 00    	jle    443e0 <printer_vprintf+0x2ce>
   4435b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44362:	0f b6 00             	movzbl (%rax),%eax
   44365:	3c 39                	cmp    $0x39,%al
   44367:	7e b2                	jle    4431b <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   44369:	eb 75                	jmp    443e0 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4436b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44372:	0f b6 00             	movzbl (%rax),%eax
   44375:	3c 2a                	cmp    $0x2a,%al
   44377:	75 68                	jne    443e1 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   44379:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44380:	8b 00                	mov    (%rax),%eax
   44382:	83 f8 2f             	cmp    $0x2f,%eax
   44385:	77 30                	ja     443b7 <printer_vprintf+0x2a5>
   44387:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4438e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44392:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44399:	8b 00                	mov    (%rax),%eax
   4439b:	89 c0                	mov    %eax,%eax
   4439d:	48 01 d0             	add    %rdx,%rax
   443a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443a7:	8b 12                	mov    (%rdx),%edx
   443a9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443b3:	89 0a                	mov    %ecx,(%rdx)
   443b5:	eb 1a                	jmp    443d1 <printer_vprintf+0x2bf>
   443b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443be:	48 8b 40 08          	mov    0x8(%rax),%rax
   443c2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443cd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443d1:	8b 00                	mov    (%rax),%eax
   443d3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   443d6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   443dd:	01 
   443de:	eb 01                	jmp    443e1 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   443e0:	90                   	nop
            }
            if (precision < 0) {
   443e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   443e5:	79 07                	jns    443ee <printer_vprintf+0x2dc>
                precision = 0;
   443e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   443ee:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   443f5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   443fc:	00 
        int length = 0;
   443fd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44404:	48 c7 45 c8 66 5a 04 	movq   $0x45a66,-0x38(%rbp)
   4440b:	00 
    again:
        switch (*format) {
   4440c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44413:	0f b6 00             	movzbl (%rax),%eax
   44416:	0f be c0             	movsbl %al,%eax
   44419:	83 e8 43             	sub    $0x43,%eax
   4441c:	83 f8 37             	cmp    $0x37,%eax
   4441f:	0f 87 9f 03 00 00    	ja     447c4 <printer_vprintf+0x6b2>
   44425:	89 c0                	mov    %eax,%eax
   44427:	48 8b 04 c5 78 5a 04 	mov    0x45a78(,%rax,8),%rax
   4442e:	00 
   4442f:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   44431:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44438:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4443f:	01 
            goto again;
   44440:	eb ca                	jmp    4440c <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44442:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44446:	74 5d                	je     444a5 <printer_vprintf+0x393>
   44448:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4444f:	8b 00                	mov    (%rax),%eax
   44451:	83 f8 2f             	cmp    $0x2f,%eax
   44454:	77 30                	ja     44486 <printer_vprintf+0x374>
   44456:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4445d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44461:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44468:	8b 00                	mov    (%rax),%eax
   4446a:	89 c0                	mov    %eax,%eax
   4446c:	48 01 d0             	add    %rdx,%rax
   4446f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44476:	8b 12                	mov    (%rdx),%edx
   44478:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4447b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44482:	89 0a                	mov    %ecx,(%rdx)
   44484:	eb 1a                	jmp    444a0 <printer_vprintf+0x38e>
   44486:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4448d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44491:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44495:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4449c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444a0:	48 8b 00             	mov    (%rax),%rax
   444a3:	eb 5c                	jmp    44501 <printer_vprintf+0x3ef>
   444a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ac:	8b 00                	mov    (%rax),%eax
   444ae:	83 f8 2f             	cmp    $0x2f,%eax
   444b1:	77 30                	ja     444e3 <printer_vprintf+0x3d1>
   444b3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ba:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c5:	8b 00                	mov    (%rax),%eax
   444c7:	89 c0                	mov    %eax,%eax
   444c9:	48 01 d0             	add    %rdx,%rax
   444cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444d3:	8b 12                	mov    (%rdx),%edx
   444d5:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444df:	89 0a                	mov    %ecx,(%rdx)
   444e1:	eb 1a                	jmp    444fd <printer_vprintf+0x3eb>
   444e3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ea:	48 8b 40 08          	mov    0x8(%rax),%rax
   444ee:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444f9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444fd:	8b 00                	mov    (%rax),%eax
   444ff:	48 98                	cltq   
   44501:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44505:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44509:	48 c1 f8 38          	sar    $0x38,%rax
   4450d:	25 80 00 00 00       	and    $0x80,%eax
   44512:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44515:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44519:	74 09                	je     44524 <printer_vprintf+0x412>
   4451b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4451f:	48 f7 d8             	neg    %rax
   44522:	eb 04                	jmp    44528 <printer_vprintf+0x416>
   44524:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44528:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4452c:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4452f:	83 c8 60             	or     $0x60,%eax
   44532:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44535:	e9 cf 02 00 00       	jmp    44809 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4453a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4453e:	74 5d                	je     4459d <printer_vprintf+0x48b>
   44540:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44547:	8b 00                	mov    (%rax),%eax
   44549:	83 f8 2f             	cmp    $0x2f,%eax
   4454c:	77 30                	ja     4457e <printer_vprintf+0x46c>
   4454e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44555:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44559:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44560:	8b 00                	mov    (%rax),%eax
   44562:	89 c0                	mov    %eax,%eax
   44564:	48 01 d0             	add    %rdx,%rax
   44567:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4456e:	8b 12                	mov    (%rdx),%edx
   44570:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44573:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4457a:	89 0a                	mov    %ecx,(%rdx)
   4457c:	eb 1a                	jmp    44598 <printer_vprintf+0x486>
   4457e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44585:	48 8b 40 08          	mov    0x8(%rax),%rax
   44589:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4458d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44594:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44598:	48 8b 00             	mov    (%rax),%rax
   4459b:	eb 5c                	jmp    445f9 <printer_vprintf+0x4e7>
   4459d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a4:	8b 00                	mov    (%rax),%eax
   445a6:	83 f8 2f             	cmp    $0x2f,%eax
   445a9:	77 30                	ja     445db <printer_vprintf+0x4c9>
   445ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445bd:	8b 00                	mov    (%rax),%eax
   445bf:	89 c0                	mov    %eax,%eax
   445c1:	48 01 d0             	add    %rdx,%rax
   445c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cb:	8b 12                	mov    (%rdx),%edx
   445cd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445d7:	89 0a                	mov    %ecx,(%rdx)
   445d9:	eb 1a                	jmp    445f5 <printer_vprintf+0x4e3>
   445db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445e2:	48 8b 40 08          	mov    0x8(%rax),%rax
   445e6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445ea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445f1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445f5:	8b 00                	mov    (%rax),%eax
   445f7:	89 c0                	mov    %eax,%eax
   445f9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   445fd:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44601:	e9 03 02 00 00       	jmp    44809 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   44606:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4460d:	e9 28 ff ff ff       	jmp    4453a <printer_vprintf+0x428>
        case 'X':
            base = 16;
   44612:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44619:	e9 1c ff ff ff       	jmp    4453a <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   4461e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44625:	8b 00                	mov    (%rax),%eax
   44627:	83 f8 2f             	cmp    $0x2f,%eax
   4462a:	77 30                	ja     4465c <printer_vprintf+0x54a>
   4462c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44633:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44637:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4463e:	8b 00                	mov    (%rax),%eax
   44640:	89 c0                	mov    %eax,%eax
   44642:	48 01 d0             	add    %rdx,%rax
   44645:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4464c:	8b 12                	mov    (%rdx),%edx
   4464e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44651:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44658:	89 0a                	mov    %ecx,(%rdx)
   4465a:	eb 1a                	jmp    44676 <printer_vprintf+0x564>
   4465c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44663:	48 8b 40 08          	mov    0x8(%rax),%rax
   44667:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4466b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44672:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44676:	48 8b 00             	mov    (%rax),%rax
   44679:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   4467d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   44684:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   4468b:	e9 79 01 00 00       	jmp    44809 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   44690:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44697:	8b 00                	mov    (%rax),%eax
   44699:	83 f8 2f             	cmp    $0x2f,%eax
   4469c:	77 30                	ja     446ce <printer_vprintf+0x5bc>
   4469e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446a5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   446a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446b0:	8b 00                	mov    (%rax),%eax
   446b2:	89 c0                	mov    %eax,%eax
   446b4:	48 01 d0             	add    %rdx,%rax
   446b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446be:	8b 12                	mov    (%rdx),%edx
   446c0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   446c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446ca:	89 0a                	mov    %ecx,(%rdx)
   446cc:	eb 1a                	jmp    446e8 <printer_vprintf+0x5d6>
   446ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446d5:	48 8b 40 08          	mov    0x8(%rax),%rax
   446d9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   446dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   446e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   446e8:	48 8b 00             	mov    (%rax),%rax
   446eb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   446ef:	e9 15 01 00 00       	jmp    44809 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   446f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   446fb:	8b 00                	mov    (%rax),%eax
   446fd:	83 f8 2f             	cmp    $0x2f,%eax
   44700:	77 30                	ja     44732 <printer_vprintf+0x620>
   44702:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44709:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4470d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44714:	8b 00                	mov    (%rax),%eax
   44716:	89 c0                	mov    %eax,%eax
   44718:	48 01 d0             	add    %rdx,%rax
   4471b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44722:	8b 12                	mov    (%rdx),%edx
   44724:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44727:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4472e:	89 0a                	mov    %ecx,(%rdx)
   44730:	eb 1a                	jmp    4474c <printer_vprintf+0x63a>
   44732:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44739:	48 8b 40 08          	mov    0x8(%rax),%rax
   4473d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44741:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44748:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4474c:	8b 00                	mov    (%rax),%eax
   4474e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44754:	e9 67 03 00 00       	jmp    44ac0 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44759:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4475d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44761:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44768:	8b 00                	mov    (%rax),%eax
   4476a:	83 f8 2f             	cmp    $0x2f,%eax
   4476d:	77 30                	ja     4479f <printer_vprintf+0x68d>
   4476f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44776:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4477a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44781:	8b 00                	mov    (%rax),%eax
   44783:	89 c0                	mov    %eax,%eax
   44785:	48 01 d0             	add    %rdx,%rax
   44788:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4478f:	8b 12                	mov    (%rdx),%edx
   44791:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44794:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4479b:	89 0a                	mov    %ecx,(%rdx)
   4479d:	eb 1a                	jmp    447b9 <printer_vprintf+0x6a7>
   4479f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   447a6:	48 8b 40 08          	mov    0x8(%rax),%rax
   447aa:	48 8d 48 08          	lea    0x8(%rax),%rcx
   447ae:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   447b5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   447b9:	8b 00                	mov    (%rax),%eax
   447bb:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   447be:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   447c2:	eb 45                	jmp    44809 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   447c4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   447c8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   447cc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   447d3:	0f b6 00             	movzbl (%rax),%eax
   447d6:	84 c0                	test   %al,%al
   447d8:	74 0c                	je     447e6 <printer_vprintf+0x6d4>
   447da:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   447e1:	0f b6 00             	movzbl (%rax),%eax
   447e4:	eb 05                	jmp    447eb <printer_vprintf+0x6d9>
   447e6:	b8 25 00 00 00       	mov    $0x25,%eax
   447eb:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   447ee:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   447f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   447f9:	0f b6 00             	movzbl (%rax),%eax
   447fc:	84 c0                	test   %al,%al
   447fe:	75 08                	jne    44808 <printer_vprintf+0x6f6>
                format--;
   44800:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44807:	01 
            }
            break;
   44808:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44809:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4480c:	83 e0 20             	and    $0x20,%eax
   4480f:	85 c0                	test   %eax,%eax
   44811:	74 1e                	je     44831 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44813:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44817:	48 83 c0 18          	add    $0x18,%rax
   4481b:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4481e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44822:	48 89 ce             	mov    %rcx,%rsi
   44825:	48 89 c7             	mov    %rax,%rdi
   44828:	e8 63 f8 ff ff       	call   44090 <fill_numbuf>
   4482d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44831:	48 c7 45 c0 66 5a 04 	movq   $0x45a66,-0x40(%rbp)
   44838:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44839:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4483c:	83 e0 20             	and    $0x20,%eax
   4483f:	85 c0                	test   %eax,%eax
   44841:	74 48                	je     4488b <printer_vprintf+0x779>
   44843:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44846:	83 e0 40             	and    $0x40,%eax
   44849:	85 c0                	test   %eax,%eax
   4484b:	74 3e                	je     4488b <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   4484d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44850:	25 80 00 00 00       	and    $0x80,%eax
   44855:	85 c0                	test   %eax,%eax
   44857:	74 0a                	je     44863 <printer_vprintf+0x751>
                prefix = "-";
   44859:	48 c7 45 c0 67 5a 04 	movq   $0x45a67,-0x40(%rbp)
   44860:	00 
            if (flags & FLAG_NEGATIVE) {
   44861:	eb 73                	jmp    448d6 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44863:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44866:	83 e0 10             	and    $0x10,%eax
   44869:	85 c0                	test   %eax,%eax
   4486b:	74 0a                	je     44877 <printer_vprintf+0x765>
                prefix = "+";
   4486d:	48 c7 45 c0 69 5a 04 	movq   $0x45a69,-0x40(%rbp)
   44874:	00 
            if (flags & FLAG_NEGATIVE) {
   44875:	eb 5f                	jmp    448d6 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44877:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4487a:	83 e0 08             	and    $0x8,%eax
   4487d:	85 c0                	test   %eax,%eax
   4487f:	74 55                	je     448d6 <printer_vprintf+0x7c4>
                prefix = " ";
   44881:	48 c7 45 c0 6b 5a 04 	movq   $0x45a6b,-0x40(%rbp)
   44888:	00 
            if (flags & FLAG_NEGATIVE) {
   44889:	eb 4b                	jmp    448d6 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4488b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4488e:	83 e0 20             	and    $0x20,%eax
   44891:	85 c0                	test   %eax,%eax
   44893:	74 42                	je     448d7 <printer_vprintf+0x7c5>
   44895:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44898:	83 e0 01             	and    $0x1,%eax
   4489b:	85 c0                	test   %eax,%eax
   4489d:	74 38                	je     448d7 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4489f:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   448a3:	74 06                	je     448ab <printer_vprintf+0x799>
   448a5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   448a9:	75 2c                	jne    448d7 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   448ab:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   448b0:	75 0c                	jne    448be <printer_vprintf+0x7ac>
   448b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448b5:	25 00 01 00 00       	and    $0x100,%eax
   448ba:	85 c0                	test   %eax,%eax
   448bc:	74 19                	je     448d7 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   448be:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   448c2:	75 07                	jne    448cb <printer_vprintf+0x7b9>
   448c4:	b8 6d 5a 04 00       	mov    $0x45a6d,%eax
   448c9:	eb 05                	jmp    448d0 <printer_vprintf+0x7be>
   448cb:	b8 70 5a 04 00       	mov    $0x45a70,%eax
   448d0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   448d4:	eb 01                	jmp    448d7 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   448d6:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   448d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   448db:	78 24                	js     44901 <printer_vprintf+0x7ef>
   448dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448e0:	83 e0 20             	and    $0x20,%eax
   448e3:	85 c0                	test   %eax,%eax
   448e5:	75 1a                	jne    44901 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   448e7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   448ea:	48 63 d0             	movslq %eax,%rdx
   448ed:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   448f1:	48 89 d6             	mov    %rdx,%rsi
   448f4:	48 89 c7             	mov    %rax,%rdi
   448f7:	e8 ea f5 ff ff       	call   43ee6 <strnlen>
   448fc:	89 45 bc             	mov    %eax,-0x44(%rbp)
   448ff:	eb 0f                	jmp    44910 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44901:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44905:	48 89 c7             	mov    %rax,%rdi
   44908:	e8 a8 f5 ff ff       	call   43eb5 <strlen>
   4490d:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44910:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44913:	83 e0 20             	and    $0x20,%eax
   44916:	85 c0                	test   %eax,%eax
   44918:	74 20                	je     4493a <printer_vprintf+0x828>
   4491a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4491e:	78 1a                	js     4493a <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44920:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44923:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44926:	7e 08                	jle    44930 <printer_vprintf+0x81e>
   44928:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4492b:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4492e:	eb 05                	jmp    44935 <printer_vprintf+0x823>
   44930:	b8 00 00 00 00       	mov    $0x0,%eax
   44935:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44938:	eb 5c                	jmp    44996 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4493a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4493d:	83 e0 20             	and    $0x20,%eax
   44940:	85 c0                	test   %eax,%eax
   44942:	74 4b                	je     4498f <printer_vprintf+0x87d>
   44944:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44947:	83 e0 02             	and    $0x2,%eax
   4494a:	85 c0                	test   %eax,%eax
   4494c:	74 41                	je     4498f <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   4494e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44951:	83 e0 04             	and    $0x4,%eax
   44954:	85 c0                	test   %eax,%eax
   44956:	75 37                	jne    4498f <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44958:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4495c:	48 89 c7             	mov    %rax,%rdi
   4495f:	e8 51 f5 ff ff       	call   43eb5 <strlen>
   44964:	89 c2                	mov    %eax,%edx
   44966:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44969:	01 d0                	add    %edx,%eax
   4496b:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   4496e:	7e 1f                	jle    4498f <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   44970:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44973:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44976:	89 c3                	mov    %eax,%ebx
   44978:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4497c:	48 89 c7             	mov    %rax,%rdi
   4497f:	e8 31 f5 ff ff       	call   43eb5 <strlen>
   44984:	89 c2                	mov    %eax,%edx
   44986:	89 d8                	mov    %ebx,%eax
   44988:	29 d0                	sub    %edx,%eax
   4498a:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4498d:	eb 07                	jmp    44996 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4498f:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44996:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44999:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4499c:	01 d0                	add    %edx,%eax
   4499e:	48 63 d8             	movslq %eax,%rbx
   449a1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   449a5:	48 89 c7             	mov    %rax,%rdi
   449a8:	e8 08 f5 ff ff       	call   43eb5 <strlen>
   449ad:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   449b1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   449b4:	29 d0                	sub    %edx,%eax
   449b6:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   449b9:	eb 25                	jmp    449e0 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   449bb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   449c2:	48 8b 08             	mov    (%rax),%rcx
   449c5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   449cb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   449d2:	be 20 00 00 00       	mov    $0x20,%esi
   449d7:	48 89 c7             	mov    %rax,%rdi
   449da:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   449dc:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   449e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   449e3:	83 e0 04             	and    $0x4,%eax
   449e6:	85 c0                	test   %eax,%eax
   449e8:	75 36                	jne    44a20 <printer_vprintf+0x90e>
   449ea:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   449ee:	7f cb                	jg     449bb <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   449f0:	eb 2e                	jmp    44a20 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   449f2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   449f9:	4c 8b 00             	mov    (%rax),%r8
   449fc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44a00:	0f b6 00             	movzbl (%rax),%eax
   44a03:	0f b6 c8             	movzbl %al,%ecx
   44a06:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a0c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a13:	89 ce                	mov    %ecx,%esi
   44a15:	48 89 c7             	mov    %rax,%rdi
   44a18:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44a1b:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44a20:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44a24:	0f b6 00             	movzbl (%rax),%eax
   44a27:	84 c0                	test   %al,%al
   44a29:	75 c7                	jne    449f2 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   44a2b:	eb 25                	jmp    44a52 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   44a2d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a34:	48 8b 08             	mov    (%rax),%rcx
   44a37:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a3d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a44:	be 30 00 00 00       	mov    $0x30,%esi
   44a49:	48 89 c7             	mov    %rax,%rdi
   44a4c:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44a4e:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44a52:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44a56:	7f d5                	jg     44a2d <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44a58:	eb 32                	jmp    44a8c <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44a5a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a61:	4c 8b 00             	mov    (%rax),%r8
   44a64:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44a68:	0f b6 00             	movzbl (%rax),%eax
   44a6b:	0f b6 c8             	movzbl %al,%ecx
   44a6e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44a74:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a7b:	89 ce                	mov    %ecx,%esi
   44a7d:	48 89 c7             	mov    %rax,%rdi
   44a80:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44a83:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44a88:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44a8c:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44a90:	7f c8                	jg     44a5a <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   44a92:	eb 25                	jmp    44ab9 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44a94:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44a9b:	48 8b 08             	mov    (%rax),%rcx
   44a9e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44aa4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44aab:	be 20 00 00 00       	mov    $0x20,%esi
   44ab0:	48 89 c7             	mov    %rax,%rdi
   44ab3:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44ab5:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44ab9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44abd:	7f d5                	jg     44a94 <printer_vprintf+0x982>
        }
    done: ;
   44abf:	90                   	nop
    for (; *format; ++format) {
   44ac0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44ac7:	01 
   44ac8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44acf:	0f b6 00             	movzbl (%rax),%eax
   44ad2:	84 c0                	test   %al,%al
   44ad4:	0f 85 64 f6 ff ff    	jne    4413e <printer_vprintf+0x2c>
    }
}
   44ada:	90                   	nop
   44adb:	90                   	nop
   44adc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44ae0:	c9                   	leave  
   44ae1:	c3                   	ret    

0000000000044ae2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44ae2:	55                   	push   %rbp
   44ae3:	48 89 e5             	mov    %rsp,%rbp
   44ae6:	48 83 ec 20          	sub    $0x20,%rsp
   44aea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44aee:	89 f0                	mov    %esi,%eax
   44af0:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44af3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44af6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44afa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44afe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b02:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b06:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44b0b:	48 39 d0             	cmp    %rdx,%rax
   44b0e:	72 0c                	jb     44b1c <console_putc+0x3a>
        cp->cursor = console;
   44b10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b14:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44b1b:	00 
    }
    if (c == '\n') {
   44b1c:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44b20:	75 78                	jne    44b9a <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44b22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b26:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b2a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44b30:	48 d1 f8             	sar    %rax
   44b33:	48 89 c1             	mov    %rax,%rcx
   44b36:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44b3d:	66 66 66 
   44b40:	48 89 c8             	mov    %rcx,%rax
   44b43:	48 f7 ea             	imul   %rdx
   44b46:	48 c1 fa 05          	sar    $0x5,%rdx
   44b4a:	48 89 c8             	mov    %rcx,%rax
   44b4d:	48 c1 f8 3f          	sar    $0x3f,%rax
   44b51:	48 29 c2             	sub    %rax,%rdx
   44b54:	48 89 d0             	mov    %rdx,%rax
   44b57:	48 c1 e0 02          	shl    $0x2,%rax
   44b5b:	48 01 d0             	add    %rdx,%rax
   44b5e:	48 c1 e0 04          	shl    $0x4,%rax
   44b62:	48 29 c1             	sub    %rax,%rcx
   44b65:	48 89 ca             	mov    %rcx,%rdx
   44b68:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44b6b:	eb 25                	jmp    44b92 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44b6d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44b70:	83 c8 20             	or     $0x20,%eax
   44b73:	89 c6                	mov    %eax,%esi
   44b75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b79:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b7d:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44b81:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44b85:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b89:	89 f2                	mov    %esi,%edx
   44b8b:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44b8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44b92:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44b96:	75 d5                	jne    44b6d <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44b98:	eb 24                	jmp    44bbe <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44b9a:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44b9e:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44ba1:	09 d0                	or     %edx,%eax
   44ba3:	89 c6                	mov    %eax,%esi
   44ba5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44ba9:	48 8b 40 08          	mov    0x8(%rax),%rax
   44bad:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44bb1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44bb5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44bb9:	89 f2                	mov    %esi,%edx
   44bbb:	66 89 10             	mov    %dx,(%rax)
}
   44bbe:	90                   	nop
   44bbf:	c9                   	leave  
   44bc0:	c3                   	ret    

0000000000044bc1 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44bc1:	55                   	push   %rbp
   44bc2:	48 89 e5             	mov    %rsp,%rbp
   44bc5:	48 83 ec 30          	sub    $0x30,%rsp
   44bc9:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44bcc:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44bcf:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44bd3:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44bd7:	48 c7 45 f0 e2 4a 04 	movq   $0x44ae2,-0x10(%rbp)
   44bde:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44bdf:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44be3:	78 09                	js     44bee <console_vprintf+0x2d>
   44be5:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44bec:	7e 07                	jle    44bf5 <console_vprintf+0x34>
        cpos = 0;
   44bee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44bf5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44bf8:	48 98                	cltq   
   44bfa:	48 01 c0             	add    %rax,%rax
   44bfd:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44c03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44c07:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44c0b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44c0f:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44c12:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44c16:	48 89 c7             	mov    %rax,%rdi
   44c19:	e8 f4 f4 ff ff       	call   44112 <printer_vprintf>
    return cp.cursor - console;
   44c1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44c22:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44c28:	48 d1 f8             	sar    %rax
}
   44c2b:	c9                   	leave  
   44c2c:	c3                   	ret    

0000000000044c2d <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44c2d:	55                   	push   %rbp
   44c2e:	48 89 e5             	mov    %rsp,%rbp
   44c31:	48 83 ec 60          	sub    $0x60,%rsp
   44c35:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44c38:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44c3b:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44c3f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44c43:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44c47:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44c4b:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44c52:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44c56:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44c5a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44c5e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44c62:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44c66:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44c6a:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44c6d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44c70:	89 c7                	mov    %eax,%edi
   44c72:	e8 4a ff ff ff       	call   44bc1 <console_vprintf>
   44c77:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44c7a:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44c7d:	c9                   	leave  
   44c7e:	c3                   	ret    

0000000000044c7f <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44c7f:	55                   	push   %rbp
   44c80:	48 89 e5             	mov    %rsp,%rbp
   44c83:	48 83 ec 20          	sub    $0x20,%rsp
   44c87:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44c8b:	89 f0                	mov    %esi,%eax
   44c8d:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44c90:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44c93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44c97:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44c9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44c9f:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44ca3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ca7:	48 8b 40 10          	mov    0x10(%rax),%rax
   44cab:	48 39 c2             	cmp    %rax,%rdx
   44cae:	73 1a                	jae    44cca <string_putc+0x4b>
        *sp->s++ = c;
   44cb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44cb4:	48 8b 40 08          	mov    0x8(%rax),%rax
   44cb8:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44cbc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44cc0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44cc4:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44cc8:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44cca:	90                   	nop
   44ccb:	c9                   	leave  
   44ccc:	c3                   	ret    

0000000000044ccd <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44ccd:	55                   	push   %rbp
   44cce:	48 89 e5             	mov    %rsp,%rbp
   44cd1:	48 83 ec 40          	sub    $0x40,%rsp
   44cd5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44cd9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44cdd:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44ce1:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44ce5:	48 c7 45 e8 7f 4c 04 	movq   $0x44c7f,-0x18(%rbp)
   44cec:	00 
    sp.s = s;
   44ced:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44cf1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44cf5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44cfa:	74 33                	je     44d2f <vsnprintf+0x62>
        sp.end = s + size - 1;
   44cfc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44d00:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44d04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44d08:	48 01 d0             	add    %rdx,%rax
   44d0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44d0f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44d13:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44d17:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44d1b:	be 00 00 00 00       	mov    $0x0,%esi
   44d20:	48 89 c7             	mov    %rax,%rdi
   44d23:	e8 ea f3 ff ff       	call   44112 <printer_vprintf>
        *sp.s = 0;
   44d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44d2c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44d2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44d33:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44d37:	c9                   	leave  
   44d38:	c3                   	ret    

0000000000044d39 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44d39:	55                   	push   %rbp
   44d3a:	48 89 e5             	mov    %rsp,%rbp
   44d3d:	48 83 ec 70          	sub    $0x70,%rsp
   44d41:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44d45:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44d49:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44d4d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44d51:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44d55:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44d59:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44d60:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44d64:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44d68:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44d6c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44d70:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44d74:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44d78:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44d7c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44d80:	48 89 c7             	mov    %rax,%rdi
   44d83:	e8 45 ff ff ff       	call   44ccd <vsnprintf>
   44d88:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44d8b:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44d8e:	c9                   	leave  
   44d8f:	c3                   	ret    

0000000000044d90 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44d90:	55                   	push   %rbp
   44d91:	48 89 e5             	mov    %rsp,%rbp
   44d94:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44d98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44d9f:	eb 13                	jmp    44db4 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44da1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44da4:	48 98                	cltq   
   44da6:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44dad:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44db0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44db4:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44dbb:	7e e4                	jle    44da1 <console_clear+0x11>
    }
    cursorpos = 0;
   44dbd:	c7 05 35 42 07 00 00 	movl   $0x0,0x74235(%rip)        # b8ffc <cursorpos>
   44dc4:	00 00 00 
}
   44dc7:	90                   	nop
   44dc8:	c9                   	leave  
   44dc9:	c3                   	ret    
