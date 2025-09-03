.model small

.data
dividend DD 40000000H   ; 32-bit dividend
divisor  DW 8080H       ; 16-bit divisor

.stack 100h

.code
    MOV AX, @data
    MOV DS, AX

    LEA SI, dividend
    MOV AX, [SI]
    ADD SI, 2
    MOV DX, [SI]

    MOV CX, divisor

    DIV CX              ; DX_AX / CX = quotient in AX, remainder in DX
    HLT
    
