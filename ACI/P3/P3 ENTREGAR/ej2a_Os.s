	.file	"ej2.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
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
	subl	$16, %esp
	call	clock
	movl	$y+4, %edx
	movl	$x+4, %ecx
	movl	%eax, %ebx
	flds	.LC0
	movl	$1, %eax
	jmp	.L2
.L3:
	fld	%st(0)
	incl	%eax
	fmuls	(%ecx)
	addl	$4, %ecx
	fadds	(%edx)
	fstps	(%edx)
	addl	$4, %edx
.L2:
	cmpl	$50000000, %eax
	jle	.L3
	fstp	%st(0)
	movl	%eax, i
	call	clock
	pushl	%ecx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	call	difftime
	popl	%eax
	popl	%edx
	fdivs	.LC1
	fstpl	(%esp)
	pushl	$.LC2
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
	.comm	y,200000000,4
	.comm	x,200000000,4
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
