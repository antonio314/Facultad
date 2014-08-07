	.file	"ej1a.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%f \n"
	.text
.globl main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	call	clock
	movl	$1, %edx
	movl	%eax, %ebx
	movl	i, %eax
	jmp	.L2
.L4:
	xorl	%eax, %eax
.L3:
	imull	$3, s+4(%eax), %ecx
	sall	s(%eax)
	movl	%ecx, s+4(%eax)
	addl	$8, %eax
	cmpl	$4000, %eax
	jne	.L3
	incl	%edx
	movw	$500, %ax
.L2:
	cmpl	$100000, %edx
	jle	.L4
	movl	%edx, ii
	movl	%eax, i
	call	clock
	pushl	%ecx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	call	difftime
	popl	%eax
	popl	%edx
	fdivs	.LC0
	fstpl	(%esp)
	pushl	$.LC1
	pushl	$1
	call	__printf_chk
	leal	-8(%ebp), %esp
	xorl	%eax, %eax
	popl	%ecx
	popl	%ebx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.comm	s,4000,4
	.comm	ii,4,4
	.comm	i,4,4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1232348160
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
