	.file	"ej2a.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%f \n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	pushl	%ebx
	subl	$44, %esp
	call	clock
	movl	%eax, %ebx
	movl	$1, %eax
	movl	$y, %edx
	movl	$x, %ecx
	flds	.LC0
.L2:
	fld	%st(0)
	fmuls	(%ecx,%eax,4)
	fadds	(%edx,%eax,4)
	fstps	(%edx,%eax,4)
	addl	$1, %eax
	cmpl	$50000001, %eax
	jne	.L2
	fstp	%st(0)
	movl	$50000001, i
	call	clock
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	difftime
	fdivs	.LC1
	fstpl	8(%esp)
	movl	$.LC2, 4(%esp)
	movl	$1, (%esp)
	call	__printf_chk
	movl	$0, %eax
	addl	$44, %esp
	popl	%ebx
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main, .-main
	.comm	y,200000000,32
	.comm	x,200000000,32
	.comm	i,4,4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	1084227584
	.align 4
.LC1:
	.long	1232348160
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
