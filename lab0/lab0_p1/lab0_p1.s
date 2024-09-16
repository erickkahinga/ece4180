	AREA MyData, DATA, READWRITE
answer SPACE 4 ;where you store the answer at the end
	
	AREA MYCODE, CODE 
		ENTRY
		EXPORT __main
		
;This subroutine calculates the Nth fibonacci number, where n is a value up to 15
;This subroutine should be EABI compliant following the ARM APCS specification
;There should be 1 argument into the function which is N, and 1 return value, which should 
;be the fibonacci number at the Nth index.
FIBONACCI
        MOV r4, #1			;init vars to 1
		MOV r5, #1
		MOV r7, #2			;start index at 3 b/c were calculating fib numbers from 3 to r1
		
LOOP
		ADD r7, r7, #1
		ADD r6, r4, r5
		MOV r4, r5			;updating the values of r4 & r5 to get the next fib number
		MOV r5, r6
		CMP r7, r0			;if r7 <= r0 then we haven't found the Nth fib number yet
		BLE LOOP
		
		MOV r0, r6			;R6 holds the Nth fib number. R0 returns the Nth fib num
		STR r6, [r1]
		
		B DONE
				
		
__main
		MOV r0, #0			;input parameter for subroutine(Nth fib number)
		
		LDR r1, answer		;load memory address of answer into r1
		
		CMP r0, #15			;branch to DONE if R0 > 15
		BGT DONE
		
		CMP r0, #2			;branch to FIBOANCCI if R0 > 2
		PUSH {r0, r1}
		BGT FIBONACCI
		
		;if r0 (Nth fib number) is <= 2 we can automatically return since it is the base for fib sequence
		CMP r0, #0			;branch if R0 = 0 b/c FIB(0) = 0
		BEQ EQUALS0
		
		CMP r0, #1			;branch to DONE if R0 = 1 b/c FIB(1) = 1
		BEQ EQUALS1
		
		CMP r0, #2			;branch to DONE if R0 = 2 b/c FIB(2) = 2
		BEQ EQUALS2

EQUALS0
		MOV r0, #0
		STR r0, [r1]
		BEQ DONE

EQUALS1
		MOV r0, #1
		STR r0, [r1]
		BEQ DONE

EQUALS2
		MOV r0, #1
		STR r0, [r1]

DONE
		END