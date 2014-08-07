	.data

.global _a

	.align 4
_a:
	.float 0.000000000000
.global _b
	.align 4
_b:
	.float 1.000000000000
.global _c
	.align 4
_c:
	.float 1.000000000000
.global _d
	.align 4
_d:
	.float -1.000000000000

	.text

.global _main
_main:
	addui r31, r0, #10 ; Esto es el número de iteraciones
loop:
	lhi r4,(_a>>16)&0xffff
	lhi r5,(_b>>16)&0xffff
	addui r4,r4,(_a&0xffff)
	addui r5,r5,(_b&0xffff)
	lf f4,0(r4)
	lf f5,0(r5)
	lhi r6,(_c>>16)&0xffff
	lhi r7,(_d>>16)&0xffff
	multf f9,f4,f5
	addf f8,f4,f5
	addui r6,r6,(_c&0xffff)
	addui r7,r7,(_d&0xffff)
	lf f6,0(r6)
	lf f7,0(r7)
	multf f15,f8,f9
	addf f10,f6,f7
	multf f11,f6,f7
	addf f12, f8, f10
	multf f13, f9,f11
	sf 0(r4),f12
	multf f14, f10,f11
	addf f4,f13,f12
	addf f16,f15,f14
	sf 0(r7),f4
	sf 0(r6),f14
	sf 0(r5),f16
	subui r31, r31, #1 ; decrememnto de 1 en 1
	bnez r31, loop
L1:
	trap #0
	nop