	.data 
sequence : .word 3,10,7,9,4,11
temp: .word  100
n : .word 6
fileName: .asciiz "C:/Users/TOPRAK/Desktop/ornek.txt"
fileWords: .space 1024
        .align 2    # word-aligned
array:  .space 40    # a word array of 10 elements


	.text
	.globl main
main:
	
	li $v0,13           	# open_file syscall code = 13
    	la $a0,fileName     	# get the file name
    	li $a1,0           	# file flag = read (0)
    	syscall
    	move $s0,$v0        	# save the file descriptor. $s0 = file
	
	#read the file
	li $v0, 14		# read_file syscall code = 14
	move $a0,$s0		# file descriptor
	la $a1,array 	# The buffer that holds the string of the WHOLE file
	la $a2,1000		# hardcoded buffer length
	syscall
	
	 #-------C++ CODE---------
	
	la $s7, sequence
	la $s6, temp
	addi $t4,$zero,0    #t4 = 0
	addi $t3,$zero,-1   # t3 = -1
	addi $t6,$zero,6     # t6 = n ;
	add $t0,$zero,$t6 
	addi $t4,$zero,1    # t4 = 1;
	sw $t4,0($s6)   # temp[0] = 1; t4 de  hazýr 1 varken onu kullandým.
loop:  
	bgt $t4,$t0,secondprocess   # t4 < t0 , 1< n
	add $t5,$t4,$zero        # t5 = t4;
	jal innerloop      
	addi $t4,$t4,1            # t4 = t4 + 1
	j loop

innerloop: 			#adress $ra
	bgt $t3,$t0,exitloop    #  t3< t0,   -1 < j 
	sll $t7,$t4,2
	add $t7,$t7,$s7
	lw $t2,0($t7)    # max = sequence[i], max = t2 
	
	sll $t7,$t5,2
	add $t7,$t7,$s7
	lw $s1,0($t7)
	
	bgt $s1,$t2,otherif
	sll $t7,$t5,2
	add $t7,$t7,$s7
	lw $s2,0($t7)
	bgt $t1,$s2,otherif
	add $t1,$zero,$s2
	j otherif

otherif:
	add $t5,$t5,$t3
	bne $t5,$zero,exitif
	sll $t7,$t4,2
	add $t7,$t7,$s6
	lw $s2,0($t7)      #$s2 = table[i] 
	addi $s2,$t1,1
	sll $t7,$t4,2
	add $t7,$t7,$s6
	sw $s2,0($t7)
	j exitif

exitif:
	add $t5,$t5,$t3
	j innerloop

exitloop:
	jr $ra

secondprocess:
	add $t4,$zero,$zero
	add $t5,$zero,$zero
	add $t3,$zero,$zero
	addi $t4,$zero,-1    # t4 = -1 
	add $t4,$t4,$t0    # t4 = currentsize-1
	j forloop

forloop: 
	slt $s6,$t4,$zero
	bne $s6, $zero, thirtprocess
	sll $t7,$t4,2
	add $t7,$t7,$s6
	lw  $t2 ,0($t7)   # max = temp[k];  k = t4
	bne $t1,$zero,else
	add $t1,$zero,$t2
	add $t1,$zero,$t4
	add $t0,$zero,$t1
	j increase_index

increase_index:
	addi $t4,$4,-1
	j forloop
else:
	slt $s5,$t1,$t2
	bne $s5,$zero,increase_index
	add $t1,$zero,$t2
	add $t1,$zero,$t4
	add $t0,$zero,$t1
	j increase_index

thirtprocess:
	sll $t7,$t3,2
	add $t7,$t7,$s7        #maxindex*4
	lw ,$s4,0($t7)  # = s4 sequence[maxindex]
	sll $t7,$t3,2
	add $t7,$t7,$s6   #maxindex*4
	lw $s3,0($t7)  # s3 =  table[maxindex]
	addi $s3,$s3,-1   # sequence [table[maxindex]-1] = Sequence[maxindex]
	sll $t7,$s3,2
	add $t7,$t7,$s7   # t7 = [Table[maxindex]-1]
	sw $s4,0($t7)  # 
	addi $t0,$zero,1
	add $s4,$zero,$t3
	j lastloop
lastloop:
	bge $zero,$s4,print
	sll $t7,$t4,2
	add $t7,$t7,$s6
	lw $s2,0($t7)
	add $t1,$zero,$s2
	sll $t7,$t3,2
	add $t7,$t7,$s6
	lw $s6,0($t7)
	sub $s6,$s6,$t0
	bne $s6,$t1,exitlastloop
	add $t1,$zero,$t4
	sll $t7,$t1,2
	add $t7,$t7,$s7
	lw $s1,0($t7)
	sll $t7,$s3,2
	add $t7,$t7,$s7
	sw $s1,0($t7)
	add $t0,$t0,$1
	j exitlastloop
	

exitlastloop:
	addi $s4,$s4,-1
	j lastloop

print:
	li $v0, 1
	move $a0,$t3
  	syscall            # write to file
	li $v0, 10
	syscall
	








