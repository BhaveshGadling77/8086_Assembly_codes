.model small

.stack 100h

.data

.code
    ;shift left
    MOV AL, 0FFH;
    MOV CL, 04H
    SHL AL, CL;
    
    ;shift right
    MOV DL, 0FFH;
    MOV CL, 04H
    SHR DL, CL;
    HLT