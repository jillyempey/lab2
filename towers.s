	.arch armv6
	.fpu vfp
	.text

@ print function is complete, no modifications needed
    .global	print
print:
   /* (from, to)  */
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

startstring:
	.word	string0

    .global	towers
towers:
   /* 
      (numDiscs, start, goal)
      r0: numDiscs
      r1: start
      r2: goal 
      r4: 
      r5: temp
      r6: steps
               */
   /* Save callee-saved registers to stack */
   push {lr}
   push {r4}
   push {r5}
   push {r6}
   /*push {r4, r5,r6,lr}*/
   /* Save a copy of all 3 incoming parameters */
   push {r0}
   push {r1}
   push {r2}
   /*push {r0, r1, r2}*/
   /*mov r4, lr*/
if:
   /*and r1, r1, #0*/
  /* add r2, r0, #2*/
   
   /* Compare numDisks with 2 or (numDisks - 2)*/
      cmp r0, #2
   /* Check if less than, else branch to else */
      bge else
   /* set print function's start to incoming start */
      mov r0, r1
   /* set print function's end to goal */
      mov r1, r2
   /* call print function */
      bl print
   /* Set return register to 1 */
      mov r0, #1 
   /* branch to endif */
   b endif
else:

   /* Use a callee-saved varable for temp and set it to 6 (r5)*/
   /* Subract start from temp and store to itself */
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/
      mov r5, #6
      sub r5, r5, r1
      sub r5, r5, r2
   /* subtract 1 from original numDisks(r0) and store it to numDisks parameter */
      ldr r0, [sp, #8]
      sub r0, r0, #1
   /* Set end parameter as temp */
   /* Call towers function */
   /* Save result to callee-saved register for total steps(r6) */
   /* Set numDiscs parameter to 1 */
   /* Set start parameter to original start */
   /* Set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far */
      mov r2, r5
      bl towers
      mov r6, r0
      mov r0, #1
      ldr r1, [sp, #4]
      ldr r2, [sp, #0]
      bl towers
      add r6, r6, r0
   /* Set numDisks parameter to original numDisks - 1 */
   /* set start parameter to temp */
   /* set goal parameter to original goal */
   /* Call towers function */
   /* Add result to total steps so far and save it to return register */
     ldr r0, [sp, #8]
     sub r0, r0, #1
     mov r1, r5
     ldr r2, [sp, #0]
     bl towers
     add r6, r6, r0
     mov r0, r6
     
endif:
   /* Restore Registers    */
   pop {r2}
   pop {r1}
   add sp, sp, #4
   /*pop {r0}*/
   pop {r6}
   pop {r5}
   pop {r4}
   pop {pc}

   
@ Function main is complete, no modifications needed
    .global	main
main:
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r0, printdata
	bl	printf
	ldr	r0, printdata+4
	add	r1, sp, #12
	bl	scanf
	ldr	r0, [sp, #12]
	mov	r1, #1
	mov	r2, #3
	bl	towers
	str	r0, [sp]
	ldr	r0, printdata+8
	ldr	r1, [sp, #12]
	mov	r2, #1
	mov	r3, #3
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	ldr	pc, [sp], #4
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
here:
   .asciz   "here\n"
