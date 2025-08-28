.model small        

.stack 100h

.data          

.code
    ;8 bit addtion program;
    MOV AL, 10H;
    MOV CL, 10H
    MOV BL, CL;
    ADD BL, AL;
    ;Clearing the AL, CL, BL 16 bit addition 
    XOR AL, AL
    XOR CL, CL;
    XOR BL, BL
    MOV AX, 1020H
    MOV CX, 2024H
    MOV BX, CX;
    ADD BX, AX;
    ;8 bit Subtraction Program
    XOR AX, AX
    XOR CX, CX
    XOR BX, BX
    MOV AL, 20H
    MOV CL, 50H
    MOV BL, CL;
    SUB AL, BL;
    ;16 Bit Subtraction Program
    XOR AX, AX
    XOR CX, CX
    XOR BX, BX
    MOV AX, 1010H;
    MOV CX, 1000H
    MOV BX, CX
    SUB BX, AX;
    HLT








