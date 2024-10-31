.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

	#verify command line arguments





	# =====================================
    # LOAD MATRICES
    # =====================================
	li t0, 4
	bne a0, t0, exit_89
	addi sp, sp, -
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)

	mv s0, a1
	mv s1, a2




    # Load pretrained m0
	li a0, 8
	jal malloc
	beq a0, x0, exit_88
	mv s2, a0	#pointer to rows and cols of m0
	addi a1, s2, 0
	addi a2, s2, 4
	lw a0, 4(s0)
	jal read_matrix
	mv s3, a0	#s3->m0





    # Load pretrained m1
	li a0, 8
	jal malloc
	beq a0, x0, exit_88
	mv s4, a0	#s4-> m1.rows, m1.cols
	addi a1, s4, 0
	addi a2, s4, 4
	lw a0, 8(s0)
	jal read_matrix
	mv s5, a0	#s5->m1





    # Load input matrix
	li a0, 8
	jal malloc
	beq a0, x0, exit_88
	mv s6, a0	#s6->input.rows, input.cols
	addi a1, s6, 0
	addi a2, s6, 4
	lw a0, 12(s0)
	jal read_matrix
	mv s7, a0	#s7->input 





    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
	
	#1. linear layer
	#allocate memory for result
	lw t0, 0(s2)
	lw t1, 4(s6)
	mul a0, t0, t1	#total elements in result
	slli a0, a0, 2
	jal malloc
	beq a0, x0, exit_88
	mv s8, a0	#s8-> m0*input
	#hidden layer = m0*input
	mv a0, s3
	lw a1, 0(s2)
	lw a2, 4(s2)
	mv a3, s7
	lw a4, 0(s6)
	lw a5, 4(s6)
	mv a6, s8
	jal matmul

	#2. nonlinear layer
	lw t0, 0(s2)
	lw t1, 4(s6)
	mul a1, t0, t1
	mv a0, s8
	jal relu

	#3.linear layer
	#allocate memory for m1*Relu(m0*input)
	lw t0, 0(s4)
	lw t1, 4(s6)
	mul a0, t0, t1
	slli a0, a0, 2
	jal malloc
	beq a0, x0, exit_88
	mv s9, a0	#s9->scores
	#scores=m1*hidden_layer
	mv a0, s5
	lw a1, 0(s4)
	lw a2, 4(s4)
	mv a3, s8
	lw a4, 0(s2)
	lw a5, 4(s6)
	mv a6, s9
	jal matmul










    


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix





    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax




    # Print classification
    



    # Print newline afterwards for clarity




    ret
