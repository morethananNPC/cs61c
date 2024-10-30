.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
	li t0, 1
	bge a1, t0, no_exception
	li a1, 77
	j exit2

no_exception:
	addi t0, x0, 1
	add t1, x0, x0

loop_start:
	slli t2, t1, 2
	slli t3, t0, 2
	add t4, a0, t2
	addi sp, sp, -4
	sw a0, 0(sp)	
	add a0, a0, t3
	lw t3, 0(a0)	#a[i]
	lw t2, 0(t4)	#current max	
	bge t2, t3, loop_continue
	add t1, t0, x0

loop_continue:
	lw a0, 0(sp)
	addi sp, sp, 4
	addi t0, t0, 1
	bge t0, a1, loop_end
	j loop_start

loop_end:
    add a0, t1, x0

    # Epilogue


    ret
