.data
 	StarToSend: .asciiz "\n*\n"
 	UpperCase: .asciiz "\nAlpha   \n","\nBravo   \n","\nChina   \n","\nDelta   \n","\nEcho    \n","\nFoxtrot \n","\nGolf    \n","\nHotel   \n","\nIndia   \n","\nJuliet  \n","\nKilo    \n","\nLima    \n","\nMary    \n","\nNovember\n","\nOscar   \n","\nPaper   \n","\nQuebec  \n","\nResearch\n","\nSierra  \n","\nTango   \n","\nUniform \n","\nVictor  \n","\nWhisky  \n","\nX-ray   \n","\nYankee  \n","\nZulu    \n"
	LowerCase: .asciiz "\nalpha   \n","\nbravo   \n","\nchina   \n","\ndelta   \n","\necho    \n","\nfoxtrot \n","\ngolf    \n","\nhotel   \n","\nindia   \n","\njuliet  \n","\nkilo    \n","\nlima    \n","\nmary    \n","\nnovember\n","\noscar   \n","\npaper   \n","\nquebec  \n","\nresearch\n","\nsierra  \n","\ntango   \n","\nuniform \n","\nvictor  \n","\nwhisky  \n","\nx-ray   \n","\nyankee  \n","\nzulu    \n"
 	CaseWordLength: .word 11
 	
 	Number:	.asciiz "\nzero   \n","\nFirst  \n","\nSecond \n","\nThird  \n","\nFourth \n","\nFifth  \n","\nSixth  \n","\nSeventh\n","\nEighth \n","\nNinth  \n"
	NumberLength: .word 10

    
.text
	main:
        	readAndCategorize:
        	
            li $v0,12
            syscall
			
            li $s0, '?'	
            beq $v0, $s0, EXIT
			
			li $s0, 'z'
			bgt $v0, $s0, sendStar
			
			li $s0, 'a'
			bge $v0, $s0, lowerCase
			
			li $s0, 'Z'
			bgt $v0, $s0, sendStar
			
			li $s0, 'A'
			bge $v0, $s0, upperCase
			
			li $s0, '9'
			bgt $v0, $s0, sendStar
			
			li $s0, '0'
			bge $v0, $s0, number
			
			j sendStar
	
		sendStar: # send a star when it is neither a number nor a letter
			li $v0, 4
			la $a0, StarToSend
			syscall
			j readAndCategorize
		lowerCase:
			sub $t0, $v0, $s0
			lw $t1, CaseWordLength
			mul $t0, $t0, $t1
			
			li $v0, 4
			la $a0, LowerCase
			add $a0, $a0, $t0
			syscall
			j readAndCategorize
			
		upperCase:
			sub $t0, $v0, $s0
			lw $t1, CaseWordLength
			mul $t0, $t0, $t1
			
			li $v0, 4
			la $a0, UpperCase
			add $a0, $a0, $t0
			syscall
			j readAndCategorize
			
		number:
			sub $t0, $v0, $s0
			lw $t1, NumberLength
			mul $t0, $t0, $t1
			
			li $v0, 4
			la $a0, Number
			add $a0, $a0, $t0
			syscall
			j readAndCategorize
		EXIT:
	        
	li $v0, 10
	syscall
