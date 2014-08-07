	.file	"ej1a.c"
	.comm	s,4000,32
	.comm	ii,4,4
	.comm	i,4,4
	.section	.rodata
.LC1:
	.string	"%f \n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	call	clock
	movl	%eax, 28(%esp)
	movl	$1, ii
	jmp	.L2
.L5:
	movl	$0, i
	jmp	.L3
.L4:
	movl	i, %eax
	movl	i, %edx
	movl	s(,%edx,8), %edx
	addl	%edx, %edx
	movl	%edx, s(,%eax,8)
	movl	i, %ecx
	movl	i, %eax
	movl	s+4(,%eax,8), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	movl	%eax, s+4(,%ecx,8)
	movl	i, %eax
	addl	$1, %eax
	movl	%eax, i
.L3:
	movl	i, %eax
	cmpl	$499, %eax
	jle	.L4
	movl	ii, %eax
	addl	$1, %eax
	movl	%eax, ii
.L2:
	movl	ii, %eax
	cmpl	$100000, %eax
	jle	.L5
	call	clock
	movl	%eax, 24(%esp)
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	difftime
	fldl	.LC0
	fdivrp	%st, %st(1)
	movl	$.LC1, %eax
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
	.long	1093567616
	.ident	"GCC: (Ubuntu/Linaro 4.4.4-14ubuntu5) 4.4.5"
	.section	.note.GNU-stack,"",@progbits
