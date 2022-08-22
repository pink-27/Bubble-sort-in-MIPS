.data
	next_line: .asciiz "\n"	
.text


jal input_int  #input the value of 'n' and store it in $t1.
move $t1,$t4			

#base address of the input array will be stored in $t2.
jal input_int
move $t2,$t4

#base address of the output array will be stored in $t2.
jal input_int
move $t3,$t4 


move $t8,$t2 #t8 will store the inital content of $t2 as backup becuase $t2 value would change along the code.
move $s7,$zero	#$s7 = i = 0
#this loop will account for the inputs
loop1:  beq $s7,$t1,loop1end #if $s7==$t1: goto loopend
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1 # $s7++
        j loop1      
loop1end: move $t2,$t8   

move $s7, $zero #$s7 = i = 0 
move $t8,$t3 #t8 will store the inital content of $t3 as backup becuase $t3 value would change along the code.
final_arr_loop: beq $s7,$t1,loopend2 #if $s7==$t1: goto loopend2
		jal res_triplet
		sw $t4,0($t3) #storing the resultant sum in the memory location whose address is stored in $t3
		addi $t3,$t3,4 #incrementing the output base address by 4 in each iteration
		addi $t2,$t2,4 #incrementing the input base address by 4 in each iteration
		addi $s7,$s7,3 
		j final_arr_loop
loopend2: move $t3,$t8   
		
		

move $s7,$zero	
loop_print: beq $s7,$t1,end #s7==$t1: goto end
      lw $t4,0($t3) 
      jal print_int
      jal print_line
      addi $t3,$t3,4
      addi $s7,$s7,3
      j loop_print 

#end
end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#prints integer
print_int: li $v0,1		
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra


res_triplet:  #function to compute the sum of three consecutive elements 
	lw $t4,0($t2) #storing the 1st 2nd and 3rd element from the input array in $t2,$t5,$6
	addi,$t2,$t2,4
	lw $t5,0($t2)
	addi,$t2,$t2,4
	lw $t6,0($t2)
	add $t6,$t6,$t5
	add $t4,$t6,$t4 #storing there sum in $t4s
	bltz $t4,abz #if $t4<0: goto abz
	
	jr $ra
	abz:negu $t4,$t4 #$t4=-$t4
	jr $ra
		
