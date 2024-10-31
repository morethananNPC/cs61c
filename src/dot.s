.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # Prologue
	li t0, 1
	blt a2, t0, exception1
	blt a3, t0, exception2
	blt a4, t0, exception2
	
	addi sp, sp, -12
	sw s0, 8(sp)
	sw s1, 4(sp)
	sw s2, 0(sp)
	li t0, 0	#i=0
	li t1, 4
	li t2, 4
	mul t1, t1, a3	#stride of v0
	mul t2, t2, a4	#stride of v1
	li s0, 0
	li s1, 0
	li s2, 0

loop_start:
	lw s1, 0(a0)
	lw s2, 0(a1)
	mul t3, s1, s2
	add s0, s0, t3
	addi t0, t0, 1	#i++
	add a0, a0, t1
	add a1, a1, t2
	beq t0, a2, loop_end 
	j loop_start	

loop_end:
	add a0, x0, s0
	lw s2, 0(sp)
	lw s1, 4(sp)
	lw s0, 8(sp)
	addi sp, sp, 12

    # Epilogue 
    ret

exception1:
	li a1, 75
	j exit2

exception2:
	li a1, 76
	j exit2
