.model small
.stack 100h

.data
    fact    DW 9        ; change this to compute other factorials
    resultL DW ?         ; low word of result
    resultH DW ?         ; high word of result

.code
start:
    MOV AX, @data
    MOV DS, AX

    MOV AX, fact
    CALL factorial32
    MOV resultL, AX
    MOV resultH, DX

    HLT

factorial32:
    CMP AX, 1
    JG f_recurse
    MOV AX, 1
    XOR DX, DX
    RET

f_recurse:
    PUSH AX           ; save n
    DEC AX
    CALL factorial32  ; returns (n-1)! in DX:AX
    POP BX            ; BX = n

    ; move DX:AX -> SI (low) and DI (high) safely
    PUSH DX
    PUSH AX
    POP SI            ; SI = low word (AX)
    POP DI            ; DI = high word (DX)

    ; low * n
    MOV AX, SI
    MUL BX            ; DX:AX = SI * BX
    MOV CX, AX        ; CX = low 16 bits of low*BX
    PUSH DX           ; push carry (high 16 bits of low*BX)

    ; high * n
    MOV AX, DI
    MUL BX            ; DX:AX = DI * BX
    POP SI            ; SI = carry from low*BX
    ADD DX, SI        ; add carry into high part
    MOV AX, CX        ; AX = final low 16 bits
    RET

END start
