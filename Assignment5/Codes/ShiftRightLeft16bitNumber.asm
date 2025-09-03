.model small

.stack 100h

.data

.code
    
    MOV AX, 0FFFFH;
    MOV CL, 04H
    
    MOV DX, 0FFFFH;
    MOV CL, 04H;
    ;shift left
    SHL AX, CL;
    ;shift right
    SHR DX, CL;
    HLT