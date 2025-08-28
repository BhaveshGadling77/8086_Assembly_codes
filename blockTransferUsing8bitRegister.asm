;USING 8 bit register.
.model small        

.stack 100h

.data
SRC DB 10H DUP(0AAH);
DEST DB 10H DUP(?);

.code
    ;Block transfer using 8 bit register.
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, SRC;
    LEA DI, DEST;
    MOV CX, 10H;
    
    back:
        MOV AL, [SI];
        MOV [DI], AL;
        INC SI
        INC DI
        DEC CX
     
    JNZ back
    HLT



