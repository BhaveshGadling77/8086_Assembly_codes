 .model small        

.stack 100h

.data
SRC DW 10H DUP(0ABCDH);
DEST DW 10H DUP(?);

.code
    ;Block transfer using 8 bit register.
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, SRC;
    LEA DI, DEST;
    MOV CX, 0005H;
    
    back:
        MOV AX, [SI];
        MOV [DI], AX
        INC SI
        INC SI
        INC DI
        INC DI
        DEC CX
        
    JNZ back
    HLT
               



