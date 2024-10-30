.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
	li t0, 1
	bge a1, t0, no_exception
	li a1, 78
	j exit2

no_exception:
	add t0, x0, x0
loop_start:
	addi sp, sp, -4
	sw a0, 0(sp)
	slli t2, t0, 2
	add a0, a0, t2
	lw t1, 0(a0)
	bge t1, x0, loop_continue
	sw x0, 0(a0)    

loop_continue:
	#addi a0, a0, 4
	lw a0, 0(sp)
	addi sp, sp, 4
	addi t0, t0, 1
	bge t0, a1, loop_end
	j loop_start


loop_end:
	ret
