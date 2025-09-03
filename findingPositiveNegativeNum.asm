.model small

.data
    series DB 1, 0, 0, -4, 5, -6, 7, -8, 9, -10;
    
.stack 100h

.code
    MOV AX, @data;
    MOV DS, AX
    XOR AX, AX;
    LEA SI, series;
    MOV CX, 10D;
    MOV BX, 0000H; BL --> POSI, BH -> NEGATIVE, DL --> 0ZERROS
    MOV DL, 00H;
 BACK:  
    MOV AL, [SI];
    ADD AL, 0;
    JZ zero
    ROL AL, 1;
    JC negative
    INC BL;
    JMP next;

 zero:
    INC DL;
    JMP next;

 negative: INC BH;
    JMP next;
  next: INC SI  


LOOP BACK     
HLT
    