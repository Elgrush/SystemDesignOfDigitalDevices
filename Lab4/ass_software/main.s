.text

.equ switches, 0x00002010
.equ leds,     0x00002000
.equ hex,     0x00000000
.global        _start

/* counter */
_start:  movia r2, switches
         movia r3, hex
         ldwio r4, 0(r2)
counter: addi  r4, r4, 1
         stwio r4, 0(r3)
         br    counter
		 
/* fibonacci */
/* r4 - 1st member */
/* r5 - 2nd member */
/* r6 - counter */
/*_start:  movia r2, switches*/
         movia r3, hex
		 mov   r4, r0
		 movi  r5, 1
         stwio r5, 0(r3)
		 ldwio r6, 0(r2)
		 
fibonacci: bleu  r6, r0, stop
           addi  r6, r6, -1
           
		   add   r4, r4, r5
           stwio r4, 0(r3)
		   
		   bleu  r6, r0, stop
           addi  r6, r6, -1
		   
		   add   r5, r4, r5
		   stwio r5, 0(r3)
		   br    fibonacci

stop: br stop
