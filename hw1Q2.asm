.data
	NextLine: .asciiz "\n"
	Success: .asciiz "\nSuccess! Location: "
	Failure: .asciiz "\nFail!\n"
	userInput: .space 128
.text
	main:
		readSentence:
		# getting user's
			li $v0, 8
			la $a0, userInput
			li $a1, 128
			syscall
		
			la $s0, ($a0)
			j readChar
		
		readChar:
			li $v0,12
            syscall
            la $s1, ($v0)
            li $t0, '?'	
            beq $v0, $t0, EXIT
        	add $s2, $zero, $zero
        	j findChar
        #s0: start of the string, s1: wanted char, s2: counter
        	findChar:
        	addu $t0, $s0, $s2  
        	addi $s2, $s2, 1
        	
        	li $t1, '\n'
        	lbu $t2,($t0)
        	beq $t1, $t2, returnFail
        	beq $s1, $t2, returnSuccess
        	j findChar
        	returnSuccess:
        	li $v0, 4
			la $a0, Success
			syscall
			
			li $v0, 1
			la $a0, ($s2)
			syscall
			
			li $v0, 4
			la $a0, NextLine
			syscall
			j readChar
        	
        	returnFail:
			li $v0, 4
			la $a0, Failure
			syscall
			j readChar
		EXIT:
	li $v0, 10
	syscall
	
