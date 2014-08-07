
	.data

	.global a
a:      .double 3.14159265358979

	.global x
x:      .double 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	.double 17,18,19,20,21,22,23

	.global xtop
xtop:   .double 24


	.text 
      .align 4

start:  ld      f2,a
	add     r1,r0,xtop
      add     r2,r0,#6
	ld      f0,0(r1)
	ld      f6,-8(r1)
	ld      f10,-16(r1)
	ld      f14,-24(r1)
	j       input

loop:	sd      0(r1),f4
	sd      -8(r1),f8
	sd      -16(r1),f12
	sd      -24(r1),f16
	sub     r1,r1,#32
	ld      f0,0(r1)
	ld      f6,-8(r1)
	ld      f10,-16(r1)
	ld      f14,-24(r1)


input:	multd   f4,f0,f2
	multd   f8,f6,f2
	multd   f12,f10,f2
	multd   f16,f14,f2

	sub     r2,r2,#1
	bnez    r2,loop

	sd      0(r1),f4
	sd      -8(r1),f8
	sd      -16(r1),f12
	sd      -24(r1),f16

	nop
	trap    #0

