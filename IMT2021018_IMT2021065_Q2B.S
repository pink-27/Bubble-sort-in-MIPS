.globl main

.equ N, 12


.text
main:
    li t0, 0x80001400       //I wrote down the 10 inputs in register t1 and t2 and then saved in memory locations.
    li t1, 27
    li t2, 35
    sw t1, 0(t0)            //saving t1 in memory location
    sw t2, 4(t0)            //saving t2 in memory location

    li t0, 0x80001410       //similarly for the remaining inputs after updating the memory location.
    li t1, 88
    li t2, 66
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001420
    li t1, 10
    li t2, 44
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001430
    li t1, 33
    li t2, 99
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001440
    li t1, 101
    li t2, 42
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001450
    li t1, 23
    li t2, 69
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001460
    li t1, 7
    li t2, 29
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001470
    li t1, 90
    li t2, 122
    sw t1, 0(t0)
    sw t2, 4(t0)
    
    li t0, 0x80001480
    li t1, 21
    li t2, 121
    sw t1, 0(t0)
    sw t2, 4(t0)

    li t0, 0x80001490
    li t1, 199
    li t2, 99
    sw t1, 0(t0)
    sw t2, 4(t0)

    //storing inputs end here.

    li t0,0x80001400            //storing the initial address back to t0.
    li t5, 0                    //creating a counter to iterate the program 10 times.
    li s1, 10
    LOOP:
        beq t5, s1, OVER        //loop will continue till t5=s1(10 times) after which it jumps to OVER.
        lw t1, 0(t0)            //in register t1 we load value at 0x80001400
        lw t2, 4(t0)            //in register t2 we load value at 0x80001404

    WHILE:
        rem t3, t2, t1          //in register t3, we load the remainder of t2 and t1.
        beq t3, zero, DONE      //if remainder is 0, we jump to DONE.

        mv t2, t1               //move the value of t1 to t2.
        mv t1, t3               //move the value of t3 to t1.
        j WHILE

    DONE:                       // t1 is the gcd
        sw t1, 8(t0)            //store it in memory location
        addi t0, t0, 16         //increment the base address by 16
        addi t5, t5, 1          //increment the counter by 1.
        j LOOP
    OVER:
    j .
