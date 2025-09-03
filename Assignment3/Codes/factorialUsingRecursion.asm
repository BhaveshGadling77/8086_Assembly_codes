.model small
.stack 100h

.data
    fact    DW 5  ; number for factorial
    result  DW ?  ; to store result

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AX, fact   ; put n in AX
    CALL factorial  ; call recursive factorial
    MOV result, AX  ; store result

    HLT               

factorial:
    CMP AX, 1 ; if n <= 1 ?
    JG recurse ; if >1, recurse
    MOV AX, 1 ; else return 1
    RET

recurse:
    PUSH AX; save n
    DEC AX; n-1
    CALL factorial ; call factorial(n-1), result in AX
    POP BX; restore n
    MUL BX; AX = AX * n   (16-bit result)
    RET
