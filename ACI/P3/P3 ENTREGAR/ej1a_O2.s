	.file	"ej1a.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%f \n"
	.text
	.p2align 4,,15
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	pushl	%ebx
	subl	$28, %esp
	call	clock
	xorl	%ecx, %ecx
	movl	%eax, %ebx
	.p2align 4,,7
	.p2align 3
.L3:
	xorl	%eax, %eax
	.p2align 4,,7
	.p2align 3
.L2:
	movl	s+4(%eax), %edx
	sall	s(%eax)
	leal	(%edx,%edx,2), %edx
	movl	%edx, s+4(%eax)
	addl	$8, %eax
	cmpl	$4000, %eax
	jne	.L2
	addl	$1, %ecx
	cmpl	$100000, %ecx
	jne	.L3
	movl	$500, i
	movl	$100001, ii
	call	clock
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	difftime
	movl	$.LC1, 4(%esp)
	movl	$1, (%esp)
	fdivs	.LC0
	fstpl	8(%esp)
	call	__printf_chk
	addl	$28, %esp
	xorl	%eax, %eax
	popl	%ebx
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main, .-main
	.comm	s,4000,32
	.comm	ii,4,4
	.comm	i,4,4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1232348160
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
