.data
	next_line: .asciiz "\n"	
.text


jal input_int 
move $t1,$t4			

#input: X=The Starting address of input numbers (each 32bits) should be entered from
# terminal in decimal format. It is stored in $t2
jal input_int
move $t2,$t4

#input:Y= The Starting address of output numbers(each 32bits) should be entered
# from terminal in decimal. It is stored in $t3
#jal input_int
#move $t3,$t4 

#input: The numbers to be sorted are now entered from terminal.
# They are stored in memory array whose starting address is given by $t2
move $t8,$t2
move $s7,$zero	#i = 0
loop1:  beq $s7,$t1,loop1end
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1
        j loop1      
loop1end: move $t2,$t8  


move $s7,$zero
move $s6,$zero
subi $t1,$t1,1
move $t9,$t1
outerloop: 
	beq $s7,$t1, outerloopend
	sub $t9,$t1,$s7
	#addi $t9,$t9,1
	
	innerloop:

		
		beq $s6,$t9, innerloopend
		lw $s2,0($t2)
		addi $t6,$t2,4
		lw $s1,0($t6)
		
		slt $a0,$s2,$s1
		
		beq $a0,$zero,swap
		
		jal cont
		
	cont:
		addi $s6,$s6,1
		addi $t2,$t2,4
		jal innerloop
	
	swap:
		sw $s1,0($t2)
		sw $s2,0($t6)
		addi $s6,$s6,1
		addi $t2,$t2,4
		jal innerloop
	
	innerloopend:
	
	move $s6,$zero
	move $t2,$t8
	
	addi $s7,$s7,1
	
	jal outerloop
	
outerloopend:move $t2,$t8

move $s7,$zero	#i = 0
addi $t1,$t1,1
loop: beq $s7,$t1,end
      lw $t4,0($t2)
      jal print_int
      jal print_line
      addi $t2,$t2,4
      addi $s7,$s7,1
      j loop 
		



end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#print integer(prints the value of $t6 )
print_int: li $v0,1		#1 implie
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra
