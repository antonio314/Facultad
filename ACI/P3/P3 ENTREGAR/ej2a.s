	.file	"ej2a.c"
	.comm	y,200000000,32
	.comm	x,200000000,32
	.comm	i,4,4
	.section	.rodata
.LC2:
	.string	"%f \n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$48, %esp
	call	clock
	movl	%eax, 44(%esp)
	movl	$1, i
	jmp	.L2
.L3:
	movl	i, %eax
	movl	i, %edx
	flds	y(,%edx,4)
	movl	i, %edx
	flds	x(,%edx,4)
	fldl	.LC0
	fmulp	%st, %st(1)
	faddp	%st, %st(1)
	fstps	28(%esp)
	flds	28(%esp)
	fstps	y(,%eax,4)
	movl	i, %eax
	addl	$1, %eax
	movl	%eax, i
.L2:
	movl	i, %eax
	cmpl	$50000000, %eax
	jle	.L3
	call	clock
	movl	%eax, 40(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	difftime
	fldl	.LC1
	fdivrp	%st, %st(1)
	movl	$.LC2, %eax
	fstpl	4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1075052544
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
