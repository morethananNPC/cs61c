.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:
	li t0, 1
	blt a1, t0, exception72
	blt a2, t0, exception72
	blt a4, t0, exception73
	blt a5, t0, exception73
	bne a2, a4, exception74
    # Error checks

	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 24(sp)
	sw s1, 20(sp)
	sw s2, 16(sp)
	sw s3, 12(sp)
	sw s4, 8(sp)
	sw s5, 4(sp)
	sw s6, 0(sp)
	
	mv s0, a0
	mv s1, a1
	mv s2, a2
	mv s3, a3
	mv s4, a4
	mv s5, a5
	mv s6, a6

	li t0, 0	#i=0
outer_loop_start:
	li t1, 0	#j=0


inner_loop_start:
	mv a0, s0
	li t2, 4
	mul t2, t2, t1	
	add a1, s3, t2	#the start address of column vector 
	mv a2, s2
	li a3, 1
	mv, a4, s5
	#prologue(the value of t0 and t1 will be changed during calling the function dot)
	addi sp, sp, -8
	sw t0, 4(sp)
	sw t1, 0(sp)
	jal dot
	ebreak

	sw a0, 0(s6)
	addi s6, s6, 4

	#epilogue
	lw t0, 4(sp)
	lw t1, 0(sp)
	addi sp, sp, 8	
	addi t1, t1, 1	#j++
	beq t1, s5, inner_loop_end	#for this i, the inner loop ends, start the next loop.
	j inner_loop_start 	

inner_loop_end:
	addi t0, t0, 1
	beq t0, s1, outer_loop_end
	li t2, 4
	mul t2, t2, s2
	add	s0, s0, t2	#load next line's first element's address to s0"
	j outer_loop_start




outer_loop_end:


    # Epilogue
   	lw ra, 28(sp)
	lw s0, 24(sp)
	lw s1, 20(sp)
	lw s2, 16(sp)
	lw s3, 12(sp)
	lw s4, 8(sp)
	lw s5, 4(sp)
	lw s6, 0(sp)
	addi sp, sp, 32 
    
    ret

exception72:
	li a1, 72
	j exit2

exception73:
	li a1, 73
	j exit2

exception74:
	li a1, 74
	j exit2
