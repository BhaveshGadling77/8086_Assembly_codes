.model small        

.stack 100h

.data
SRC DW 10H DUP(0AAAAH);
DEST DW 10H DUP(0BBBBH);

.code
    ;Block exchange using 16 bit register.
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, SRC;
    LEA DI, DEST;
    MOV CX, 10H;
    
    back:
        MOV AX, [SI];
        MOV BX, [DI];
        MOV [DI], AX;
        MOV [SI], BX;
        INC SI
        INC SI
        INC DI
        INC DI
        DEC CX
     
    JNZ back
    HLT




