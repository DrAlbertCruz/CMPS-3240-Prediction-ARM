# A faxpy() solution in ARMv8. Uses 2-lane SIMD operations, and a pre-test loop
.text
#	Arg	Reg	Note
#	1	w0	'n' - length of arrays
#	2	x1	*x
#	3	x2	*y
#	4	x3	*result
.global faxpy
faxpy:
	stp	x29, x30, [sp, -16]!
	add	x29, sp, 0

# Counter 'i'
	mov	w4, 0
# Pre-test
_looptop:
	ld1	{v0.2s}, [x1], 8
	ld1	{v1.2s}, [x2], 8
	fadd	v2.2s, v0.2s, v1.2s
	st1	{v2.2s}, [x3], 8
	add	w4, w4, 2
	cmp	w4, w0
	bne	_looptop

	ldp	x29, x30, [sp], 16
	ret
