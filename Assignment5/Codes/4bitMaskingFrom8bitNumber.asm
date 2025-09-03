.model small 

.stack 100h

.data

.code
    XOR AX,AX;
    XOR BX, BX
    XOR CX, CX;
    XOR DX, DX 
    MOV AL, 0FFH;
    MOV BL, 00FH;
    MOV CL, 0FFH;
    MOV DL, 0F0H;
    AND CL, DL
    
    AND AX, BX;
