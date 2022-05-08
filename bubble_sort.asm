.data
	next_line: .asciiz "\n"	
.text

#base address of the input array will be stored in $t2.
jal input_int 
move $t1,$t4			

#base address of the input array will be stored in $t2.
jal input_int
move $t2,$t4


move $t8,$t2
#this loop will take in the input of our unsorted array
move $s7,$zero	#i = 0 = $s7
loop1:  beq $s7,$t1,loop1end
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1 #s7++
        j loop1      
loop1end: move $t2,$t8  


move $s7,$zero #i = 0 = $s7
move $s6,$zero #j = 0 = $s6
subi $t1,$t1,1 #n=n-1
move $t9,$t1
outerloop: 
	beq $s7,$t1, outerloopend #if i==n-1: goto outerloopend
	sub $t9,$t1,$s7
	
	innerloop:

		
		beq $s6,$t9, innerloopend #if j==n-1-i: goto innerloopend
		lw $s2,0($t2)
		addi $t6,$t2,4
		lw $s1,0($t6)
		
		slt $a0,$s2,$s1
		
		beq $a0,$zero,swap #swap if arr[j]>arr[j+1]
		
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
#input from command line
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
