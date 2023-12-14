
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <ptr_comparator>:

int ptr_comparator( const void * a, const void * b){
    ptr_with_size * a_ptr = (ptr_with_size *) a;
    ptr_with_size * b_ptr = (ptr_with_size *) b;

    return (int)b_ptr->size - (int)a_ptr->size;
  100000:	48 8b 46 08          	mov    0x8(%rsi),%rax
  100004:	2b 47 08             	sub    0x8(%rdi),%eax
}
  100007:	c3                   	ret    

0000000000100008 <_quicksort>:
    if (total_elems == 0)
  100008:	48 85 f6             	test   %rsi,%rsi
  10000b:	0f 84 5f 04 00 00    	je     100470 <_quicksort+0x468>
{
  100011:	55                   	push   %rbp
  100012:	48 89 e5             	mov    %rsp,%rbp
  100015:	41 57                	push   %r15
  100017:	41 56                	push   %r14
  100019:	41 55                	push   %r13
  10001b:	41 54                	push   %r12
  10001d:	53                   	push   %rbx
  10001e:	48 81 ec 48 04 00 00 	sub    $0x448,%rsp
  100025:	49 89 f5             	mov    %rsi,%r13
  100028:	49 89 d7             	mov    %rdx,%r15
  10002b:	49 89 cc             	mov    %rcx,%r12
    const size_t max_thresh = MAX_THRESH * size;
  10002e:	48 8d 0c 95 00 00 00 	lea    0x0(,%rdx,4),%rcx
  100035:	00 
    if (total_elems > MAX_THRESH)
  100036:	48 83 fe 04          	cmp    $0x4,%rsi
  10003a:	0f 86 0a 03 00 00    	jbe    10034a <_quicksort+0x342>
	char *hi = &lo[size * (total_elems - 1)];
  100040:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
  100044:	48 0f af c2          	imul   %rdx,%rax
  100048:	48 01 f8             	add    %rdi,%rax
  10004b:	48 89 85 c0 fb ff ff 	mov    %rax,-0x440(%rbp)
	PUSH (NULL, NULL);
  100052:	48 c7 85 d0 fb ff ff 	movq   $0x0,-0x430(%rbp)
  100059:	00 00 00 00 
  10005d:	48 c7 85 d8 fb ff ff 	movq   $0x0,-0x428(%rbp)
  100064:	00 00 00 00 
	char *lo = base_ptr;
  100068:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	PUSH (NULL, NULL);
  10006f:	48 8d 85 e0 fb ff ff 	lea    -0x420(%rbp),%rax
  100076:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	  right_ptr = hi - size;
  10007d:	49 89 d6             	mov    %rdx,%r14
  100080:	49 f7 de             	neg    %r14
  100083:	48 89 8d a8 fb ff ff 	mov    %rcx,-0x458(%rbp)
  10008a:	48 89 bd a0 fb ff ff 	mov    %rdi,-0x460(%rbp)
  100091:	48 89 b5 98 fb ff ff 	mov    %rsi,-0x468(%rbp)
  100098:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
  10009f:	e9 9b 01 00 00       	jmp    10023f <_quicksort+0x237>
  1000a4:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1000ab:	49 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%rdi
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  1000b0:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  1000b7:	4c 89 e8             	mov    %r13,%rax
  1000ba:	0f b6 08             	movzbl (%rax),%ecx
  1000bd:	48 83 c0 01          	add    $0x1,%rax
  1000c1:	0f b6 32             	movzbl (%rdx),%esi
  1000c4:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1000c8:	48 83 c2 01          	add    $0x1,%rdx
  1000cc:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1000cf:	48 39 c7             	cmp    %rax,%rdi
  1000d2:	75 e6                	jne    1000ba <_quicksort+0xb2>
  1000d4:	e9 a2 01 00 00       	jmp    10027b <_quicksort+0x273>
  1000d9:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1000e0:	49 8d 5c 05 00       	lea    0x0(%r13,%rax,1),%rbx
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  1000e5:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
		SWAP (mid, hi, size);
  1000ec:	4c 89 e8             	mov    %r13,%rax
  1000ef:	0f b6 08             	movzbl (%rax),%ecx
  1000f2:	48 83 c0 01          	add    $0x1,%rax
  1000f6:	0f b6 32             	movzbl (%rdx),%esi
  1000f9:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  1000fd:	48 83 c2 01          	add    $0x1,%rdx
  100101:	88 4a ff             	mov    %cl,-0x1(%rdx)
  100104:	48 39 c3             	cmp    %rax,%rbx
  100107:	75 e6                	jne    1000ef <_quicksort+0xe7>
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  100109:	48 8b b5 b8 fb ff ff 	mov    -0x448(%rbp),%rsi
  100110:	4c 89 ef             	mov    %r13,%rdi
  100113:	41 ff d4             	call   *%r12
  100116:	85 c0                	test   %eax,%eax
  100118:	0f 89 72 01 00 00    	jns    100290 <_quicksort+0x288>
  10011e:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
		SWAP (mid, lo, size);
  100125:	4c 89 e8             	mov    %r13,%rax
  100128:	0f b6 08             	movzbl (%rax),%ecx
  10012b:	48 83 c0 01          	add    $0x1,%rax
  10012f:	0f b6 32             	movzbl (%rdx),%esi
  100132:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  100136:	48 83 c2 01          	add    $0x1,%rdx
  10013a:	88 4a ff             	mov    %cl,-0x1(%rdx)
  10013d:	48 39 c3             	cmp    %rax,%rbx
  100140:	75 e6                	jne    100128 <_quicksort+0x120>
jump_over:;
  100142:	e9 49 01 00 00       	jmp    100290 <_quicksort+0x288>
		  right_ptr -= size;
  100147:	4c 01 f3             	add    %r14,%rbx
	      while ((*cmp) ((void *) mid, (void *) right_ptr) < 0)
  10014a:	48 89 de             	mov    %rbx,%rsi
  10014d:	4c 89 ef             	mov    %r13,%rdi
  100150:	41 ff d4             	call   *%r12
  100153:	85 c0                	test   %eax,%eax
  100155:	78 f0                	js     100147 <_quicksort+0x13f>
	      if (left_ptr < right_ptr)
  100157:	49 39 df             	cmp    %rbx,%r15
  10015a:	72 20                	jb     10017c <_quicksort+0x174>
	      else if (left_ptr == right_ptr)
  10015c:	74 62                	je     1001c0 <_quicksort+0x1b8>
	  while (left_ptr <= right_ptr);
  10015e:	4c 39 fb             	cmp    %r15,%rbx
  100161:	72 6a                	jb     1001cd <_quicksort+0x1c5>
	      while ((*cmp) ((void *) left_ptr, (void *) mid) < 0)
  100163:	4c 89 ee             	mov    %r13,%rsi
  100166:	4c 89 ff             	mov    %r15,%rdi
  100169:	41 ff d4             	call   *%r12
  10016c:	85 c0                	test   %eax,%eax
  10016e:	79 da                	jns    10014a <_quicksort+0x142>
		  left_ptr += size;
  100170:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100177:	49 01 c7             	add    %rax,%r15
  10017a:	eb e7                	jmp    100163 <_quicksort+0x15b>
  10017c:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  100183:	49 8d 3c 07          	lea    (%r15,%rax,1),%rdi
	      if (left_ptr < right_ptr)
  100187:	48 89 da             	mov    %rbx,%rdx
  10018a:	4c 89 f8             	mov    %r15,%rax
		  SWAP (left_ptr, right_ptr, size);
  10018d:	0f b6 08             	movzbl (%rax),%ecx
  100190:	48 83 c0 01          	add    $0x1,%rax
  100194:	0f b6 32             	movzbl (%rdx),%esi
  100197:	40 88 70 ff          	mov    %sil,-0x1(%rax)
  10019b:	48 83 c2 01          	add    $0x1,%rdx
  10019f:	88 4a ff             	mov    %cl,-0x1(%rdx)
  1001a2:	48 39 f8             	cmp    %rdi,%rax
  1001a5:	75 e6                	jne    10018d <_quicksort+0x185>
		  if (mid == left_ptr)
  1001a7:	4d 39 ef             	cmp    %r13,%r15
  1001aa:	74 0f                	je     1001bb <_quicksort+0x1b3>
		  else if (mid == right_ptr)
  1001ac:	4c 39 eb             	cmp    %r13,%rbx
  1001af:	4d 0f 44 ef          	cmove  %r15,%r13
		  right_ptr -= size;
  1001b3:	4c 01 f3             	add    %r14,%rbx
		  left_ptr += size;
  1001b6:	49 89 ff             	mov    %rdi,%r15
  1001b9:	eb a3                	jmp    10015e <_quicksort+0x156>
  1001bb:	49 89 dd             	mov    %rbx,%r13
  1001be:	eb f3                	jmp    1001b3 <_quicksort+0x1ab>
		  left_ptr += size;
  1001c0:	48 8b 85 c8 fb ff ff 	mov    -0x438(%rbp),%rax
  1001c7:	49 01 c7             	add    %rax,%r15
		  right_ptr -= size;
  1001ca:	4c 01 f3             	add    %r14,%rbx
	  if ((size_t) (right_ptr - lo) <= max_thresh)
  1001cd:	48 89 d8             	mov    %rbx,%rax
  1001d0:	48 8b 95 b8 fb ff ff 	mov    -0x448(%rbp),%rdx
  1001d7:	48 29 d0             	sub    %rdx,%rax
  1001da:	48 8b bd a8 fb ff ff 	mov    -0x458(%rbp),%rdi
  1001e1:	48 39 c7             	cmp    %rax,%rdi
  1001e4:	0f 82 c8 00 00 00    	jb     1002b2 <_quicksort+0x2aa>
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  1001ea:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1001f1:	4c 29 f8             	sub    %r15,%rax
		  lo = left_ptr;
  1001f4:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
	      if ((size_t) (hi - left_ptr) <= max_thresh)
  1001fb:	48 39 c7             	cmp    %rax,%rdi
  1001fe:	72 28                	jb     100228 <_quicksort+0x220>
		  POP (lo, hi);
  100200:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  100207:	48 8b 78 f0          	mov    -0x10(%rax),%rdi
  10020b:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
  100212:	48 8b 78 f8          	mov    -0x8(%rax),%rdi
  100216:	48 89 bd c0 fb ff ff 	mov    %rdi,-0x440(%rbp)
  10021d:	48 8d 40 f0          	lea    -0x10(%rax),%rax
  100221:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	while (STACK_NOT_EMPTY)
  100228:	48 8d 85 d0 fb ff ff 	lea    -0x430(%rbp),%rax
  10022f:	48 8b bd b0 fb ff ff 	mov    -0x450(%rbp),%rdi
  100236:	48 39 f8             	cmp    %rdi,%rax
  100239:	0f 83 ef 00 00 00    	jae    10032e <_quicksort+0x326>
	    char *mid = lo + size * ((hi - lo) / size >> 1);
  10023f:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  100246:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  10024d:	48 29 f8             	sub    %rdi,%rax
  100250:	48 8b 8d c8 fb ff ff 	mov    -0x438(%rbp),%rcx
  100257:	ba 00 00 00 00       	mov    $0x0,%edx
  10025c:	48 f7 f1             	div    %rcx
  10025f:	48 d1 e8             	shr    %rax
  100262:	48 0f af c1          	imul   %rcx,%rax
  100266:	4c 8d 2c 07          	lea    (%rdi,%rax,1),%r13
	    if ((*cmp) ((void *) mid, (void *) lo) < 0)
  10026a:	48 89 fe             	mov    %rdi,%rsi
  10026d:	4c 89 ef             	mov    %r13,%rdi
  100270:	41 ff d4             	call   *%r12
  100273:	85 c0                	test   %eax,%eax
  100275:	0f 88 29 fe ff ff    	js     1000a4 <_quicksort+0x9c>
	    if ((*cmp) ((void *) hi, (void *) mid) < 0)
  10027b:	4c 89 ee             	mov    %r13,%rsi
  10027e:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100285:	41 ff d4             	call   *%r12
  100288:	85 c0                	test   %eax,%eax
  10028a:	0f 88 49 fe ff ff    	js     1000d9 <_quicksort+0xd1>
	  left_ptr  = lo + size;
  100290:	48 8b 85 b8 fb ff ff 	mov    -0x448(%rbp),%rax
  100297:	48 8b 95 c8 fb ff ff 	mov    -0x438(%rbp),%rdx
  10029e:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
	  right_ptr = hi - size;
  1002a2:	48 8b 85 c0 fb ff ff 	mov    -0x440(%rbp),%rax
  1002a9:	4a 8d 1c 30          	lea    (%rax,%r14,1),%rbx
  1002ad:	e9 b1 fe ff ff       	jmp    100163 <_quicksort+0x15b>
	  else if ((size_t) (hi - left_ptr) <= max_thresh)
  1002b2:	48 8b 95 c0 fb ff ff 	mov    -0x440(%rbp),%rdx
  1002b9:	4c 29 fa             	sub    %r15,%rdx
  1002bc:	48 39 95 a8 fb ff ff 	cmp    %rdx,-0x458(%rbp)
  1002c3:	73 5d                	jae    100322 <_quicksort+0x31a>
	  else if ((right_ptr - lo) > (hi - left_ptr))
  1002c5:	48 39 d0             	cmp    %rdx,%rax
  1002c8:	7e 2c                	jle    1002f6 <_quicksort+0x2ee>
	      PUSH (lo, right_ptr);
  1002ca:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1002d1:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
  1002d8:	48 89 38             	mov    %rdi,(%rax)
  1002db:	48 89 58 08          	mov    %rbx,0x8(%rax)
  1002df:	48 83 c0 10          	add    $0x10,%rax
  1002e3:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      lo = left_ptr;
  1002ea:	4c 89 bd b8 fb ff ff 	mov    %r15,-0x448(%rbp)
  1002f1:	e9 32 ff ff ff       	jmp    100228 <_quicksort+0x220>
	      PUSH (left_ptr, hi);
  1002f6:	48 8b 85 b0 fb ff ff 	mov    -0x450(%rbp),%rax
  1002fd:	4c 89 38             	mov    %r15,(%rax)
  100300:	48 8b bd c0 fb ff ff 	mov    -0x440(%rbp),%rdi
  100307:	48 89 78 08          	mov    %rdi,0x8(%rax)
  10030b:	48 83 c0 10          	add    $0x10,%rax
  10030f:	48 89 85 b0 fb ff ff 	mov    %rax,-0x450(%rbp)
	      hi = right_ptr;
  100316:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  10031d:	e9 06 ff ff ff       	jmp    100228 <_quicksort+0x220>
	      hi = right_ptr;
  100322:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  100329:	e9 fa fe ff ff       	jmp    100228 <_quicksort+0x220>
  10032e:	48 8b 8d a8 fb ff ff 	mov    -0x458(%rbp),%rcx
  100335:	48 8b bd a0 fb ff ff 	mov    -0x460(%rbp),%rdi
  10033c:	4c 8b ad 98 fb ff ff 	mov    -0x468(%rbp),%r13
  100343:	4c 8b bd c8 fb ff ff 	mov    -0x438(%rbp),%r15
	char *const end_ptr = &base_ptr[size * (total_elems - 1)];
  10034a:	49 8d 45 ff          	lea    -0x1(%r13),%rax
  10034e:	49 0f af c7          	imul   %r15,%rax
  100352:	48 8d 14 07          	lea    (%rdi,%rax,1),%rdx
  100356:	48 89 95 c8 fb ff ff 	mov    %rdx,-0x438(%rbp)
	char *thresh = min(end_ptr, base_ptr + max_thresh);
  10035d:	48 8d 04 0f          	lea    (%rdi,%rcx,1),%rax
  100361:	48 39 c2             	cmp    %rax,%rdx
  100364:	48 0f 46 c2          	cmovbe %rdx,%rax
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100368:	4a 8d 1c 3f          	lea    (%rdi,%r15,1),%rbx
  10036c:	48 39 d8             	cmp    %rbx,%rax
  10036f:	72 62                	jb     1003d3 <_quicksort+0x3cb>
  100371:	49 89 de             	mov    %rbx,%r14
	char *tmp_ptr = base_ptr;
  100374:	49 89 fd             	mov    %rdi,%r13
  100377:	48 89 9d c0 fb ff ff 	mov    %rbx,-0x440(%rbp)
  10037e:	48 89 c3             	mov    %rax,%rbx
  100381:	48 89 bd b8 fb ff ff 	mov    %rdi,-0x448(%rbp)
	    if ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100388:	4c 89 ee             	mov    %r13,%rsi
  10038b:	4c 89 f7             	mov    %r14,%rdi
  10038e:	41 ff d4             	call   *%r12
  100391:	85 c0                	test   %eax,%eax
  100393:	4d 0f 48 ee          	cmovs  %r14,%r13
	for (run_ptr = tmp_ptr + size; run_ptr <= thresh; run_ptr += size)
  100397:	4d 01 fe             	add    %r15,%r14
  10039a:	4c 39 f3             	cmp    %r14,%rbx
  10039d:	73 e9                	jae    100388 <_quicksort+0x380>
  10039f:	48 8b 9d c0 fb ff ff 	mov    -0x440(%rbp),%rbx
  1003a6:	48 8b bd b8 fb ff ff 	mov    -0x448(%rbp),%rdi
	if (tmp_ptr != base_ptr)
  1003ad:	4b 8d 4c 3d 00       	lea    0x0(%r13,%r15,1),%rcx
  1003b2:	49 39 fd             	cmp    %rdi,%r13
  1003b5:	74 1c                	je     1003d3 <_quicksort+0x3cb>
	    SWAP (tmp_ptr, base_ptr, size);
  1003b7:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
  1003bc:	49 83 c5 01          	add    $0x1,%r13
  1003c0:	0f b6 17             	movzbl (%rdi),%edx
  1003c3:	41 88 55 ff          	mov    %dl,-0x1(%r13)
  1003c7:	48 83 c7 01          	add    $0x1,%rdi
  1003cb:	88 47 ff             	mov    %al,-0x1(%rdi)
  1003ce:	49 39 cd             	cmp    %rcx,%r13
  1003d1:	75 e4                	jne    1003b7 <_quicksort+0x3af>
	while ((run_ptr += size) <= end_ptr)
  1003d3:	4e 8d 34 3b          	lea    (%rbx,%r15,1),%r14
	    tmp_ptr = run_ptr - size;
  1003d7:	4d 89 fd             	mov    %r15,%r13
  1003da:	49 f7 dd             	neg    %r13
	while ((run_ptr += size) <= end_ptr)
  1003dd:	4c 39 b5 c8 fb ff ff 	cmp    %r14,-0x438(%rbp)
  1003e4:	73 15                	jae    1003fb <_quicksort+0x3f3>
}
  1003e6:	48 81 c4 48 04 00 00 	add    $0x448,%rsp
  1003ed:	5b                   	pop    %rbx
  1003ee:	41 5c                	pop    %r12
  1003f0:	41 5d                	pop    %r13
  1003f2:	41 5e                	pop    %r14
  1003f4:	41 5f                	pop    %r15
  1003f6:	5d                   	pop    %rbp
  1003f7:	c3                   	ret    
		tmp_ptr -= size;
  1003f8:	4c 01 eb             	add    %r13,%rbx
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  1003fb:	48 89 de             	mov    %rbx,%rsi
  1003fe:	4c 89 f7             	mov    %r14,%rdi
  100401:	41 ff d4             	call   *%r12
  100404:	85 c0                	test   %eax,%eax
  100406:	78 f0                	js     1003f8 <_quicksort+0x3f0>
	    tmp_ptr += size;
  100408:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
	    if (tmp_ptr != run_ptr)
  10040c:	4c 39 f6             	cmp    %r14,%rsi
  10040f:	75 15                	jne    100426 <_quicksort+0x41e>
	while ((run_ptr += size) <= end_ptr)
  100411:	4b 8d 04 3e          	lea    (%r14,%r15,1),%rax
  100415:	4c 89 f3             	mov    %r14,%rbx
  100418:	48 39 85 c8 fb ff ff 	cmp    %rax,-0x438(%rbp)
  10041f:	72 c5                	jb     1003e6 <_quicksort+0x3de>
  100421:	49 89 c6             	mov    %rax,%r14
	    while ((*cmp) ((void *) run_ptr, (void *) tmp_ptr) < 0)
  100424:	eb d5                	jmp    1003fb <_quicksort+0x3f3>
		while (--trav >= run_ptr)
  100426:	4b 8d 7c 3e ff       	lea    -0x1(%r14,%r15,1),%rdi
  10042b:	4c 39 f7             	cmp    %r14,%rdi
  10042e:	72 e1                	jb     100411 <_quicksort+0x409>
  100430:	4d 8d 46 ff          	lea    -0x1(%r14),%r8
  100434:	4d 89 c2             	mov    %r8,%r10
  100437:	eb 13                	jmp    10044c <_quicksort+0x444>
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100439:	48 89 f9             	mov    %rdi,%rcx
		    *hi = c;
  10043c:	44 88 09             	mov    %r9b,(%rcx)
		while (--trav >= run_ptr)
  10043f:	48 83 ef 01          	sub    $0x1,%rdi
  100443:	49 83 e8 01          	sub    $0x1,%r8
  100447:	49 39 fa             	cmp    %rdi,%r10
  10044a:	74 c5                	je     100411 <_quicksort+0x409>
		    char c = *trav;
  10044c:	44 0f b6 0f          	movzbl (%rdi),%r9d
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100450:	4c 89 c0             	mov    %r8,%rax
  100453:	49 39 f0             	cmp    %rsi,%r8
  100456:	72 e1                	jb     100439 <_quicksort+0x431>
  100458:	48 89 fa             	mov    %rdi,%rdx
			*hi = *lo;
  10045b:	0f b6 08             	movzbl (%rax),%ecx
  10045e:	88 0a                	mov    %cl,(%rdx)
		    for (hi = lo = trav; (lo -= size) >= tmp_ptr; hi = lo)
  100460:	48 89 c1             	mov    %rax,%rcx
  100463:	4c 01 e8             	add    %r13,%rax
  100466:	4c 29 fa             	sub    %r15,%rdx
  100469:	48 39 f0             	cmp    %rsi,%rax
  10046c:	73 ed                	jae    10045b <_quicksort+0x453>
  10046e:	eb cc                	jmp    10043c <_quicksort+0x434>
  100470:	c3                   	ret    

0000000000100471 <exists_in_between>:


int exists_in_between(ptr_with_size *ptrs, void * ptr, long size, int len){

    for(int i = 0; i < len ; i++){
  100471:	85 c9                	test   %ecx,%ecx
  100473:	7e 53                	jle    1004c8 <exists_in_between+0x57>
  100475:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if(ptrs[i].ptr == ptr){
  10047b:	48 39 37             	cmp    %rsi,(%rdi)
  10047e:	74 13                	je     100493 <exists_in_between+0x22>
    for(int i = 0; i < len ; i++){
  100480:	41 83 c0 01          	add    $0x1,%r8d
  100484:	48 83 c7 10          	add    $0x10,%rdi
  100488:	44 39 c1             	cmp    %r8d,%ecx
  10048b:	75 ee                	jne    10047b <exists_in_between+0xa>
                return 0;
            }
        }
    }

    return 0;
  10048d:	b8 00 00 00 00       	mov    $0x0,%eax
  100492:	c3                   	ret    
            if(ptrs[i].size <= size)
  100493:	48 8b 77 08          	mov    0x8(%rdi),%rsi
                return 1;
  100497:	b8 01 00 00 00       	mov    $0x1,%eax
            if(ptrs[i].size <= size)
  10049c:	48 39 d6             	cmp    %rdx,%rsi
  10049f:	7f 01                	jg     1004a2 <exists_in_between+0x31>
}
  1004a1:	c3                   	ret    
int exists_in_between(ptr_with_size *ptrs, void * ptr, long size, int len){
  1004a2:	55                   	push   %rbp
  1004a3:	48 89 e5             	mov    %rsp,%rbp
                app_printf(0, "size (%ld, %ld) [%d, %d] ", size, ptrs[i].size, i, len - 1);
  1004a6:	44 8d 49 ff          	lea    -0x1(%rcx),%r9d
  1004aa:	48 89 f1             	mov    %rsi,%rcx
  1004ad:	be 20 20 10 00       	mov    $0x102020,%esi
  1004b2:	bf 00 00 00 00       	mov    $0x0,%edi
  1004b7:	b8 00 00 00 00       	mov    $0x0,%eax
  1004bc:	e8 c4 02 00 00       	call   100785 <app_printf>
                return 0;
  1004c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1004c6:	5d                   	pop    %rbp
  1004c7:	c3                   	ret    
    return 0;
  1004c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1004cd:	c3                   	ret    

00000000001004ce <process_main>:
void process_main(void) {
  1004ce:	55                   	push   %rbp
  1004cf:	48 89 e5             	mov    %rsp,%rbp
  1004d2:	41 57                	push   %r15
  1004d4:	41 56                	push   %r14
  1004d6:	41 55                	push   %r13
  1004d8:	41 54                	push   %r12
  1004da:	53                   	push   %rbx
  1004db:	48 83 ec 48          	sub    $0x48,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  1004df:	cd 31                	int    $0x31
  1004e1:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  1004e3:	e8 d6 0d 00 00       	call   1012be <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  1004e8:	b8 57 40 10 00       	mov    $0x104057,%eax
  1004ed:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1004f3:	48 89 05 1e 2b 00 00 	mov    %rax,0x2b1e(%rip)        # 103018 <heap_top>
  1004fa:	48 89 05 0f 2b 00 00 	mov    %rax,0x2b0f(%rip)        # 103010 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100501:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100504:	48 83 e8 01          	sub    $0x1,%rax
  100508:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10050e:	48 89 05 f3 2a 00 00 	mov    %rax,0x2af3(%rip)        # 103008 <stack_bottom>

    int sizes[] = {10, 20, 30, 1999};
  100515:	c7 45 c0 0a 00 00 00 	movl   $0xa,-0x40(%rbp)
  10051c:	c7 45 c4 14 00 00 00 	movl   $0x14,-0x3c(%rbp)
  100523:	c7 45 c8 1e 00 00 00 	movl   $0x1e,-0x38(%rbp)
  10052a:	c7 45 cc cf 07 00 00 	movl   $0x7cf,-0x34(%rbp)
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100531:	bf 00 b0 07 00       	mov    $0x7b000,%edi
  100536:	cd 3a                	int    $0x3a
  100538:	48 89 05 e1 2a 00 00 	mov    %rax,0x2ae1(%rip)        # 103020 <result.0>
  10053f:	ba 00 00 00 00       	mov    $0x0,%edx
  100544:	48 89 d7             	mov    %rdx,%rdi
  100547:	cd 3a                	int    $0x3a
  100549:	48 89 05 d0 2a 00 00 	mov    %rax,0x2ad0(%rip)        # 103020 <result.0>

    // leave about 1 MB for malloc
    sbrk(123 * PAGESIZE);
    heap_top = sbrk(0);
  100550:	48 89 05 c1 2a 00 00 	mov    %rax,0x2ac1(%rip)        # 103018 <heap_top>
	
    ptr_with_size *ptr = (ptr_with_size *)heap_bottom;
  100557:	4c 8b 2d b2 2a 00 00 	mov    0x2ab2(%rip),%r13        # 103010 <heap_bottom>
    asm volatile ("int %1" :  "=a" (result)
  10055e:	bf 00 f0 1f 00       	mov    $0x1ff000,%edi
  100563:	cd 39                	int    $0x39
  100565:	89 05 bd 2a 00 00    	mov    %eax,0x2abd(%rip)        # 103028 <result.1>
	
    // shift brk so we are 1 MB before stack
    brk((void *)(intptr_t)ROUNDDOWN(0x200000-1, PAGESIZE));
    volatile int ptr_size = 0;
  10056b:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%rbp)
    asm volatile ("int %0" : /* no result */
  100572:	bf 00 00 00 00       	mov    $0x0,%edi
  100577:	cd 38                	int    $0x38
    asm volatile ("int %1" :  "=a" (result)
  100579:	48 89 d7             	mov    %rdx,%rdi
  10057c:	cd 3a                	int    $0x3a
  10057e:	48 89 05 9b 2a 00 00 	mov    %rax,0x2a9b(%rip)        # 103020 <result.0>
    mem_tog(0);
	int count = 0;
    while((intptr_t)ROUNDUP(sbrk(0), PAGESIZE) <= 0x280000){
  100585:	48 05 ff 0f 00 00    	add    $0xfff,%rax
  10058b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100591:	48 3d 00 00 28 00    	cmp    $0x280000,%rax
  100597:	0f 8f b8 00 00 00    	jg     100655 <process_main+0x187>
	int count = 0;
  10059d:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  1005a3:	41 be 00 00 00 00    	mov    $0x0,%r14d
	int sz = ALLOC(ptr_size);
  1005a9:	8b 45 bc             	mov    -0x44(%rbp),%eax
  1005ac:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1005af:	89 d3                	mov    %edx,%ebx
  1005b1:	c1 fb 02             	sar    $0x2,%ebx
  1005b4:	c1 fa 1f             	sar    $0x1f,%edx
  1005b7:	c1 ea 1e             	shr    $0x1e,%edx
  1005ba:	01 d3                	add    %edx,%ebx
  1005bc:	83 e3 03             	and    $0x3,%ebx
  1005bf:	29 d3                	sub    %edx,%ebx
  1005c1:	83 c3 01             	add    $0x1,%ebx
  1005c4:	99                   	cltd   
  1005c5:	c1 ea 1e             	shr    $0x1e,%edx
  1005c8:	01 d0                	add    %edx,%eax
  1005ca:	83 e0 03             	and    $0x3,%eax
  1005cd:	29 d0                	sub    %edx,%eax
  1005cf:	48 98                	cltq   
  1005d1:	0f af 5c 85 c0       	imul   -0x40(%rbp,%rax,4),%ebx
	void * temp_ptr = malloc(sz);
  1005d6:	48 63 fb             	movslq %ebx,%rdi
  1005d9:	e8 7a 06 00 00       	call   100c58 <malloc>
  1005de:	49 89 c7             	mov    %rax,%r15
	console_printf(CPOS(0,0), 0, "Malloc%d: %d", ((intptr_t) temp_ptr), count);
  1005e1:	45 89 e0             	mov    %r12d,%r8d
  1005e4:	48 89 c1             	mov    %rax,%rcx
  1005e7:	ba 3a 20 10 00       	mov    $0x10203a,%edx
  1005ec:	be 00 00 00 00       	mov    $0x0,%esi
  1005f1:	bf 00 00 00 00       	mov    $0x0,%edi
  1005f6:	b8 00 00 00 00       	mov    $0x0,%eax
  1005fb:	e8 7c 18 00 00       	call   101e7c <console_printf>
	if(temp_ptr == NULL)
  100600:	4d 85 ff             	test   %r15,%r15
  100603:	74 50                	je     100655 <process_main+0x187>
	    break;
	ptr[ptr_size].ptr = temp_ptr;
  100605:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100608:	48 98                	cltq   
  10060a:	48 c1 e0 04          	shl    $0x4,%rax
  10060e:	4d 89 7c 05 00       	mov    %r15,0x0(%r13,%rax,1)
	ptr[ptr_size].size = sz;
  100613:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100616:	48 98                	cltq   
  100618:	48 c1 e0 04          	shl    $0x4,%rax
  10061c:	48 63 db             	movslq %ebx,%rbx
  10061f:	49 89 5c 05 08       	mov    %rbx,0x8(%r13,%rax,1)
	ptr_size++;
  100624:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100627:	83 c0 01             	add    $0x1,%eax
  10062a:	89 45 bc             	mov    %eax,-0x44(%rbp)
	count++;
  10062d:	41 83 c4 01          	add    $0x1,%r12d
  100631:	4c 89 f7             	mov    %r14,%rdi
  100634:	cd 3a                	int    $0x3a
  100636:	48 89 05 e3 29 00 00 	mov    %rax,0x29e3(%rip)        # 103020 <result.0>
    while((intptr_t)ROUNDUP(sbrk(0), PAGESIZE) <= 0x280000){
  10063d:	48 05 ff 0f 00 00    	add    $0xfff,%rax
  100643:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100649:	48 3d 00 00 28 00    	cmp    $0x280000,%rax
  10064f:	0f 8e 54 ff ff ff    	jle    1005a9 <process_main+0xdb>
    }
	
    _quicksort(ptr, ptr_size, sizeof(ptr[0]), &ptr_comparator);
  100655:	8b 75 bc             	mov    -0x44(%rbp),%esi
  100658:	48 63 f6             	movslq %esi,%rsi
  10065b:	b9 00 00 10 00       	mov    $0x100000,%ecx
  100660:	ba 10 00 00 00       	mov    $0x10,%edx
  100665:	4c 89 ef             	mov    %r13,%rdi
  100668:	e8 9b f9 ff ff       	call   100008 <_quicksort>
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  10066d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  10066f:	48 c1 e2 20          	shl    $0x20,%rdx
  100673:	89 c0                	mov    %eax,%eax
  100675:	48 89 d3             	mov    %rdx,%rbx
  100678:	48 09 c3             	or     %rax,%rbx

    heap_info_struct h;
    register uint64_t time1 = rdtsc(); 
    int ret = heap_info(&h);
  10067b:	48 8d 7d 98          	lea    -0x68(%rbp),%rdi
  10067f:	e8 83 07 00 00       	call   100e07 <heap_info>
  100684:	41 89 c4             	mov    %eax,%r12d
	__asm volatile
  100687:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  100689:	48 c1 e2 20          	shl    $0x20,%rdx
  10068d:	89 c0                	mov    %eax,%eax
  10068f:	48 09 c2             	or     %rax,%rdx
    time1 = rdtsc() - time1;
  100692:	48 29 da             	sub    %rbx,%rdx
    app_printf(0, "time: %ld\n", time1);
  100695:	be 47 20 10 00       	mov    $0x102047,%esi
  10069a:	bf 00 00 00 00       	mov    $0x0,%edi
  10069f:	b8 00 00 00 00       	mov    $0x0,%eax
  1006a4:	e8 dc 00 00 00       	call   100785 <app_printf>

    if(ret){
  1006a9:	45 85 e4             	test   %r12d,%r12d
  1006ac:	75 3b                	jne    1006e9 <process_main+0x21b>
	exit();
    }

    assert(h.num_allocs == ptr_size);
  1006ae:	8b 45 98             	mov    -0x68(%rbp),%eax
  1006b1:	8b 55 bc             	mov    -0x44(%rbp),%edx
  1006b4:	39 d0                	cmp    %edx,%eax
  1006b6:	75 35                	jne    1006ed <process_main+0x21f>

    for(volatile int i = 0 ; i < h.num_allocs ; i++){
  1006b8:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%rbp)
  1006bf:	8b 55 94             	mov    -0x6c(%rbp),%edx
  1006c2:	39 d0                	cmp    %edx,%eax
  1006c4:	7f 76                	jg     10073c <process_main+0x26e>
        assert(i == 0  || h.size_array[i] <= h.size_array[i-1]);
        int r = exists_in_between(ptr, h.ptr_array[i], h.size_array[i], ptr_size);
        assert(r);
    }

    app_printf(0, "HEAP INFO PASS\n");
  1006c6:	be 7d 20 10 00       	mov    $0x10207d,%esi
  1006cb:	bf 00 00 00 00       	mov    $0x0,%edi
  1006d0:	b8 00 00 00 00       	mov    $0x0,%eax
  1006d5:	e8 ab 00 00 00       	call   100785 <app_printf>
    TEST_PASS();
  1006da:	bf 8d 20 10 00       	mov    $0x10208d,%edi
  1006df:	b8 00 00 00 00       	mov    $0x0,%eax
  1006e4:	e8 2c 01 00 00       	call   100815 <kernel_panic>
    asm volatile ("int %0" : /* no result */
  1006e9:	cd 35                	int    $0x35
 spinloop: goto spinloop;       // should never get here
  1006eb:	eb fe                	jmp    1006eb <process_main+0x21d>
    assert(h.num_allocs == ptr_size);
  1006ed:	ba 52 20 10 00       	mov    $0x102052,%edx
  1006f2:	be fc 00 00 00       	mov    $0xfc,%esi
  1006f7:	bf 6b 20 10 00       	mov    $0x10206b,%edi
  1006fc:	e8 e2 01 00 00       	call   1008e3 <assert_fail>
        int r = exists_in_between(ptr, h.ptr_array[i], h.size_array[i], ptr_size);
  100701:	8b 4d bc             	mov    -0x44(%rbp),%ecx
  100704:	8b 55 94             	mov    -0x6c(%rbp),%edx
  100707:	8b 45 94             	mov    -0x6c(%rbp),%eax
  10070a:	48 63 d2             	movslq %edx,%rdx
  10070d:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  100711:	48 8b 14 d6          	mov    (%rsi,%rdx,8),%rdx
  100715:	48 98                	cltq   
  100717:	48 8b 75 a8          	mov    -0x58(%rbp),%rsi
  10071b:	48 8b 34 c6          	mov    (%rsi,%rax,8),%rsi
  10071f:	4c 89 ef             	mov    %r13,%rdi
  100722:	e8 4a fd ff ff       	call   100471 <exists_in_between>
        assert(r);
  100727:	85 c0                	test   %eax,%eax
  100729:	74 46                	je     100771 <process_main+0x2a3>
    for(volatile int i = 0 ; i < h.num_allocs ; i++){
  10072b:	8b 45 94             	mov    -0x6c(%rbp),%eax
  10072e:	83 c0 01             	add    $0x1,%eax
  100731:	89 45 94             	mov    %eax,-0x6c(%rbp)
  100734:	8b 45 94             	mov    -0x6c(%rbp),%eax
  100737:	39 45 98             	cmp    %eax,-0x68(%rbp)
  10073a:	7e 8a                	jle    1006c6 <process_main+0x1f8>
        assert(i == 0  || h.size_array[i] <= h.size_array[i-1]);
  10073c:	8b 45 94             	mov    -0x6c(%rbp),%eax
  10073f:	85 c0                	test   %eax,%eax
  100741:	74 be                	je     100701 <process_main+0x233>
  100743:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  100747:	8b 55 94             	mov    -0x6c(%rbp),%edx
  10074a:	8b 45 94             	mov    -0x6c(%rbp),%eax
  10074d:	48 63 d2             	movslq %edx,%rdx
  100750:	48 98                	cltq   
  100752:	48 8b 44 c1 f8       	mov    -0x8(%rcx,%rax,8),%rax
  100757:	48 39 04 d1          	cmp    %rax,(%rcx,%rdx,8)
  10075b:	7e a4                	jle    100701 <process_main+0x233>
  10075d:	ba a8 20 10 00       	mov    $0x1020a8,%edx
  100762:	be ff 00 00 00       	mov    $0xff,%esi
  100767:	bf 6b 20 10 00       	mov    $0x10206b,%edi
  10076c:	e8 72 01 00 00       	call   1008e3 <assert_fail>
        assert(r);
  100771:	ba 7b 20 10 00       	mov    $0x10207b,%edx
  100776:	be 01 01 00 00       	mov    $0x101,%esi
  10077b:	bf 6b 20 10 00       	mov    $0x10206b,%edi
  100780:	e8 5e 01 00 00       	call   1008e3 <assert_fail>

0000000000100785 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100785:	55                   	push   %rbp
  100786:	48 89 e5             	mov    %rsp,%rbp
  100789:	48 83 ec 50          	sub    $0x50,%rsp
  10078d:	49 89 f2             	mov    %rsi,%r10
  100790:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100794:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100798:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10079c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1007a0:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  1007a5:	85 ff                	test   %edi,%edi
  1007a7:	78 2e                	js     1007d7 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1007a9:	48 63 ff             	movslq %edi,%rdi
  1007ac:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1007b3:	cc cc cc 
  1007b6:	48 89 f8             	mov    %rdi,%rax
  1007b9:	48 f7 e2             	mul    %rdx
  1007bc:	48 89 d0             	mov    %rdx,%rax
  1007bf:	48 c1 e8 02          	shr    $0x2,%rax
  1007c3:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1007c7:	48 01 c2             	add    %rax,%rdx
  1007ca:	48 29 d7             	sub    %rdx,%rdi
  1007cd:	0f b6 b7 0d 21 10 00 	movzbl 0x10210d(%rdi),%esi
  1007d4:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1007d7:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1007de:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1007e2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1007e6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1007ea:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1007ee:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1007f2:	4c 89 d2             	mov    %r10,%rdx
  1007f5:	8b 3d 01 88 fb ff    	mov    -0x477ff(%rip),%edi        # b8ffc <cursorpos>
  1007fb:	e8 10 16 00 00       	call   101e10 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100800:	3d 30 07 00 00       	cmp    $0x730,%eax
  100805:	ba 00 00 00 00       	mov    $0x0,%edx
  10080a:	0f 4d c2             	cmovge %edx,%eax
  10080d:	89 05 e9 87 fb ff    	mov    %eax,-0x47817(%rip)        # b8ffc <cursorpos>
    }
}
  100813:	c9                   	leave  
  100814:	c3                   	ret    

0000000000100815 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100815:	55                   	push   %rbp
  100816:	48 89 e5             	mov    %rsp,%rbp
  100819:	53                   	push   %rbx
  10081a:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100821:	48 89 fb             	mov    %rdi,%rbx
  100824:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100828:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10082c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100830:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100834:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100838:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  10083f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100843:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100847:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10084b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  10084f:	ba 07 00 00 00       	mov    $0x7,%edx
  100854:	be d7 20 10 00       	mov    $0x1020d7,%esi
  100859:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100860:	e8 62 07 00 00       	call   100fc7 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100865:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100869:	48 89 da             	mov    %rbx,%rdx
  10086c:	be 99 00 00 00       	mov    $0x99,%esi
  100871:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100878:	e8 9f 16 00 00       	call   101f1c <vsnprintf>
  10087d:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100880:	85 d2                	test   %edx,%edx
  100882:	7e 0f                	jle    100893 <kernel_panic+0x7e>
  100884:	83 c0 06             	add    $0x6,%eax
  100887:	48 98                	cltq   
  100889:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100890:	0a 
  100891:	75 2a                	jne    1008bd <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100893:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10089a:	48 89 d9             	mov    %rbx,%rcx
  10089d:	ba df 20 10 00       	mov    $0x1020df,%edx
  1008a2:	be 00 c0 00 00       	mov    $0xc000,%esi
  1008a7:	bf 30 07 00 00       	mov    $0x730,%edi
  1008ac:	b8 00 00 00 00       	mov    $0x0,%eax
  1008b1:	e8 c6 15 00 00       	call   101e7c <console_printf>
    asm volatile ("int %0" : /* no result */
  1008b6:	48 89 df             	mov    %rbx,%rdi
  1008b9:	cd 30                	int    $0x30
 loop: goto loop;
  1008bb:	eb fe                	jmp    1008bb <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1008bd:	48 63 c2             	movslq %edx,%rax
  1008c0:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1008c6:	0f 94 c2             	sete   %dl
  1008c9:	0f b6 d2             	movzbl %dl,%edx
  1008cc:	48 29 d0             	sub    %rdx,%rax
  1008cf:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1008d6:	ff 
  1008d7:	be 8b 20 10 00       	mov    $0x10208b,%esi
  1008dc:	e8 93 08 00 00       	call   101174 <strcpy>
  1008e1:	eb b0                	jmp    100893 <kernel_panic+0x7e>

00000000001008e3 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1008e3:	55                   	push   %rbp
  1008e4:	48 89 e5             	mov    %rsp,%rbp
  1008e7:	48 89 f9             	mov    %rdi,%rcx
  1008ea:	41 89 f0             	mov    %esi,%r8d
  1008ed:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1008f0:	ba e8 20 10 00       	mov    $0x1020e8,%edx
  1008f5:	be 00 c0 00 00       	mov    $0xc000,%esi
  1008fa:	bf 30 07 00 00       	mov    $0x730,%edi
  1008ff:	b8 00 00 00 00       	mov    $0x0,%eax
  100904:	e8 73 15 00 00       	call   101e7c <console_printf>
    asm volatile ("int %0" : /* no result */
  100909:	bf 00 00 00 00       	mov    $0x0,%edi
  10090e:	cd 30                	int    $0x30
 loop: goto loop;
  100910:	eb fe                	jmp    100910 <assert_fail+0x2d>

0000000000100912 <push_free_block>:

// Adds a free memory block to the beginning of the free list
void push_free_block(header* free_block)
{
    // List is not empty
    if (free_list != NULL)
  100912:	48 8b 05 2f 27 00 00 	mov    0x272f(%rip),%rax        # 103048 <free_list>
  100919:	48 85 c0             	test   %rax,%rax
  10091c:	74 1e                	je     10093c <push_free_block+0x2a>
    {
        // Remember old list head
        header* old_head = free_list;
        // Attach new free block as list head
        free_block->next = old_head;
  10091e:	48 89 07             	mov    %rax,(%rdi)
        old_head->prev = free_block;
  100921:	48 89 78 08          	mov    %rdi,0x8(%rax)
        free_block->prev = NULL;
  100925:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10092c:	00 
        free_list = free_block;
  10092d:	48 89 3d 14 27 00 00 	mov    %rdi,0x2714(%rip)        # 103048 <free_list>
        free_list = free_block;
        free_block->prev = NULL;
        free_block->next = NULL;
    }
    // Reset "alloc" flag to 0 (free)
    free_block->alloc = 0;
  100934:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
}
  10093b:	c3                   	ret    
        free_list = free_block;
  10093c:	48 89 3d 05 27 00 00 	mov    %rdi,0x2705(%rip)        # 103048 <free_list>
        free_block->prev = NULL;
  100943:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  10094a:	00 
        free_block->next = NULL;
  10094b:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
  100952:	eb e0                	jmp    100934 <push_free_block+0x22>

0000000000100954 <push_malloc_block>:

// Push an allocated memory block to top of the malloc_list
void push_malloc_block(header* malloc_block)
{
    // List is not empty
    if (malloc_list != NULL)
  100954:	48 8b 05 d5 26 00 00 	mov    0x26d5(%rip),%rax        # 103030 <malloc_list>
  10095b:	48 85 c0             	test   %rax,%rax
  10095e:	74 04                	je     100964 <push_malloc_block+0x10>
    {
        // Remember old list head
        header* old_head = malloc_list;
        // Attach new free block as list head
        malloc_block->next_alloc_block = old_head;
  100960:	48 89 47 20          	mov    %rax,0x20(%rdi)
        malloc_list = malloc_block;
  100964:	48 89 3d c5 26 00 00 	mov    %rdi,0x26c5(%rip)        # 103030 <malloc_list>
    }
    else
    {
        malloc_list = malloc_block;
    }
}
  10096b:	c3                   	ret    

000000000010096c <find_free_block>:

// [First-fit strategy] Finds a free memory block suitable to hold sz + sizeof(header)
header* find_free_block(uint64_t sz){
    header* temp = free_list;
  10096c:	48 8b 05 d5 26 00 00 	mov    0x26d5(%rip),%rax        # 103048 <free_list>
    while (temp != NULL)
  100973:	48 85 c0             	test   %rax,%rax
  100976:	74 0e                	je     100986 <find_free_block+0x1a>
    {
        if (temp->size >= sz)
  100978:	48 39 78 10          	cmp    %rdi,0x10(%rax)
  10097c:	73 08                	jae    100986 <find_free_block+0x1a>
        {
            return temp;
        }
        // Move to next memory block
        temp = temp->next;
  10097e:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  100981:	48 85 c0             	test   %rax,%rax
  100984:	75 f2                	jne    100978 <find_free_block+0xc>
    }
    return NULL;
}
  100986:	c3                   	ret    

0000000000100987 <reconnect_free_list>:

// Reconnect free_list after a free block is partitioned
void reconnect_free_list(header* old_free_block)
{
    // Free block on both ends
    if(old_free_block->prev != NULL && old_free_block->next != NULL)
  100987:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10098b:	48 85 c0             	test   %rax,%rax
  10098e:	74 14                	je     1009a4 <reconnect_free_list+0x1d>
  100990:	48 8b 17             	mov    (%rdi),%rdx
  100993:	48 85 d2             	test   %rdx,%rdx
  100996:	74 24                	je     1009bc <reconnect_free_list+0x35>
    {
        old_free_block->prev->next = old_free_block->next;
  100998:	48 89 10             	mov    %rdx,(%rax)
        old_free_block->next->prev = old_free_block->prev;
  10099b:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10099f:	48 89 42 08          	mov    %rax,0x8(%rdx)
  1009a3:	c3                   	ret    
    }
    // First block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next != NULL)
  1009a4:	48 8b 07             	mov    (%rdi),%rax
  1009a7:	48 85 c0             	test   %rax,%rax
  1009aa:	74 18                	je     1009c4 <reconnect_free_list+0x3d>
    {
        free_list = old_free_block->next;
  1009ac:	48 89 05 95 26 00 00 	mov    %rax,0x2695(%rip)        # 103048 <free_list>
        old_free_block->next->prev = NULL;
  1009b3:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  1009ba:	00 
  1009bb:	c3                   	ret    
    }
    // Last block on free_list
    else if(old_free_block->prev != NULL && old_free_block->next == NULL)
    {
        old_free_block->prev->next = NULL;
  1009bc:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  1009c3:	c3                   	ret    
    }
    // Only block on free_list
    else if(old_free_block->prev == NULL && old_free_block->next == NULL)
    {
        free_list = NULL;
  1009c4:	48 c7 05 79 26 00 00 	movq   $0x0,0x2679(%rip)        # 103048 <free_list>
  1009cb:	00 00 00 00 
    }
}
  1009cf:	c3                   	ret    

00000000001009d0 <block_init>:

// Initialize header of a memory block that's about to be returned to user
void block_init(header* free_block)
{
    free_block->next = NULL;
  1009d0:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    free_block->prev = NULL;
  1009d7:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  1009de:	00 
    free_block->next_alloc_block = NULL;
  1009df:	48 c7 47 20 00 00 00 	movq   $0x0,0x20(%rdi)
  1009e6:	00 
    free_block->alloc = 1;
  1009e7:	c7 47 18 01 00 00 00 	movl   $0x1,0x18(%rdi)
}
  1009ee:	c3                   	ret    

00000000001009ef <set_canary>:

/**
 * Set canary value in an allocated memory block
 * @mem_block assumed to be pointer to mem_block header
*/
void set_canary(intptr_t mem_block){
  1009ef:	55                   	push   %rbp
  1009f0:	48 89 e5             	mov    %rsp,%rbp
    // Get canary location
    intptr_t block_size = (intptr_t)(((header*) mem_block)->size);
    intptr_t canary_location = mem_block + block_size - ((intptr_t)(sizeof(canary_value)));
  1009f3:	48 03 7f 10          	add    0x10(%rdi),%rdi
  1009f7:	48 83 ef 08          	sub    $0x8,%rdi
    // Set canary value
    memcpy(((void*)canary_location), &canary_value, sizeof(canary_value));
  1009fb:	ba 08 00 00 00       	mov    $0x8,%edx
  100a00:	be 00 30 10 00       	mov    $0x103000,%esi
  100a05:	e8 bd 05 00 00       	call   100fc7 <memcpy>
}
  100a0a:	5d                   	pop    %rbp
  100a0b:	c3                   	ret    

0000000000100a0c <check_canary>:
/**
 * Ensure overflow canary is intact
 * @memblock assumed to be a pointer to mem_block payload
*/
int check_canary(intptr_t mem_block)
{
  100a0c:	55                   	push   %rbp
  100a0d:	48 89 e5             	mov    %rsp,%rbp
  100a10:	48 83 ec 10          	sub    $0x10,%rsp
    // Get canary location
    header* head = (header*)(mem_block - ((intptr_t) HEADER_SIZE));
    intptr_t block_size = (intptr_t)(head->size);
    intptr_t canary_location = (intptr_t)head + block_size - ((intptr_t)(sizeof(canary_value)));
  100a14:	48 03 7f e8          	add    -0x18(%rdi),%rdi
  100a18:	48 8d 77 d0          	lea    -0x30(%rdi),%rsi
    // Compare canary value
    size_t overflow_canary;
    memcpy(&overflow_canary, ((void*) canary_location), sizeof(canary_value));
  100a1c:	ba 08 00 00 00       	mov    $0x8,%edx
  100a21:	48 8d 7d f8          	lea    -0x8(%rbp),%rdi
  100a25:	e8 9d 05 00 00       	call   100fc7 <memcpy>
    if(canary_value != overflow_canary)
  100a2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a2e:	48 39 05 cb 25 00 00 	cmp    %rax,0x25cb(%rip)        # 103000 <canary_value>
  100a35:	0f 94 c0             	sete   %al
  100a38:	0f b6 c0             	movzbl %al,%eax
    {
        return 0;
    }

    return 1;
}
  100a3b:	c9                   	leave  
  100a3c:	c3                   	ret    

0000000000100a3d <merge>:

// Merge two sorted sub arrays
void merge(header** ptr_array, header* left_array[], int left_size, header* right_array[], int right_size)
{
  100a3d:	55                   	push   %rbp
  100a3e:	48 89 e5             	mov    %rsp,%rbp
  100a41:	41 55                	push   %r13
  100a43:	41 54                	push   %r12
  100a45:	53                   	push   %rbx
  100a46:	48 89 f3             	mov    %rsi,%rbx
  100a49:	41 89 d1             	mov    %edx,%r9d
  100a4c:	49 89 ca             	mov    %rcx,%r10
    int i = 0, j = 0, k = 0;
    while (i < left_size && j < right_size)
  100a4f:	85 d2                	test   %edx,%edx
  100a51:	7e 57                	jle    100aaa <merge+0x6d>
  100a53:	45 85 c0             	test   %r8d,%r8d
  100a56:	7e 52                	jle    100aaa <merge+0x6d>
  100a58:	48 89 fe             	mov    %rdi,%rsi
  100a5b:	b9 01 00 00 00       	mov    $0x1,%ecx
    int i = 0, j = 0, k = 0;
  100a60:	ba 00 00 00 00       	mov    $0x0,%edx
  100a65:	b8 00 00 00 00       	mov    $0x0,%eax
  100a6a:	eb 1a                	jmp    100a86 <merge+0x49>
        {
            ptr_array[k++] = right_array[j++];
        }
        else
        {
            ptr_array[k++] = left_array[i++];
  100a6c:	83 c0 01             	add    $0x1,%eax
  100a6f:	41 89 cb             	mov    %ecx,%r11d
  100a72:	4c 89 26             	mov    %r12,(%rsi)
    while (i < left_size && j < right_size)
  100a75:	83 c1 01             	add    $0x1,%ecx
  100a78:	48 83 c6 08          	add    $0x8,%rsi
  100a7c:	44 39 c8             	cmp    %r9d,%eax
  100a7f:	7d 39                	jge    100aba <merge+0x7d>
  100a81:	44 39 c2             	cmp    %r8d,%edx
  100a84:	7d 34                	jge    100aba <merge+0x7d>
        if (left_array[i]->size < right_array[j]->size)
  100a86:	4c 63 d8             	movslq %eax,%r11
  100a89:	4e 8b 24 db          	mov    (%rbx,%r11,8),%r12
  100a8d:	4c 63 da             	movslq %edx,%r11
  100a90:	4f 8b 2c da          	mov    (%r10,%r11,8),%r13
  100a94:	4d 8b 5d 10          	mov    0x10(%r13),%r11
  100a98:	4d 39 5c 24 10       	cmp    %r11,0x10(%r12)
  100a9d:	73 cd                	jae    100a6c <merge+0x2f>
            ptr_array[k++] = right_array[j++];
  100a9f:	83 c2 01             	add    $0x1,%edx
  100aa2:	41 89 cb             	mov    %ecx,%r11d
  100aa5:	4c 89 2e             	mov    %r13,(%rsi)
  100aa8:	eb cb                	jmp    100a75 <merge+0x38>
    int i = 0, j = 0, k = 0;
  100aaa:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  100ab0:	ba 00 00 00 00       	mov    $0x0,%edx
  100ab5:	b8 00 00 00 00       	mov    $0x0,%eax
        }
    }
    while (i < left_size)
  100aba:	41 39 c1             	cmp    %eax,%r9d
  100abd:	7e 39                	jle    100af8 <merge+0xbb>
  100abf:	41 89 c4             	mov    %eax,%r12d
  100ac2:	44 89 ce             	mov    %r9d,%esi
  100ac5:	29 c6                	sub    %eax,%esi
  100ac7:	48 c1 e6 03          	shl    $0x3,%rsi
  100acb:	48 98                	cltq   
  100acd:	4c 8d 2c c3          	lea    (%rbx,%rax,8),%r13
  100ad1:	49 63 c3             	movslq %r11d,%rax
  100ad4:	48 8d 1c c7          	lea    (%rdi,%rax,8),%rbx
  100ad8:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = left_array[i++];
  100add:	49 8b 4c 05 00       	mov    0x0(%r13,%rax,1),%rcx
  100ae2:	48 89 0c 03          	mov    %rcx,(%rbx,%rax,1)
    while (i < left_size)
  100ae6:	48 83 c0 08          	add    $0x8,%rax
  100aea:	48 39 f0             	cmp    %rsi,%rax
  100aed:	75 ee                	jne    100add <merge+0xa0>
  100aef:	45 01 d9             	add    %r11d,%r9d
        ptr_array[k++] = left_array[i++];
  100af2:	45 29 e1             	sub    %r12d,%r9d
  100af5:	45 89 cb             	mov    %r9d,%r11d

    }
    while (j < right_size)
  100af8:	41 39 d0             	cmp    %edx,%r8d
  100afb:	7e 2b                	jle    100b28 <merge+0xeb>
  100afd:	41 29 d0             	sub    %edx,%r8d
  100b00:	49 c1 e0 03          	shl    $0x3,%r8
  100b04:	48 63 d2             	movslq %edx,%rdx
  100b07:	49 8d 34 d2          	lea    (%r10,%rdx,8),%rsi
  100b0b:	4d 63 db             	movslq %r11d,%r11
  100b0e:	4a 8d 0c df          	lea    (%rdi,%r11,8),%rcx
  100b12:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        ptr_array[k++] = right_array[j++];
  100b17:	48 8b 14 06          	mov    (%rsi,%rax,1),%rdx
  100b1b:	48 89 14 01          	mov    %rdx,(%rcx,%rax,1)
    while (j < right_size)
  100b1f:	48 83 c0 08          	add    $0x8,%rax
  100b23:	4c 39 c0             	cmp    %r8,%rax
  100b26:	75 ef                	jne    100b17 <merge+0xda>
    }
    
}
  100b28:	5b                   	pop    %rbx
  100b29:	41 5c                	pop    %r12
  100b2b:	41 5d                	pop    %r13
  100b2d:	5d                   	pop    %rbp
  100b2e:	c3                   	ret    

0000000000100b2f <merge_sort>:

// Merge sort function
void merge_sort(header** ptr_array, int size)
{
  100b2f:	55                   	push   %rbp
  100b30:	48 89 e5             	mov    %rsp,%rbp
  100b33:	41 57                	push   %r15
  100b35:	41 56                	push   %r14
  100b37:	41 55                	push   %r13
  100b39:	41 54                	push   %r12
  100b3b:	53                   	push   %rbx
  100b3c:	48 83 ec 18          	sub    $0x18,%rsp
  100b40:	48 89 fb             	mov    %rdi,%rbx
  100b43:	48 89 e7             	mov    %rsp,%rdi
    // Base case
    if (size < 2)
  100b46:	83 fe 01             	cmp    $0x1,%esi
  100b49:	0f 8e d4 00 00 00    	jle    100c23 <merge_sort+0xf4>
    {
        return;
    }
    int middle = size/2;
  100b4f:	41 89 f6             	mov    %esi,%r14d
  100b52:	41 c1 ee 1f          	shr    $0x1f,%r14d
  100b56:	41 01 f6             	add    %esi,%r14d
  100b59:	41 d1 fe             	sar    %r14d
    header* left_array[middle];
  100b5c:	49 63 ce             	movslq %r14d,%rcx
  100b5f:	48 c1 e1 03          	shl    $0x3,%rcx
  100b63:	41 b8 10 00 00 00    	mov    $0x10,%r8d
  100b69:	48 8d 41 0f          	lea    0xf(%rcx),%rax
  100b6d:	ba 00 00 00 00       	mov    $0x0,%edx
  100b72:	49 f7 f0             	div    %r8
  100b75:	48 c1 e0 04          	shl    $0x4,%rax
  100b79:	48 29 c4             	sub    %rax,%rsp
  100b7c:	49 89 e4             	mov    %rsp,%r12
    header* right_array[size - middle];
  100b7f:	41 89 f7             	mov    %esi,%r15d
  100b82:	45 29 f7             	sub    %r14d,%r15d
  100b85:	49 63 c7             	movslq %r15d,%rax
  100b88:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
  100b8f:	00 
  100b90:	ba 00 00 00 00       	mov    $0x0,%edx
  100b95:	49 f7 f0             	div    %r8
  100b98:	48 c1 e0 04          	shl    $0x4,%rax
  100b9c:	48 29 c4             	sub    %rax,%rsp
  100b9f:	49 89 e5             	mov    %rsp,%r13
  100ba2:	b8 00 00 00 00       	mov    $0x0,%eax
    // Populate left and right sub-arrays
    for (int i = 0; i < middle; i++)
    {
        left_array[i] = ptr_array[i];
  100ba7:	48 8b 14 03          	mov    (%rbx,%rax,1),%rdx
  100bab:	49 89 14 04          	mov    %rdx,(%r12,%rax,1)
    for (int i = 0; i < middle; i++)
  100baf:	48 83 c0 08          	add    $0x8,%rax
  100bb3:	48 39 c1             	cmp    %rax,%rcx
  100bb6:	75 ef                	jne    100ba7 <merge_sort+0x78>
    }
    for (int j = middle; j < size; j++)
  100bb8:	44 39 f6             	cmp    %r14d,%esi
  100bbb:	7e 25                	jle    100be2 <merge_sort+0xb3>
  100bbd:	44 29 f6             	sub    %r14d,%esi
  100bc0:	48 8d 14 f5 00 00 00 	lea    0x0(,%rsi,8),%rdx
  100bc7:	00 
  100bc8:	48 01 d9             	add    %rbx,%rcx
  100bcb:	b8 00 00 00 00       	mov    $0x0,%eax
    {
        right_array[j - middle] = ptr_array[j];
  100bd0:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  100bd4:	49 89 74 05 00       	mov    %rsi,0x0(%r13,%rax,1)
    for (int j = middle; j < size; j++)
  100bd9:	48 83 c0 08          	add    $0x8,%rax
  100bdd:	48 39 d0             	cmp    %rdx,%rax
  100be0:	75 ee                	jne    100bd0 <merge_sort+0xa1>
  100be2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    }
    // Recursively sort left and right sub-arrays
    merge_sort(left_array, middle);
  100be6:	44 89 f6             	mov    %r14d,%esi
  100be9:	4c 89 e7             	mov    %r12,%rdi
  100bec:	e8 3e ff ff ff       	call   100b2f <merge_sort>
    merge_sort(right_array, (size - middle));
  100bf1:	44 89 fe             	mov    %r15d,%esi
  100bf4:	4c 89 ef             	mov    %r13,%rdi
  100bf7:	e8 33 ff ff ff       	call   100b2f <merge_sort>
    // Merge sorted sub-arrays back to original array
    merge(ptr_array, left_array, middle, right_array, (size - middle));
  100bfc:	45 89 f8             	mov    %r15d,%r8d
  100bff:	4c 89 e9             	mov    %r13,%rcx
  100c02:	44 89 f2             	mov    %r14d,%edx
  100c05:	4c 89 e6             	mov    %r12,%rsi
  100c08:	48 89 df             	mov    %rbx,%rdi
  100c0b:	e8 2d fe ff ff       	call   100a3d <merge>
  100c10:	48 8b 65 c8          	mov    -0x38(%rbp),%rsp
}
  100c14:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  100c18:	5b                   	pop    %rbx
  100c19:	41 5c                	pop    %r12
  100c1b:	41 5d                	pop    %r13
  100c1d:	41 5e                	pop    %r14
  100c1f:	41 5f                	pop    %r15
  100c21:	5d                   	pop    %rbp
  100c22:	c3                   	ret    
        return;
  100c23:	48 89 fc             	mov    %rdi,%rsp
  100c26:	eb ec                	jmp    100c14 <merge_sort+0xe5>

0000000000100c28 <free>:
// by a previous call to malloc or realloc, or if free has already been called before, then
// undefined behavior occurs
// if ptr == NULL, then no operation happens
void free(void *firstbyte) {
    // Corner cases: NULL pointer passed
    if (firstbyte == NULL)
  100c28:	48 85 ff             	test   %rdi,%rdi
  100c2b:	74 2a                	je     100c57 <free+0x2f>
void free(void *firstbyte) {
  100c2d:	55                   	push   %rbp
  100c2e:	48 89 e5             	mov    %rsp,%rbp
  100c31:	53                   	push   %rbx
  100c32:	48 83 ec 08          	sub    $0x8,%rsp
    {
        return;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) firstbyte) - ((intptr_t)HEADER_SIZE));
  100c36:	48 8d 5f d8          	lea    -0x28(%rdi),%rbx
    // Ensure memory block was previously allocated
    if(head->alloc == 1)
  100c3a:	83 7f f0 01          	cmpl   $0x1,-0x10(%rdi)
  100c3e:	74 06                	je     100c46 <free+0x1e>
        // Push memory block into free_list
        push_free_block(head);
        head->alloc = 0;
    }
    return;
}
  100c40:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100c44:	c9                   	leave  
  100c45:	c3                   	ret    
        push_free_block(head);
  100c46:	48 89 df             	mov    %rbx,%rdi
  100c49:	e8 c4 fc ff ff       	call   100912 <push_free_block>
        head->alloc = 0;
  100c4e:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
  100c55:	eb e9                	jmp    100c40 <free+0x18>
  100c57:	c3                   	ret    

0000000000100c58 <malloc>:
// malloc(sz):
// allocates sz bytes of uninitialized memory and returns a pointer to the allocated memory
// if sz == 0, then malloc() either returns NULL or a unique pointer value that can be
// successfully passed to a later free
// the pointer should be aligned to 8 bytes
void *malloc(uint64_t numbytes) {
  100c58:	55                   	push   %rbp
  100c59:	48 89 e5             	mov    %rsp,%rbp
  100c5c:	41 54                	push   %r12
  100c5e:	53                   	push   %rbx
    // Coner case
    if (numbytes == 0)
    {
        return NULL;
  100c5f:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0)
  100c64:	48 85 ff             	test   %rdi,%rdi
  100c67:	0f 84 d9 00 00 00    	je     100d46 <malloc+0xee>
    }
    // Compute size of memory to allocate
    uint64_t mem_alloc = (uint64_t)(((intptr_t) numbytes) + ((intptr_t) HEADER_SIZE) + ((intptr_t) sizeof(canary_value)));
  100c6d:	4c 8d 67 30          	lea    0x30(%rdi),%r12
    // Search for a suitable memory block to assign
    header* free_block = find_free_block(mem_alloc);
  100c71:	4c 89 e7             	mov    %r12,%rdi
  100c74:	e8 f3 fc ff ff       	call   10096c <find_free_block>
  100c79:	48 89 c3             	mov    %rax,%rbx
    // Initial malloc: free_list is empty
    if (free_block  == NULL)
  100c7c:	48 85 c0             	test   %rax,%rax
  100c7f:	74 6b                	je     100cec <malloc+0x94>
        free_block = ((header*) ret);
    }
    else
    {
        // Remove block from free_list
        reconnect_free_list(free_block);
  100c81:	48 89 c7             	mov    %rax,%rdi
  100c84:	e8 fe fc ff ff       	call   100987 <reconnect_free_list>
    }
    // Partition NOT required
    if ((free_block->size - mem_alloc) <= HEADER_SIZE)
  100c89:	48 8b 43 10          	mov    0x10(%rbx),%rax
  100c8d:	4c 29 e0             	sub    %r12,%rax
  100c90:	48 83 f8 28          	cmp    $0x28,%rax
  100c94:	76 7e                	jbe    100d14 <malloc+0xbc>
    }
    // Partition required
    else
    {
        // Resize the orginal "free block" header 
        intptr_t new_free_block = (((intptr_t) free_block) + mem_alloc);
  100c96:	4a 8d 14 23          	lea    (%rbx,%r12,1),%rdx
        // Ensure "new_free_block" is page-aligned
        header* new_free_block_align = (header*)(ALIGN(new_free_block));
  100c9a:	48 8d 7a 07          	lea    0x7(%rdx),%rdi
  100c9e:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
        // Update size of new_free_block
        uint64_t new_free_block_align_size = free_block->size - mem_alloc - (((intptr_t)new_free_block_align) - new_free_block);
  100ca2:	48 89 f9             	mov    %rdi,%rcx
  100ca5:	48 29 d1             	sub    %rdx,%rcx
  100ca8:	48 29 c8             	sub    %rcx,%rax
  100cab:	48 89 47 10          	mov    %rax,0x10(%rdi)
    free_block->next = NULL;
  100caf:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  100cb6:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100cbd:	00 
    free_block->next_alloc_block = NULL;
  100cbe:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  100cc5:	00 
    free_block->alloc = 1;
  100cc6:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        new_free_block_align->size = new_free_block_align_size;
        // Update assigned "free block" (to be returned)
        block_init(free_block);
        // Push "new_free_block"
        push_free_block(new_free_block_align);
  100ccd:	e8 40 fc ff ff       	call   100912 <push_free_block>
        free_block->size = mem_alloc;
  100cd2:	4c 89 63 10          	mov    %r12,0x10(%rbx)
        // Set canary value
        set_canary((intptr_t) free_block);
  100cd6:	48 89 df             	mov    %rbx,%rdi
  100cd9:	e8 11 fd ff ff       	call   1009ef <set_canary>
        // Add block to malloc_list
        push_malloc_block(free_block);
  100cde:	48 89 df             	mov    %rbx,%rdi
  100ce1:	e8 6e fc ff ff       	call   100954 <push_malloc_block>
        // Get payload pointer
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  100ce6:	48 83 c3 28          	add    $0x28,%rbx

        
        return ret;
  100cea:	eb 5a                	jmp    100d46 <malloc+0xee>
    asm volatile ("int %1" :  "=a" (result)
  100cec:	4c 89 e7             	mov    %r12,%rdi
  100cef:	cd 3a                	int    $0x3a
  100cf1:	48 89 05 48 23 00 00 	mov    %rax,0x2348(%rip)        # 103040 <result.0>
        if (ret == ((void*)-1))
  100cf8:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100cfc:	74 48                	je     100d46 <malloc+0xee>
        ret = (void*)(ALIGN((intptr_t)ret));
  100cfe:	48 83 c0 07          	add    $0x7,%rax
  100d02:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100d06:	48 89 c3             	mov    %rax,%rbx
        program_break = ret;
  100d09:	48 89 05 28 23 00 00 	mov    %rax,0x2328(%rip)        # 103038 <program_break>
        ((header*) ret)->size = mem_alloc;
  100d10:	4c 89 60 10          	mov    %r12,0x10(%rax)
    free_block->next = NULL;
  100d14:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    free_block->prev = NULL;
  100d1b:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  100d22:	00 
    free_block->next_alloc_block = NULL;
  100d23:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  100d2a:	00 
    free_block->alloc = 1;
  100d2b:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
        set_canary((intptr_t) free_block);
  100d32:	48 89 df             	mov    %rbx,%rdi
  100d35:	e8 b5 fc ff ff       	call   1009ef <set_canary>
        push_malloc_block(free_block);
  100d3a:	48 89 df             	mov    %rbx,%rdi
  100d3d:	e8 12 fc ff ff       	call   100954 <push_malloc_block>
        void* ret = (void*)(((intptr_t) free_block) + ((intptr_t) HEADER_SIZE));
  100d42:	48 83 c3 28          	add    $0x28,%rbx
    }
    return NULL;
}
  100d46:	48 89 d8             	mov    %rbx,%rax
  100d49:	5b                   	pop    %rbx
  100d4a:	41 5c                	pop    %r12
  100d4c:	5d                   	pop    %rbp
  100d4d:	c3                   	ret    

0000000000100d4e <calloc>:
// allocates memory of an array of num elements of size sz bytes each and returns a pointer 
// to the allocated array. The memory is set to 0. if num or sz is equal to 0, then calloc
// returns NULL or a unique pointer value that can be successfully passed to a later free
// calloc also checks for size overflow caused by num*sz
// returns NULL on failure
void * calloc(uint64_t num, uint64_t sz) {
  100d4e:	55                   	push   %rbp
  100d4f:	48 89 e5             	mov    %rsp,%rbp
  100d52:	41 54                	push   %r12
  100d54:	53                   	push   %rbx
    // Calculate total memory to be allocated
    uint64_t total_memory = num * sz;
  100d55:	48 0f af fe          	imul   %rsi,%rdi
  100d59:	49 89 fc             	mov    %rdi,%r12
    // Request for memory
    void* new_memory_block = malloc(total_memory);
  100d5c:	e8 f7 fe ff ff       	call   100c58 <malloc>
  100d61:	48 89 c3             	mov    %rax,%rbx
    // Error while allocating memory
    if (new_memory_block == NULL)
  100d64:	48 85 c0             	test   %rax,%rax
  100d67:	74 23                	je     100d8c <calloc+0x3e>
        return NULL;
    }
    // Get header of memory block
    header* head = (header*)(((intptr_t) new_memory_block) - ((intptr_t) HEADER_SIZE));
    // Zero out the memory
    memset(new_memory_block, 0, ((size_t)total_memory));
  100d69:	4c 89 e2             	mov    %r12,%rdx
  100d6c:	be 00 00 00 00       	mov    $0x0,%esi
  100d71:	48 89 c7             	mov    %rax,%rdi
  100d74:	e8 4c 03 00 00       	call   1010c5 <memset>
    // Check for overflow***
    if(check_canary((intptr_t) new_memory_block) == 0)
  100d79:	48 89 df             	mov    %rbx,%rdi
  100d7c:	e8 8b fc ff ff       	call   100a0c <check_canary>
    {
        // free memory that was malloc'd
        return NULL;
  100d81:	85 c0                	test   %eax,%eax
  100d83:	b8 00 00 00 00       	mov    $0x0,%eax
  100d88:	48 0f 44 d8          	cmove  %rax,%rbx
    }
    return new_memory_block;
}
  100d8c:	48 89 d8             	mov    %rbx,%rax
  100d8f:	5b                   	pop    %rbx
  100d90:	41 5c                	pop    %r12
  100d92:	5d                   	pop    %rbp
  100d93:	c3                   	ret    

0000000000100d94 <realloc>:
// if the new size is larger than the old size, the added memory will not be initialized
// if ptr is NULL, then the call is equivalent to malloc(size) for all values of size
// if size is equal to zero, and ptr is not NULL, then the call is equivalent to free(ptr)
// unless ptr is NULL, it must have been returned by an earlier call to malloc(), or realloc().
// if the area pointed to was moved, a free(ptr) is done.
void * realloc(void * ptr, uint64_t sz) {
  100d94:	55                   	push   %rbp
  100d95:	48 89 e5             	mov    %rsp,%rbp
  100d98:	41 55                	push   %r13
  100d9a:	41 54                	push   %r12
  100d9c:	53                   	push   %rbx
  100d9d:	48 83 ec 08          	sub    $0x8,%rsp
  100da1:	48 89 fb             	mov    %rdi,%rbx
  100da4:	48 89 f7             	mov    %rsi,%rdi
    // Corner case: ptr is NULL, ptr provided but sz is 0
    if (ptr == NULL)
  100da7:	48 85 db             	test   %rbx,%rbx
  100daa:	74 38                	je     100de4 <realloc+0x50>
    {
        return malloc(sz);
    }
    if (ptr && (sz == 0))
  100dac:	48 85 f6             	test   %rsi,%rsi
  100daf:	74 3d                	je     100dee <realloc+0x5a>
    }
    // Get head of memory block
    header* head = (header*)(((intptr_t) ptr) - ((intptr_t) HEADER_SIZE));
    
    // Allocate new, larger/smaller memory
    void* ret = malloc(sz);
  100db1:	e8 a2 fe ff ff       	call   100c58 <malloc>
  100db6:	49 89 c4             	mov    %rax,%r12
    if (ret == ((void*) -1))
  100db9:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100dbd:	74 3f                	je     100dfe <realloc+0x6a>
    {
        // Error while allocating new memory block
        return NULL;
    }
    // Transfer data from old mem block to new mem block
    memcpy(ret, ptr, ((size_t) head->size));
  100dbf:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  100dc3:	48 89 de             	mov    %rbx,%rsi
  100dc6:	48 89 c7             	mov    %rax,%rdi
  100dc9:	e8 f9 01 00 00       	call   100fc7 <memcpy>
    // Push old block to free_list
    free((header*) ptr);
  100dce:	48 89 df             	mov    %rbx,%rdi
  100dd1:	e8 52 fe ff ff       	call   100c28 <free>
        
    return ret;
}
  100dd6:	4c 89 e0             	mov    %r12,%rax
  100dd9:	48 83 c4 08          	add    $0x8,%rsp
  100ddd:	5b                   	pop    %rbx
  100dde:	41 5c                	pop    %r12
  100de0:	41 5d                	pop    %r13
  100de2:	5d                   	pop    %rbp
  100de3:	c3                   	ret    
        return malloc(sz);
  100de4:	e8 6f fe ff ff       	call   100c58 <malloc>
  100de9:	49 89 c4             	mov    %rax,%r12
  100dec:	eb e8                	jmp    100dd6 <realloc+0x42>
        free(ptr);
  100dee:	48 89 df             	mov    %rbx,%rdi
  100df1:	e8 32 fe ff ff       	call   100c28 <free>
        return NULL;
  100df6:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100dfc:	eb d8                	jmp    100dd6 <realloc+0x42>
        return NULL;
  100dfe:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100e04:	eb d0                	jmp    100dd6 <realloc+0x42>

0000000000100e06 <defrag>:
 * 3. Merge with left block if it's free
 * 4. Merge with both left and right blocks if both are free
*/
void defrag() {

}
  100e06:	c3                   	ret    

0000000000100e07 <heap_info>:
// the user, i.e. the process will be responsible for freeing these allocations
// note that the allocations used by the heap_info_struct will count as metadata
// and should NOT be included in the heap info
// return 0 for a successfull call
// if for any reason the information cannot be saved, return -1
int heap_info(heap_info_struct * info) {
  100e07:	55                   	push   %rbp
  100e08:	48 89 e5             	mov    %rsp,%rbp
  100e0b:	41 57                	push   %r15
  100e0d:	41 56                	push   %r14
  100e0f:	41 55                	push   %r13
  100e11:	41 54                	push   %r12
  100e13:	53                   	push   %rbx
  100e14:	48 83 ec 18          	sub    $0x18,%rsp
  100e18:	49 89 ff             	mov    %rdi,%r15
    int debug = 0;
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
    // Find "largest_free_chunk", "free_space" from free_list
    header* temp = free_list;
  100e1b:	48 8b 05 26 22 00 00 	mov    0x2226(%rip),%rax        # 103048 <free_list>
    while (temp != NULL)
  100e22:	48 85 c0             	test   %rax,%rax
  100e25:	74 2f                	je     100e56 <heap_info+0x4f>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  100e27:	41 be 00 00 00 00    	mov    $0x0,%r14d
  100e2d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100e33:	eb 08                	jmp    100e3d <heap_info+0x36>
            if (temp->size > ((uint64_t)largest_free_chunk))
            {
                largest_free_chunk = temp->size;
            }
        }
        temp = temp->next;
  100e35:	48 8b 00             	mov    (%rax),%rax
    while (temp != NULL)
  100e38:	48 85 c0             	test   %rax,%rax
  100e3b:	74 25                	je     100e62 <heap_info+0x5b>
        if (temp->alloc == 0)
  100e3d:	83 78 18 00          	cmpl   $0x0,0x18(%rax)
  100e41:	75 f2                	jne    100e35 <heap_info+0x2e>
            free_space += temp->size;
  100e43:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e47:	41 01 d6             	add    %edx,%r14d
            if (temp->size > ((uint64_t)largest_free_chunk))
  100e4a:	49 63 cd             	movslq %r13d,%rcx
                largest_free_chunk = temp->size;
  100e4d:	48 39 d1             	cmp    %rdx,%rcx
  100e50:	44 0f 42 ea          	cmovb  %edx,%r13d
  100e54:	eb df                	jmp    100e35 <heap_info+0x2e>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  100e56:	41 be 00 00 00 00    	mov    $0x0,%r14d
  100e5c:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    }
    // Find "num_allocs" from malloc_list
    temp = malloc_list;
  100e62:	48 8b 05 c7 21 00 00 	mov    0x21c7(%rip),%rax        # 103030 <malloc_list>
    while (temp != NULL)
  100e69:	48 85 c0             	test   %rax,%rax
  100e6c:	0f 84 c8 00 00 00    	je     100f3a <heap_info+0x133>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  100e72:	bb 00 00 00 00       	mov    $0x0,%ebx
  100e77:	eb 09                	jmp    100e82 <heap_info+0x7b>
        // Ensure block has not been freed
        if (temp->alloc == 1)
        {
            num_allocs ++;
        }
        temp = temp->next_alloc_block;
  100e79:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL)
  100e7d:	48 85 c0             	test   %rax,%rax
  100e80:	74 0b                	je     100e8d <heap_info+0x86>
        if (temp->alloc == 1)
  100e82:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  100e86:	75 f1                	jne    100e79 <heap_info+0x72>
            num_allocs ++;
  100e88:	83 c3 01             	add    $0x1,%ebx
  100e8b:	eb ec                	jmp    100e79 <heap_info+0x72>
    }
    // Create ptr_array (list of pointers to memory block headers)
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  100e8d:	48 63 c3             	movslq %ebx,%rax
  100e90:	48 c1 e0 03          	shl    $0x3,%rax
  100e94:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  100e98:	48 89 c7             	mov    %rax,%rdi
  100e9b:	e8 b8 fd ff ff       	call   100c58 <malloc>
  100ea0:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  100ea3:	48 85 c0             	test   %rax,%rax
  100ea6:	74 63                	je     100f0b <heap_info+0x104>
    {
        return -1;
    }
    int count = 0;
    // Reinitialize "temp"
    temp = malloc_list;
  100ea8:	48 8b 05 81 21 00 00 	mov    0x2181(%rip),%rax        # 103030 <malloc_list>
    while (temp != NULL && (count < num_allocs))
  100eaf:	48 85 c0             	test   %rax,%rax
  100eb2:	74 32                	je     100ee6 <heap_info+0xdf>
  100eb4:	85 db                	test   %ebx,%ebx
  100eb6:	7e 2e                	jle    100ee6 <heap_info+0xdf>
    int count = 0;
  100eb8:	ba 00 00 00 00       	mov    $0x0,%edx
  100ebd:	eb 15                	jmp    100ed4 <heap_info+0xcd>
        if (temp->alloc == 1)
        {
            ptr_array[count] = temp;
            count += 1;
        }
        temp = temp->next_alloc_block;
  100ebf:	48 8b 40 20          	mov    0x20(%rax),%rax
    while (temp != NULL && (count < num_allocs))
  100ec3:	48 85 c0             	test   %rax,%rax
  100ec6:	0f 84 a3 00 00 00    	je     100f6f <heap_info+0x168>
  100ecc:	39 d3                	cmp    %edx,%ebx
  100ece:	0f 8e 9b 00 00 00    	jle    100f6f <heap_info+0x168>
        if (temp->alloc == 1)
  100ed4:	83 78 18 01          	cmpl   $0x1,0x18(%rax)
  100ed8:	75 e5                	jne    100ebf <heap_info+0xb8>
            ptr_array[count] = temp;
  100eda:	48 63 ca             	movslq %edx,%rcx
  100edd:	49 89 04 cc          	mov    %rax,(%r12,%rcx,8)
            count += 1;
  100ee1:	83 c2 01             	add    $0x1,%edx
  100ee4:	eb d9                	jmp    100ebf <heap_info+0xb8>
    }
    // Sort ptr_array in descending order
    merge_sort(ptr_array, num_allocs);
  100ee6:	89 de                	mov    %ebx,%esi
  100ee8:	4c 89 e7             	mov    %r12,%rdi
  100eeb:	e8 3f fc ff ff       	call   100b2f <merge_sort>
    // Create "size_array"
    long* size_array = malloc(sizeof(long) * num_allocs);
  100ef0:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100ef4:	e8 5f fd ff ff       	call   100c58 <malloc>
    if (size_array == NULL)
  100ef9:	48 85 c0             	test   %rax,%rax
  100efc:	74 17                	je     100f15 <heap_info+0x10e>
    {
        return -1;
    }
    for(int i = 0; i < num_allocs; i++)
  100efe:	85 db                	test   %ebx,%ebx
  100f00:	0f 8f 81 00 00 00    	jg     100f87 <heap_info+0x180>
  100f06:	e9 95 00 00 00       	jmp    100fa0 <heap_info+0x199>
        return -1;
  100f0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100f10:	e9 a3 00 00 00       	jmp    100fb8 <heap_info+0x1b1>
        return -1;
  100f15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100f1a:	e9 99 00 00 00       	jmp    100fb8 <heap_info+0x1b1>
        return -1;
  100f1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100f24:	e9 8f 00 00 00       	jmp    100fb8 <heap_info+0x1b1>
        return -1;
  100f29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100f2e:	e9 85 00 00 00       	jmp    100fb8 <heap_info+0x1b1>
  100f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100f38:	eb 7e                	jmp    100fb8 <heap_info+0x1b1>
    header** ptr_array = malloc(((uint64_t) num_allocs) * ((uint64_t) (sizeof(header*))));
  100f3a:	bf 00 00 00 00       	mov    $0x0,%edi
  100f3f:	e8 14 fd ff ff       	call   100c58 <malloc>
  100f44:	49 89 c4             	mov    %rax,%r12
    if (ptr_array == NULL)
  100f47:	48 85 c0             	test   %rax,%rax
  100f4a:	74 d3                	je     100f1f <heap_info+0x118>
    merge_sort(ptr_array, num_allocs);
  100f4c:	be 00 00 00 00       	mov    $0x0,%esi
  100f51:	48 89 c7             	mov    %rax,%rdi
  100f54:	e8 d6 fb ff ff       	call   100b2f <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  100f59:	bf 00 00 00 00       	mov    $0x0,%edi
  100f5e:	e8 f5 fc ff ff       	call   100c58 <malloc>
    if (size_array == NULL)
  100f63:	48 85 c0             	test   %rax,%rax
  100f66:	74 cb                	je     100f33 <heap_info+0x12c>
    int largest_free_chunk = 0, free_space = 0, num_allocs = 0;
  100f68:	bb 00 00 00 00       	mov    $0x0,%ebx
  100f6d:	eb 31                	jmp    100fa0 <heap_info+0x199>
    merge_sort(ptr_array, num_allocs);
  100f6f:	89 de                	mov    %ebx,%esi
  100f71:	4c 89 e7             	mov    %r12,%rdi
  100f74:	e8 b6 fb ff ff       	call   100b2f <merge_sort>
    long* size_array = malloc(sizeof(long) * num_allocs);
  100f79:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100f7d:	e8 d6 fc ff ff       	call   100c58 <malloc>
    if (size_array == NULL)
  100f82:	48 85 c0             	test   %rax,%rax
  100f85:	74 a2                	je     100f29 <heap_info+0x122>
    int count = 0;
  100f87:	ba 00 00 00 00       	mov    $0x0,%edx
    {
        size_array[i] = (long)ptr_array[i]->size;
  100f8c:	49 8b 0c d4          	mov    (%r12,%rdx,8),%rcx
  100f90:	48 8b 49 10          	mov    0x10(%rcx),%rcx
  100f94:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
    for(int i = 0; i < num_allocs; i++)
  100f98:	48 83 c2 01          	add    $0x1,%rdx
  100f9c:	39 d3                	cmp    %edx,%ebx
  100f9e:	7f ec                	jg     100f8c <heap_info+0x185>
    }
    // Assign values to heap_info_struct
    info->num_allocs = num_allocs;
  100fa0:	41 89 1f             	mov    %ebx,(%r15)
    info->size_array = size_array;
  100fa3:	49 89 47 08          	mov    %rax,0x8(%r15)
    info->ptr_array = (void**)ptr_array;
  100fa7:	4d 89 67 10          	mov    %r12,0x10(%r15)
    info->free_space = free_space;
  100fab:	45 89 77 18          	mov    %r14d,0x18(%r15)
    info->largest_free_chunk = largest_free_chunk;
  100faf:	45 89 6f 1c          	mov    %r13d,0x1c(%r15)
    return 0;
  100fb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100fb8:	48 83 c4 18          	add    $0x18,%rsp
  100fbc:	5b                   	pop    %rbx
  100fbd:	41 5c                	pop    %r12
  100fbf:	41 5d                	pop    %r13
  100fc1:	41 5e                	pop    %r14
  100fc3:	41 5f                	pop    %r15
  100fc5:	5d                   	pop    %rbp
  100fc6:	c3                   	ret    

0000000000100fc7 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100fc7:	55                   	push   %rbp
  100fc8:	48 89 e5             	mov    %rsp,%rbp
  100fcb:	48 83 ec 28          	sub    $0x28,%rsp
  100fcf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100fd3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100fd7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100fdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100fdf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100fe3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100fe7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  100feb:	eb 1c                	jmp    101009 <memcpy+0x42>
        *d = *s;
  100fed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ff1:	0f b6 10             	movzbl (%rax),%edx
  100ff4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ff8:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100ffa:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100fff:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  101004:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  101009:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10100e:	75 dd                	jne    100fed <memcpy+0x26>
    }
    return dst;
  101010:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  101014:	c9                   	leave  
  101015:	c3                   	ret    

0000000000101016 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  101016:	55                   	push   %rbp
  101017:	48 89 e5             	mov    %rsp,%rbp
  10101a:	48 83 ec 28          	sub    $0x28,%rsp
  10101e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101022:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  101026:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10102a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10102e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  101032:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101036:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  10103a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10103e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  101042:	73 6a                	jae    1010ae <memmove+0x98>
  101044:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101048:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10104c:	48 01 d0             	add    %rdx,%rax
  10104f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  101053:	73 59                	jae    1010ae <memmove+0x98>
        s += n, d += n;
  101055:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101059:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  10105d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101061:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  101065:	eb 17                	jmp    10107e <memmove+0x68>
            *--d = *--s;
  101067:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  10106c:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  101071:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101075:	0f b6 10             	movzbl (%rax),%edx
  101078:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10107c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10107e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101082:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101086:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  10108a:	48 85 c0             	test   %rax,%rax
  10108d:	75 d8                	jne    101067 <memmove+0x51>
    if (s < d && s + n > d) {
  10108f:	eb 2e                	jmp    1010bf <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  101091:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101095:	48 8d 42 01          	lea    0x1(%rdx),%rax
  101099:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10109d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010a1:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1010a5:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  1010a9:	0f b6 12             	movzbl (%rdx),%edx
  1010ac:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1010ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010b2:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1010b6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1010ba:	48 85 c0             	test   %rax,%rax
  1010bd:	75 d2                	jne    101091 <memmove+0x7b>
        }
    }
    return dst;
  1010bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1010c3:	c9                   	leave  
  1010c4:	c3                   	ret    

00000000001010c5 <memset>:

void* memset(void* v, int c, size_t n) {
  1010c5:	55                   	push   %rbp
  1010c6:	48 89 e5             	mov    %rsp,%rbp
  1010c9:	48 83 ec 28          	sub    $0x28,%rsp
  1010cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1010d1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1010d4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1010d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1010dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1010e0:	eb 15                	jmp    1010f7 <memset+0x32>
        *p = c;
  1010e2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1010e5:	89 c2                	mov    %eax,%edx
  1010e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1010eb:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1010ed:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1010f2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1010f7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1010fc:	75 e4                	jne    1010e2 <memset+0x1d>
    }
    return v;
  1010fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  101102:	c9                   	leave  
  101103:	c3                   	ret    

0000000000101104 <strlen>:

size_t strlen(const char* s) {
  101104:	55                   	push   %rbp
  101105:	48 89 e5             	mov    %rsp,%rbp
  101108:	48 83 ec 18          	sub    $0x18,%rsp
  10110c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  101110:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  101117:	00 
  101118:	eb 0a                	jmp    101124 <strlen+0x20>
        ++n;
  10111a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10111f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  101124:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101128:	0f b6 00             	movzbl (%rax),%eax
  10112b:	84 c0                	test   %al,%al
  10112d:	75 eb                	jne    10111a <strlen+0x16>
    }
    return n;
  10112f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  101133:	c9                   	leave  
  101134:	c3                   	ret    

0000000000101135 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  101135:	55                   	push   %rbp
  101136:	48 89 e5             	mov    %rsp,%rbp
  101139:	48 83 ec 20          	sub    $0x20,%rsp
  10113d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101141:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  101145:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  10114c:	00 
  10114d:	eb 0a                	jmp    101159 <strnlen+0x24>
        ++n;
  10114f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  101154:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  101159:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10115d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  101161:	74 0b                	je     10116e <strnlen+0x39>
  101163:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101167:	0f b6 00             	movzbl (%rax),%eax
  10116a:	84 c0                	test   %al,%al
  10116c:	75 e1                	jne    10114f <strnlen+0x1a>
    }
    return n;
  10116e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  101172:	c9                   	leave  
  101173:	c3                   	ret    

0000000000101174 <strcpy>:

char* strcpy(char* dst, const char* src) {
  101174:	55                   	push   %rbp
  101175:	48 89 e5             	mov    %rsp,%rbp
  101178:	48 83 ec 20          	sub    $0x20,%rsp
  10117c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101180:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  101184:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101188:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  10118c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101190:	48 8d 42 01          	lea    0x1(%rdx),%rax
  101194:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  101198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10119c:	48 8d 48 01          	lea    0x1(%rax),%rcx
  1011a0:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  1011a4:	0f b6 12             	movzbl (%rdx),%edx
  1011a7:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1011a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011ad:	48 83 e8 01          	sub    $0x1,%rax
  1011b1:	0f b6 00             	movzbl (%rax),%eax
  1011b4:	84 c0                	test   %al,%al
  1011b6:	75 d4                	jne    10118c <strcpy+0x18>
    return dst;
  1011b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1011bc:	c9                   	leave  
  1011bd:	c3                   	ret    

00000000001011be <strcmp>:

int strcmp(const char* a, const char* b) {
  1011be:	55                   	push   %rbp
  1011bf:	48 89 e5             	mov    %rsp,%rbp
  1011c2:	48 83 ec 10          	sub    $0x10,%rsp
  1011c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1011ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1011ce:	eb 0a                	jmp    1011da <strcmp+0x1c>
        ++a, ++b;
  1011d0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1011d5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1011da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011de:	0f b6 00             	movzbl (%rax),%eax
  1011e1:	84 c0                	test   %al,%al
  1011e3:	74 1d                	je     101202 <strcmp+0x44>
  1011e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011e9:	0f b6 00             	movzbl (%rax),%eax
  1011ec:	84 c0                	test   %al,%al
  1011ee:	74 12                	je     101202 <strcmp+0x44>
  1011f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1011f4:	0f b6 10             	movzbl (%rax),%edx
  1011f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1011fb:	0f b6 00             	movzbl (%rax),%eax
  1011fe:	38 c2                	cmp    %al,%dl
  101200:	74 ce                	je     1011d0 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  101202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101206:	0f b6 00             	movzbl (%rax),%eax
  101209:	89 c2                	mov    %eax,%edx
  10120b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10120f:	0f b6 00             	movzbl (%rax),%eax
  101212:	38 d0                	cmp    %dl,%al
  101214:	0f 92 c0             	setb   %al
  101217:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  10121a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10121e:	0f b6 00             	movzbl (%rax),%eax
  101221:	89 c1                	mov    %eax,%ecx
  101223:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101227:	0f b6 00             	movzbl (%rax),%eax
  10122a:	38 c1                	cmp    %al,%cl
  10122c:	0f 92 c0             	setb   %al
  10122f:	0f b6 c0             	movzbl %al,%eax
  101232:	29 c2                	sub    %eax,%edx
  101234:	89 d0                	mov    %edx,%eax
}
  101236:	c9                   	leave  
  101237:	c3                   	ret    

0000000000101238 <strchr>:

char* strchr(const char* s, int c) {
  101238:	55                   	push   %rbp
  101239:	48 89 e5             	mov    %rsp,%rbp
  10123c:	48 83 ec 10          	sub    $0x10,%rsp
  101240:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  101244:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  101247:	eb 05                	jmp    10124e <strchr+0x16>
        ++s;
  101249:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  10124e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101252:	0f b6 00             	movzbl (%rax),%eax
  101255:	84 c0                	test   %al,%al
  101257:	74 0e                	je     101267 <strchr+0x2f>
  101259:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10125d:	0f b6 00             	movzbl (%rax),%eax
  101260:	8b 55 f4             	mov    -0xc(%rbp),%edx
  101263:	38 d0                	cmp    %dl,%al
  101265:	75 e2                	jne    101249 <strchr+0x11>
    }
    if (*s == (char) c) {
  101267:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10126b:	0f b6 00             	movzbl (%rax),%eax
  10126e:	8b 55 f4             	mov    -0xc(%rbp),%edx
  101271:	38 d0                	cmp    %dl,%al
  101273:	75 06                	jne    10127b <strchr+0x43>
        return (char*) s;
  101275:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101279:	eb 05                	jmp    101280 <strchr+0x48>
    } else {
        return NULL;
  10127b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  101280:	c9                   	leave  
  101281:	c3                   	ret    

0000000000101282 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  101282:	55                   	push   %rbp
  101283:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  101286:	8b 05 c4 1d 00 00    	mov    0x1dc4(%rip),%eax        # 103050 <rand_seed_set>
  10128c:	85 c0                	test   %eax,%eax
  10128e:	75 0a                	jne    10129a <rand+0x18>
        srand(819234718U);
  101290:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  101295:	e8 24 00 00 00       	call   1012be <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10129a:	8b 05 b4 1d 00 00    	mov    0x1db4(%rip),%eax        # 103054 <rand_seed>
  1012a0:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1012a6:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1012ab:	89 05 a3 1d 00 00    	mov    %eax,0x1da3(%rip)        # 103054 <rand_seed>
    return rand_seed & RAND_MAX;
  1012b1:	8b 05 9d 1d 00 00    	mov    0x1d9d(%rip),%eax        # 103054 <rand_seed>
  1012b7:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1012bc:	5d                   	pop    %rbp
  1012bd:	c3                   	ret    

00000000001012be <srand>:

void srand(unsigned seed) {
  1012be:	55                   	push   %rbp
  1012bf:	48 89 e5             	mov    %rsp,%rbp
  1012c2:	48 83 ec 08          	sub    $0x8,%rsp
  1012c6:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1012c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1012cc:	89 05 82 1d 00 00    	mov    %eax,0x1d82(%rip)        # 103054 <rand_seed>
    rand_seed_set = 1;
  1012d2:	c7 05 74 1d 00 00 01 	movl   $0x1,0x1d74(%rip)        # 103050 <rand_seed_set>
  1012d9:	00 00 00 
}
  1012dc:	90                   	nop
  1012dd:	c9                   	leave  
  1012de:	c3                   	ret    

00000000001012df <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1012df:	55                   	push   %rbp
  1012e0:	48 89 e5             	mov    %rsp,%rbp
  1012e3:	48 83 ec 28          	sub    $0x28,%rsp
  1012e7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1012eb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1012ef:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  1012f2:	48 c7 45 f8 00 23 10 	movq   $0x102300,-0x8(%rbp)
  1012f9:	00 
    if (base < 0) {
  1012fa:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  1012fe:	79 0b                	jns    10130b <fill_numbuf+0x2c>
        digits = lower_digits;
  101300:	48 c7 45 f8 20 23 10 	movq   $0x102320,-0x8(%rbp)
  101307:	00 
        base = -base;
  101308:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10130b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  101310:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101314:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  101317:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10131a:	48 63 c8             	movslq %eax,%rcx
  10131d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  101321:	ba 00 00 00 00       	mov    $0x0,%edx
  101326:	48 f7 f1             	div    %rcx
  101329:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10132d:	48 01 d0             	add    %rdx,%rax
  101330:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  101335:	0f b6 10             	movzbl (%rax),%edx
  101338:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10133c:	88 10                	mov    %dl,(%rax)
        val /= base;
  10133e:	8b 45 dc             	mov    -0x24(%rbp),%eax
  101341:	48 63 f0             	movslq %eax,%rsi
  101344:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  101348:	ba 00 00 00 00       	mov    $0x0,%edx
  10134d:	48 f7 f6             	div    %rsi
  101350:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  101354:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  101359:	75 bc                	jne    101317 <fill_numbuf+0x38>
    return numbuf_end;
  10135b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10135f:	c9                   	leave  
  101360:	c3                   	ret    

0000000000101361 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  101361:	55                   	push   %rbp
  101362:	48 89 e5             	mov    %rsp,%rbp
  101365:	53                   	push   %rbx
  101366:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  10136d:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  101374:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  10137a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  101381:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  101388:	e9 8a 09 00 00       	jmp    101d17 <printer_vprintf+0x9b6>
        if (*format != '%') {
  10138d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101394:	0f b6 00             	movzbl (%rax),%eax
  101397:	3c 25                	cmp    $0x25,%al
  101399:	74 31                	je     1013cc <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  10139b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013a2:	4c 8b 00             	mov    (%rax),%r8
  1013a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013ac:	0f b6 00             	movzbl (%rax),%eax
  1013af:	0f b6 c8             	movzbl %al,%ecx
  1013b2:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1013b8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1013bf:	89 ce                	mov    %ecx,%esi
  1013c1:	48 89 c7             	mov    %rax,%rdi
  1013c4:	41 ff d0             	call   *%r8
            continue;
  1013c7:	e9 43 09 00 00       	jmp    101d0f <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  1013cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1013d3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1013da:	01 
  1013db:	eb 44                	jmp    101421 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  1013dd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013e4:	0f b6 00             	movzbl (%rax),%eax
  1013e7:	0f be c0             	movsbl %al,%eax
  1013ea:	89 c6                	mov    %eax,%esi
  1013ec:	bf 20 21 10 00       	mov    $0x102120,%edi
  1013f1:	e8 42 fe ff ff       	call   101238 <strchr>
  1013f6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  1013fa:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  1013ff:	74 30                	je     101431 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  101401:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  101405:	48 2d 20 21 10 00    	sub    $0x102120,%rax
  10140b:	ba 01 00 00 00       	mov    $0x1,%edx
  101410:	89 c1                	mov    %eax,%ecx
  101412:	d3 e2                	shl    %cl,%edx
  101414:	89 d0                	mov    %edx,%eax
  101416:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  101419:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101420:	01 
  101421:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101428:	0f b6 00             	movzbl (%rax),%eax
  10142b:	84 c0                	test   %al,%al
  10142d:	75 ae                	jne    1013dd <printer_vprintf+0x7c>
  10142f:	eb 01                	jmp    101432 <printer_vprintf+0xd1>
            } else {
                break;
  101431:	90                   	nop
            }
        }

        // process width
        int width = -1;
  101432:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  101439:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101440:	0f b6 00             	movzbl (%rax),%eax
  101443:	3c 30                	cmp    $0x30,%al
  101445:	7e 67                	jle    1014ae <printer_vprintf+0x14d>
  101447:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10144e:	0f b6 00             	movzbl (%rax),%eax
  101451:	3c 39                	cmp    $0x39,%al
  101453:	7f 59                	jg     1014ae <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  101455:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10145c:	eb 2e                	jmp    10148c <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  10145e:	8b 55 e8             	mov    -0x18(%rbp),%edx
  101461:	89 d0                	mov    %edx,%eax
  101463:	c1 e0 02             	shl    $0x2,%eax
  101466:	01 d0                	add    %edx,%eax
  101468:	01 c0                	add    %eax,%eax
  10146a:	89 c1                	mov    %eax,%ecx
  10146c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101473:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101477:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10147e:	0f b6 00             	movzbl (%rax),%eax
  101481:	0f be c0             	movsbl %al,%eax
  101484:	01 c8                	add    %ecx,%eax
  101486:	83 e8 30             	sub    $0x30,%eax
  101489:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10148c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101493:	0f b6 00             	movzbl (%rax),%eax
  101496:	3c 2f                	cmp    $0x2f,%al
  101498:	0f 8e 85 00 00 00    	jle    101523 <printer_vprintf+0x1c2>
  10149e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1014a5:	0f b6 00             	movzbl (%rax),%eax
  1014a8:	3c 39                	cmp    $0x39,%al
  1014aa:	7e b2                	jle    10145e <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  1014ac:	eb 75                	jmp    101523 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  1014ae:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1014b5:	0f b6 00             	movzbl (%rax),%eax
  1014b8:	3c 2a                	cmp    $0x2a,%al
  1014ba:	75 68                	jne    101524 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  1014bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014c3:	8b 00                	mov    (%rax),%eax
  1014c5:	83 f8 2f             	cmp    $0x2f,%eax
  1014c8:	77 30                	ja     1014fa <printer_vprintf+0x199>
  1014ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014d1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1014d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1014dc:	8b 00                	mov    (%rax),%eax
  1014de:	89 c0                	mov    %eax,%eax
  1014e0:	48 01 d0             	add    %rdx,%rax
  1014e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014ea:	8b 12                	mov    (%rdx),%edx
  1014ec:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1014ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1014f6:	89 0a                	mov    %ecx,(%rdx)
  1014f8:	eb 1a                	jmp    101514 <printer_vprintf+0x1b3>
  1014fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101501:	48 8b 40 08          	mov    0x8(%rax),%rax
  101505:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101509:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101510:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101514:	8b 00                	mov    (%rax),%eax
  101516:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  101519:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101520:	01 
  101521:	eb 01                	jmp    101524 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  101523:	90                   	nop
        }

        // process precision
        int precision = -1;
  101524:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10152b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101532:	0f b6 00             	movzbl (%rax),%eax
  101535:	3c 2e                	cmp    $0x2e,%al
  101537:	0f 85 00 01 00 00    	jne    10163d <printer_vprintf+0x2dc>
            ++format;
  10153d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101544:	01 
            if (*format >= '0' && *format <= '9') {
  101545:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10154c:	0f b6 00             	movzbl (%rax),%eax
  10154f:	3c 2f                	cmp    $0x2f,%al
  101551:	7e 67                	jle    1015ba <printer_vprintf+0x259>
  101553:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10155a:	0f b6 00             	movzbl (%rax),%eax
  10155d:	3c 39                	cmp    $0x39,%al
  10155f:	7f 59                	jg     1015ba <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101561:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  101568:	eb 2e                	jmp    101598 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  10156a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10156d:	89 d0                	mov    %edx,%eax
  10156f:	c1 e0 02             	shl    $0x2,%eax
  101572:	01 d0                	add    %edx,%eax
  101574:	01 c0                	add    %eax,%eax
  101576:	89 c1                	mov    %eax,%ecx
  101578:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10157f:	48 8d 50 01          	lea    0x1(%rax),%rdx
  101583:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10158a:	0f b6 00             	movzbl (%rax),%eax
  10158d:	0f be c0             	movsbl %al,%eax
  101590:	01 c8                	add    %ecx,%eax
  101592:	83 e8 30             	sub    $0x30,%eax
  101595:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  101598:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10159f:	0f b6 00             	movzbl (%rax),%eax
  1015a2:	3c 2f                	cmp    $0x2f,%al
  1015a4:	0f 8e 85 00 00 00    	jle    10162f <printer_vprintf+0x2ce>
  1015aa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1015b1:	0f b6 00             	movzbl (%rax),%eax
  1015b4:	3c 39                	cmp    $0x39,%al
  1015b6:	7e b2                	jle    10156a <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  1015b8:	eb 75                	jmp    10162f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  1015ba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1015c1:	0f b6 00             	movzbl (%rax),%eax
  1015c4:	3c 2a                	cmp    $0x2a,%al
  1015c6:	75 68                	jne    101630 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  1015c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015cf:	8b 00                	mov    (%rax),%eax
  1015d1:	83 f8 2f             	cmp    $0x2f,%eax
  1015d4:	77 30                	ja     101606 <printer_vprintf+0x2a5>
  1015d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015dd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1015e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1015e8:	8b 00                	mov    (%rax),%eax
  1015ea:	89 c0                	mov    %eax,%eax
  1015ec:	48 01 d0             	add    %rdx,%rax
  1015ef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1015f6:	8b 12                	mov    (%rdx),%edx
  1015f8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1015fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101602:	89 0a                	mov    %ecx,(%rdx)
  101604:	eb 1a                	jmp    101620 <printer_vprintf+0x2bf>
  101606:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10160d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101611:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101615:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10161c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101620:	8b 00                	mov    (%rax),%eax
  101622:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  101625:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10162c:	01 
  10162d:	eb 01                	jmp    101630 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  10162f:	90                   	nop
            }
            if (precision < 0) {
  101630:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101634:	79 07                	jns    10163d <printer_vprintf+0x2dc>
                precision = 0;
  101636:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10163d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  101644:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10164b:	00 
        int length = 0;
  10164c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  101653:	48 c7 45 c8 26 21 10 	movq   $0x102126,-0x38(%rbp)
  10165a:	00 
    again:
        switch (*format) {
  10165b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101662:	0f b6 00             	movzbl (%rax),%eax
  101665:	0f be c0             	movsbl %al,%eax
  101668:	83 e8 43             	sub    $0x43,%eax
  10166b:	83 f8 37             	cmp    $0x37,%eax
  10166e:	0f 87 9f 03 00 00    	ja     101a13 <printer_vprintf+0x6b2>
  101674:	89 c0                	mov    %eax,%eax
  101676:	48 8b 04 c5 38 21 10 	mov    0x102138(,%rax,8),%rax
  10167d:	00 
  10167e:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  101680:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  101687:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10168e:	01 
            goto again;
  10168f:	eb ca                	jmp    10165b <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  101691:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101695:	74 5d                	je     1016f4 <printer_vprintf+0x393>
  101697:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10169e:	8b 00                	mov    (%rax),%eax
  1016a0:	83 f8 2f             	cmp    $0x2f,%eax
  1016a3:	77 30                	ja     1016d5 <printer_vprintf+0x374>
  1016a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1016b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016b7:	8b 00                	mov    (%rax),%eax
  1016b9:	89 c0                	mov    %eax,%eax
  1016bb:	48 01 d0             	add    %rdx,%rax
  1016be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1016c5:	8b 12                	mov    (%rdx),%edx
  1016c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1016ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1016d1:	89 0a                	mov    %ecx,(%rdx)
  1016d3:	eb 1a                	jmp    1016ef <printer_vprintf+0x38e>
  1016d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016dc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016e0:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1016e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1016eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1016ef:	48 8b 00             	mov    (%rax),%rax
  1016f2:	eb 5c                	jmp    101750 <printer_vprintf+0x3ef>
  1016f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1016fb:	8b 00                	mov    (%rax),%eax
  1016fd:	83 f8 2f             	cmp    $0x2f,%eax
  101700:	77 30                	ja     101732 <printer_vprintf+0x3d1>
  101702:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101709:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10170d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101714:	8b 00                	mov    (%rax),%eax
  101716:	89 c0                	mov    %eax,%eax
  101718:	48 01 d0             	add    %rdx,%rax
  10171b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101722:	8b 12                	mov    (%rdx),%edx
  101724:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101727:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10172e:	89 0a                	mov    %ecx,(%rdx)
  101730:	eb 1a                	jmp    10174c <printer_vprintf+0x3eb>
  101732:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101739:	48 8b 40 08          	mov    0x8(%rax),%rax
  10173d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101741:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101748:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10174c:	8b 00                	mov    (%rax),%eax
  10174e:	48 98                	cltq   
  101750:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  101754:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101758:	48 c1 f8 38          	sar    $0x38,%rax
  10175c:	25 80 00 00 00       	and    $0x80,%eax
  101761:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  101764:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  101768:	74 09                	je     101773 <printer_vprintf+0x412>
  10176a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10176e:	48 f7 d8             	neg    %rax
  101771:	eb 04                	jmp    101777 <printer_vprintf+0x416>
  101773:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101777:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10177b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  10177e:	83 c8 60             	or     $0x60,%eax
  101781:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  101784:	e9 cf 02 00 00       	jmp    101a58 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  101789:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  10178d:	74 5d                	je     1017ec <printer_vprintf+0x48b>
  10178f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101796:	8b 00                	mov    (%rax),%eax
  101798:	83 f8 2f             	cmp    $0x2f,%eax
  10179b:	77 30                	ja     1017cd <printer_vprintf+0x46c>
  10179d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1017a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1017a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1017af:	8b 00                	mov    (%rax),%eax
  1017b1:	89 c0                	mov    %eax,%eax
  1017b3:	48 01 d0             	add    %rdx,%rax
  1017b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1017bd:	8b 12                	mov    (%rdx),%edx
  1017bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1017c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1017c9:	89 0a                	mov    %ecx,(%rdx)
  1017cb:	eb 1a                	jmp    1017e7 <printer_vprintf+0x486>
  1017cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1017d4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1017d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1017dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1017e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1017e7:	48 8b 00             	mov    (%rax),%rax
  1017ea:	eb 5c                	jmp    101848 <printer_vprintf+0x4e7>
  1017ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1017f3:	8b 00                	mov    (%rax),%eax
  1017f5:	83 f8 2f             	cmp    $0x2f,%eax
  1017f8:	77 30                	ja     10182a <printer_vprintf+0x4c9>
  1017fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101801:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101805:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10180c:	8b 00                	mov    (%rax),%eax
  10180e:	89 c0                	mov    %eax,%eax
  101810:	48 01 d0             	add    %rdx,%rax
  101813:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10181a:	8b 12                	mov    (%rdx),%edx
  10181c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10181f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101826:	89 0a                	mov    %ecx,(%rdx)
  101828:	eb 1a                	jmp    101844 <printer_vprintf+0x4e3>
  10182a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101831:	48 8b 40 08          	mov    0x8(%rax),%rax
  101835:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101839:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101840:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101844:	8b 00                	mov    (%rax),%eax
  101846:	89 c0                	mov    %eax,%eax
  101848:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  10184c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  101850:	e9 03 02 00 00       	jmp    101a58 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  101855:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  10185c:	e9 28 ff ff ff       	jmp    101789 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  101861:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  101868:	e9 1c ff ff ff       	jmp    101789 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  10186d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101874:	8b 00                	mov    (%rax),%eax
  101876:	83 f8 2f             	cmp    $0x2f,%eax
  101879:	77 30                	ja     1018ab <printer_vprintf+0x54a>
  10187b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101882:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101886:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10188d:	8b 00                	mov    (%rax),%eax
  10188f:	89 c0                	mov    %eax,%eax
  101891:	48 01 d0             	add    %rdx,%rax
  101894:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10189b:	8b 12                	mov    (%rdx),%edx
  10189d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1018a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1018a7:	89 0a                	mov    %ecx,(%rdx)
  1018a9:	eb 1a                	jmp    1018c5 <printer_vprintf+0x564>
  1018ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1018b2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1018b6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1018ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1018c1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1018c5:	48 8b 00             	mov    (%rax),%rax
  1018c8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  1018cc:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1018d3:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  1018da:	e9 79 01 00 00       	jmp    101a58 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  1018df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1018e6:	8b 00                	mov    (%rax),%eax
  1018e8:	83 f8 2f             	cmp    $0x2f,%eax
  1018eb:	77 30                	ja     10191d <printer_vprintf+0x5bc>
  1018ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1018f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1018f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1018ff:	8b 00                	mov    (%rax),%eax
  101901:	89 c0                	mov    %eax,%eax
  101903:	48 01 d0             	add    %rdx,%rax
  101906:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10190d:	8b 12                	mov    (%rdx),%edx
  10190f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101912:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101919:	89 0a                	mov    %ecx,(%rdx)
  10191b:	eb 1a                	jmp    101937 <printer_vprintf+0x5d6>
  10191d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101924:	48 8b 40 08          	mov    0x8(%rax),%rax
  101928:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10192c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101933:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101937:	48 8b 00             	mov    (%rax),%rax
  10193a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  10193e:	e9 15 01 00 00       	jmp    101a58 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  101943:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10194a:	8b 00                	mov    (%rax),%eax
  10194c:	83 f8 2f             	cmp    $0x2f,%eax
  10194f:	77 30                	ja     101981 <printer_vprintf+0x620>
  101951:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101958:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10195c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101963:	8b 00                	mov    (%rax),%eax
  101965:	89 c0                	mov    %eax,%eax
  101967:	48 01 d0             	add    %rdx,%rax
  10196a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101971:	8b 12                	mov    (%rdx),%edx
  101973:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101976:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10197d:	89 0a                	mov    %ecx,(%rdx)
  10197f:	eb 1a                	jmp    10199b <printer_vprintf+0x63a>
  101981:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101988:	48 8b 40 08          	mov    0x8(%rax),%rax
  10198c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101990:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101997:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10199b:	8b 00                	mov    (%rax),%eax
  10199d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  1019a3:	e9 67 03 00 00       	jmp    101d0f <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  1019a8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1019ac:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  1019b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1019b7:	8b 00                	mov    (%rax),%eax
  1019b9:	83 f8 2f             	cmp    $0x2f,%eax
  1019bc:	77 30                	ja     1019ee <printer_vprintf+0x68d>
  1019be:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1019c5:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1019c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1019d0:	8b 00                	mov    (%rax),%eax
  1019d2:	89 c0                	mov    %eax,%eax
  1019d4:	48 01 d0             	add    %rdx,%rax
  1019d7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1019de:	8b 12                	mov    (%rdx),%edx
  1019e0:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1019e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1019ea:	89 0a                	mov    %ecx,(%rdx)
  1019ec:	eb 1a                	jmp    101a08 <printer_vprintf+0x6a7>
  1019ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1019f5:	48 8b 40 08          	mov    0x8(%rax),%rax
  1019f9:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1019fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101a04:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101a08:	8b 00                	mov    (%rax),%eax
  101a0a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101a0d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101a11:	eb 45                	jmp    101a58 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101a13:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101a17:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  101a1b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101a22:	0f b6 00             	movzbl (%rax),%eax
  101a25:	84 c0                	test   %al,%al
  101a27:	74 0c                	je     101a35 <printer_vprintf+0x6d4>
  101a29:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101a30:	0f b6 00             	movzbl (%rax),%eax
  101a33:	eb 05                	jmp    101a3a <printer_vprintf+0x6d9>
  101a35:	b8 25 00 00 00       	mov    $0x25,%eax
  101a3a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  101a3d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  101a41:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101a48:	0f b6 00             	movzbl (%rax),%eax
  101a4b:	84 c0                	test   %al,%al
  101a4d:	75 08                	jne    101a57 <printer_vprintf+0x6f6>
                format--;
  101a4f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  101a56:	01 
            }
            break;
  101a57:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  101a58:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101a5b:	83 e0 20             	and    $0x20,%eax
  101a5e:	85 c0                	test   %eax,%eax
  101a60:	74 1e                	je     101a80 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  101a62:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101a66:	48 83 c0 18          	add    $0x18,%rax
  101a6a:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101a6d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101a71:	48 89 ce             	mov    %rcx,%rsi
  101a74:	48 89 c7             	mov    %rax,%rdi
  101a77:	e8 63 f8 ff ff       	call   1012df <fill_numbuf>
  101a7c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  101a80:	48 c7 45 c0 26 21 10 	movq   $0x102126,-0x40(%rbp)
  101a87:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  101a88:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101a8b:	83 e0 20             	and    $0x20,%eax
  101a8e:	85 c0                	test   %eax,%eax
  101a90:	74 48                	je     101ada <printer_vprintf+0x779>
  101a92:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101a95:	83 e0 40             	and    $0x40,%eax
  101a98:	85 c0                	test   %eax,%eax
  101a9a:	74 3e                	je     101ada <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  101a9c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101a9f:	25 80 00 00 00       	and    $0x80,%eax
  101aa4:	85 c0                	test   %eax,%eax
  101aa6:	74 0a                	je     101ab2 <printer_vprintf+0x751>
                prefix = "-";
  101aa8:	48 c7 45 c0 27 21 10 	movq   $0x102127,-0x40(%rbp)
  101aaf:	00 
            if (flags & FLAG_NEGATIVE) {
  101ab0:	eb 73                	jmp    101b25 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101ab2:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101ab5:	83 e0 10             	and    $0x10,%eax
  101ab8:	85 c0                	test   %eax,%eax
  101aba:	74 0a                	je     101ac6 <printer_vprintf+0x765>
                prefix = "+";
  101abc:	48 c7 45 c0 29 21 10 	movq   $0x102129,-0x40(%rbp)
  101ac3:	00 
            if (flags & FLAG_NEGATIVE) {
  101ac4:	eb 5f                	jmp    101b25 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101ac6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101ac9:	83 e0 08             	and    $0x8,%eax
  101acc:	85 c0                	test   %eax,%eax
  101ace:	74 55                	je     101b25 <printer_vprintf+0x7c4>
                prefix = " ";
  101ad0:	48 c7 45 c0 2b 21 10 	movq   $0x10212b,-0x40(%rbp)
  101ad7:	00 
            if (flags & FLAG_NEGATIVE) {
  101ad8:	eb 4b                	jmp    101b25 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101ada:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101add:	83 e0 20             	and    $0x20,%eax
  101ae0:	85 c0                	test   %eax,%eax
  101ae2:	74 42                	je     101b26 <printer_vprintf+0x7c5>
  101ae4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101ae7:	83 e0 01             	and    $0x1,%eax
  101aea:	85 c0                	test   %eax,%eax
  101aec:	74 38                	je     101b26 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  101aee:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101af2:	74 06                	je     101afa <printer_vprintf+0x799>
  101af4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101af8:	75 2c                	jne    101b26 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101afa:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101aff:	75 0c                	jne    101b0d <printer_vprintf+0x7ac>
  101b01:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b04:	25 00 01 00 00       	and    $0x100,%eax
  101b09:	85 c0                	test   %eax,%eax
  101b0b:	74 19                	je     101b26 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  101b0d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101b11:	75 07                	jne    101b1a <printer_vprintf+0x7b9>
  101b13:	b8 2d 21 10 00       	mov    $0x10212d,%eax
  101b18:	eb 05                	jmp    101b1f <printer_vprintf+0x7be>
  101b1a:	b8 30 21 10 00       	mov    $0x102130,%eax
  101b1f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101b23:	eb 01                	jmp    101b26 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101b25:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101b26:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101b2a:	78 24                	js     101b50 <printer_vprintf+0x7ef>
  101b2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b2f:	83 e0 20             	and    $0x20,%eax
  101b32:	85 c0                	test   %eax,%eax
  101b34:	75 1a                	jne    101b50 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  101b36:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101b39:	48 63 d0             	movslq %eax,%rdx
  101b3c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101b40:	48 89 d6             	mov    %rdx,%rsi
  101b43:	48 89 c7             	mov    %rax,%rdi
  101b46:	e8 ea f5 ff ff       	call   101135 <strnlen>
  101b4b:	89 45 bc             	mov    %eax,-0x44(%rbp)
  101b4e:	eb 0f                	jmp    101b5f <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  101b50:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101b54:	48 89 c7             	mov    %rax,%rdi
  101b57:	e8 a8 f5 ff ff       	call   101104 <strlen>
  101b5c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  101b5f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b62:	83 e0 20             	and    $0x20,%eax
  101b65:	85 c0                	test   %eax,%eax
  101b67:	74 20                	je     101b89 <printer_vprintf+0x828>
  101b69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101b6d:	78 1a                	js     101b89 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  101b6f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101b72:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  101b75:	7e 08                	jle    101b7f <printer_vprintf+0x81e>
  101b77:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  101b7a:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101b7d:	eb 05                	jmp    101b84 <printer_vprintf+0x823>
  101b7f:	b8 00 00 00 00       	mov    $0x0,%eax
  101b84:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101b87:	eb 5c                	jmp    101be5 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  101b89:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b8c:	83 e0 20             	and    $0x20,%eax
  101b8f:	85 c0                	test   %eax,%eax
  101b91:	74 4b                	je     101bde <printer_vprintf+0x87d>
  101b93:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101b96:	83 e0 02             	and    $0x2,%eax
  101b99:	85 c0                	test   %eax,%eax
  101b9b:	74 41                	je     101bde <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  101b9d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101ba0:	83 e0 04             	and    $0x4,%eax
  101ba3:	85 c0                	test   %eax,%eax
  101ba5:	75 37                	jne    101bde <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101ba7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101bab:	48 89 c7             	mov    %rax,%rdi
  101bae:	e8 51 f5 ff ff       	call   101104 <strlen>
  101bb3:	89 c2                	mov    %eax,%edx
  101bb5:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101bb8:	01 d0                	add    %edx,%eax
  101bba:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  101bbd:	7e 1f                	jle    101bde <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101bbf:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101bc2:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101bc5:	89 c3                	mov    %eax,%ebx
  101bc7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101bcb:	48 89 c7             	mov    %rax,%rdi
  101bce:	e8 31 f5 ff ff       	call   101104 <strlen>
  101bd3:	89 c2                	mov    %eax,%edx
  101bd5:	89 d8                	mov    %ebx,%eax
  101bd7:	29 d0                	sub    %edx,%eax
  101bd9:	89 45 b8             	mov    %eax,-0x48(%rbp)
  101bdc:	eb 07                	jmp    101be5 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  101bde:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101be5:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101be8:	8b 45 b8             	mov    -0x48(%rbp),%eax
  101beb:	01 d0                	add    %edx,%eax
  101bed:	48 63 d8             	movslq %eax,%rbx
  101bf0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101bf4:	48 89 c7             	mov    %rax,%rdi
  101bf7:	e8 08 f5 ff ff       	call   101104 <strlen>
  101bfc:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101c00:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101c03:	29 d0                	sub    %edx,%eax
  101c05:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101c08:	eb 25                	jmp    101c2f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101c0a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c11:	48 8b 08             	mov    (%rax),%rcx
  101c14:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101c1a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c21:	be 20 00 00 00       	mov    $0x20,%esi
  101c26:	48 89 c7             	mov    %rax,%rdi
  101c29:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101c2b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101c2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101c32:	83 e0 04             	and    $0x4,%eax
  101c35:	85 c0                	test   %eax,%eax
  101c37:	75 36                	jne    101c6f <printer_vprintf+0x90e>
  101c39:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101c3d:	7f cb                	jg     101c0a <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  101c3f:	eb 2e                	jmp    101c6f <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  101c41:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c48:	4c 8b 00             	mov    (%rax),%r8
  101c4b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101c4f:	0f b6 00             	movzbl (%rax),%eax
  101c52:	0f b6 c8             	movzbl %al,%ecx
  101c55:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101c5b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c62:	89 ce                	mov    %ecx,%esi
  101c64:	48 89 c7             	mov    %rax,%rdi
  101c67:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  101c6a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  101c6f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101c73:	0f b6 00             	movzbl (%rax),%eax
  101c76:	84 c0                	test   %al,%al
  101c78:	75 c7                	jne    101c41 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  101c7a:	eb 25                	jmp    101ca1 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  101c7c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c83:	48 8b 08             	mov    (%rax),%rcx
  101c86:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101c8c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101c93:	be 30 00 00 00       	mov    $0x30,%esi
  101c98:	48 89 c7             	mov    %rax,%rdi
  101c9b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  101c9d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101ca1:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101ca5:	7f d5                	jg     101c7c <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101ca7:	eb 32                	jmp    101cdb <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101ca9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101cb0:	4c 8b 00             	mov    (%rax),%r8
  101cb3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101cb7:	0f b6 00             	movzbl (%rax),%eax
  101cba:	0f b6 c8             	movzbl %al,%ecx
  101cbd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101cc3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101cca:	89 ce                	mov    %ecx,%esi
  101ccc:	48 89 c7             	mov    %rax,%rdi
  101ccf:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101cd2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101cd7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  101cdb:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101cdf:	7f c8                	jg     101ca9 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101ce1:	eb 25                	jmp    101d08 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101ce3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101cea:	48 8b 08             	mov    (%rax),%rcx
  101ced:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101cf3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101cfa:	be 20 00 00 00       	mov    $0x20,%esi
  101cff:	48 89 c7             	mov    %rax,%rdi
  101d02:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101d04:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101d08:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  101d0c:	7f d5                	jg     101ce3 <printer_vprintf+0x982>
        }
    done: ;
  101d0e:	90                   	nop
    for (; *format; ++format) {
  101d0f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101d16:	01 
  101d17:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101d1e:	0f b6 00             	movzbl (%rax),%eax
  101d21:	84 c0                	test   %al,%al
  101d23:	0f 85 64 f6 ff ff    	jne    10138d <printer_vprintf+0x2c>
    }
}
  101d29:	90                   	nop
  101d2a:	90                   	nop
  101d2b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  101d2f:	c9                   	leave  
  101d30:	c3                   	ret    

0000000000101d31 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  101d31:	55                   	push   %rbp
  101d32:	48 89 e5             	mov    %rsp,%rbp
  101d35:	48 83 ec 20          	sub    $0x20,%rsp
  101d39:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101d3d:	89 f0                	mov    %esi,%eax
  101d3f:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101d42:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  101d45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101d49:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101d4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101d51:	48 8b 40 08          	mov    0x8(%rax),%rax
  101d55:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  101d5a:	48 39 d0             	cmp    %rdx,%rax
  101d5d:	72 0c                	jb     101d6b <console_putc+0x3a>
        cp->cursor = console;
  101d5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101d63:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  101d6a:	00 
    }
    if (c == '\n') {
  101d6b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  101d6f:	75 78                	jne    101de9 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  101d71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101d75:	48 8b 40 08          	mov    0x8(%rax),%rax
  101d79:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101d7f:	48 d1 f8             	sar    %rax
  101d82:	48 89 c1             	mov    %rax,%rcx
  101d85:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  101d8c:	66 66 66 
  101d8f:	48 89 c8             	mov    %rcx,%rax
  101d92:	48 f7 ea             	imul   %rdx
  101d95:	48 c1 fa 05          	sar    $0x5,%rdx
  101d99:	48 89 c8             	mov    %rcx,%rax
  101d9c:	48 c1 f8 3f          	sar    $0x3f,%rax
  101da0:	48 29 c2             	sub    %rax,%rdx
  101da3:	48 89 d0             	mov    %rdx,%rax
  101da6:	48 c1 e0 02          	shl    $0x2,%rax
  101daa:	48 01 d0             	add    %rdx,%rax
  101dad:	48 c1 e0 04          	shl    $0x4,%rax
  101db1:	48 29 c1             	sub    %rax,%rcx
  101db4:	48 89 ca             	mov    %rcx,%rdx
  101db7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101dba:	eb 25                	jmp    101de1 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  101dbc:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101dbf:	83 c8 20             	or     $0x20,%eax
  101dc2:	89 c6                	mov    %eax,%esi
  101dc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101dc8:	48 8b 40 08          	mov    0x8(%rax),%rax
  101dcc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101dd0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101dd4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101dd8:	89 f2                	mov    %esi,%edx
  101dda:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  101ddd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101de1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101de5:	75 d5                	jne    101dbc <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101de7:	eb 24                	jmp    101e0d <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101de9:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  101ded:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101df0:	09 d0                	or     %edx,%eax
  101df2:	89 c6                	mov    %eax,%esi
  101df4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101df8:	48 8b 40 08          	mov    0x8(%rax),%rax
  101dfc:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101e00:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101e04:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101e08:	89 f2                	mov    %esi,%edx
  101e0a:	66 89 10             	mov    %dx,(%rax)
}
  101e0d:	90                   	nop
  101e0e:	c9                   	leave  
  101e0f:	c3                   	ret    

0000000000101e10 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101e10:	55                   	push   %rbp
  101e11:	48 89 e5             	mov    %rsp,%rbp
  101e14:	48 83 ec 30          	sub    $0x30,%rsp
  101e18:	89 7d ec             	mov    %edi,-0x14(%rbp)
  101e1b:	89 75 e8             	mov    %esi,-0x18(%rbp)
  101e1e:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101e22:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101e26:	48 c7 45 f0 31 1d 10 	movq   $0x101d31,-0x10(%rbp)
  101e2d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  101e2e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  101e32:	78 09                	js     101e3d <console_vprintf+0x2d>
  101e34:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  101e3b:	7e 07                	jle    101e44 <console_vprintf+0x34>
        cpos = 0;
  101e3d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  101e44:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101e47:	48 98                	cltq   
  101e49:	48 01 c0             	add    %rax,%rax
  101e4c:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  101e52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  101e56:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  101e5a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  101e5e:	8b 75 e8             	mov    -0x18(%rbp),%esi
  101e61:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  101e65:	48 89 c7             	mov    %rax,%rdi
  101e68:	e8 f4 f4 ff ff       	call   101361 <printer_vprintf>
    return cp.cursor - console;
  101e6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101e71:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  101e77:	48 d1 f8             	sar    %rax
}
  101e7a:	c9                   	leave  
  101e7b:	c3                   	ret    

0000000000101e7c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  101e7c:	55                   	push   %rbp
  101e7d:	48 89 e5             	mov    %rsp,%rbp
  101e80:	48 83 ec 60          	sub    $0x60,%rsp
  101e84:	89 7d ac             	mov    %edi,-0x54(%rbp)
  101e87:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101e8a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101e8e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101e92:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101e96:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101e9a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101ea1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101ea5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101ea9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101ead:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101eb1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101eb5:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101eb9:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101ebc:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101ebf:	89 c7                	mov    %eax,%edi
  101ec1:	e8 4a ff ff ff       	call   101e10 <console_vprintf>
  101ec6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101ec9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101ecc:	c9                   	leave  
  101ecd:	c3                   	ret    

0000000000101ece <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101ece:	55                   	push   %rbp
  101ecf:	48 89 e5             	mov    %rsp,%rbp
  101ed2:	48 83 ec 20          	sub    $0x20,%rsp
  101ed6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101eda:	89 f0                	mov    %esi,%eax
  101edc:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101edf:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101ee2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101ee6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101eea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101eee:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101ef2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101ef6:	48 8b 40 10          	mov    0x10(%rax),%rax
  101efa:	48 39 c2             	cmp    %rax,%rdx
  101efd:	73 1a                	jae    101f19 <string_putc+0x4b>
        *sp->s++ = c;
  101eff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101f03:	48 8b 40 08          	mov    0x8(%rax),%rax
  101f07:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101f0b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101f0f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101f13:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101f17:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101f19:	90                   	nop
  101f1a:	c9                   	leave  
  101f1b:	c3                   	ret    

0000000000101f1c <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101f1c:	55                   	push   %rbp
  101f1d:	48 89 e5             	mov    %rsp,%rbp
  101f20:	48 83 ec 40          	sub    $0x40,%rsp
  101f24:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101f28:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  101f2c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  101f30:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  101f34:	48 c7 45 e8 ce 1e 10 	movq   $0x101ece,-0x18(%rbp)
  101f3b:	00 
    sp.s = s;
  101f3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101f40:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  101f44:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  101f49:	74 33                	je     101f7e <vsnprintf+0x62>
        sp.end = s + size - 1;
  101f4b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  101f4f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  101f53:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  101f57:	48 01 d0             	add    %rdx,%rax
  101f5a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  101f5e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  101f62:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  101f66:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  101f6a:	be 00 00 00 00       	mov    $0x0,%esi
  101f6f:	48 89 c7             	mov    %rax,%rdi
  101f72:	e8 ea f3 ff ff       	call   101361 <printer_vprintf>
        *sp.s = 0;
  101f77:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101f7b:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  101f7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101f82:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101f86:	c9                   	leave  
  101f87:	c3                   	ret    

0000000000101f88 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101f88:	55                   	push   %rbp
  101f89:	48 89 e5             	mov    %rsp,%rbp
  101f8c:	48 83 ec 70          	sub    $0x70,%rsp
  101f90:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101f94:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101f98:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101f9c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101fa0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101fa4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101fa8:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101faf:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101fb3:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101fb7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101fbb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101fbf:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101fc3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101fc7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101fcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101fcf:	48 89 c7             	mov    %rax,%rdi
  101fd2:	e8 45 ff ff ff       	call   101f1c <vsnprintf>
  101fd7:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101fda:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101fdd:	c9                   	leave  
  101fde:	c3                   	ret    

0000000000101fdf <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101fdf:	55                   	push   %rbp
  101fe0:	48 89 e5             	mov    %rsp,%rbp
  101fe3:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101fe7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101fee:	eb 13                	jmp    102003 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101ff0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101ff3:	48 98                	cltq   
  101ff5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  101ffc:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101fff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  102003:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10200a:	7e e4                	jle    101ff0 <console_clear+0x11>
    }
    cursorpos = 0;
  10200c:	c7 05 e6 6f fb ff 00 	movl   $0x0,-0x4901a(%rip)        # b8ffc <cursorpos>
  102013:	00 00 00 
}
  102016:	90                   	nop
  102017:	c9                   	leave  
  102018:	c3                   	ret    
