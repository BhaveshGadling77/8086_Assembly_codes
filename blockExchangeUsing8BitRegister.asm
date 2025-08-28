.model small        

.stack 100h

.data
SRC DB 10H DUP(0AAH);
DEST DB 10H DUP(0BBH);

.code
    ;Block Exchange using 8 bit register.
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, SRC;
    LEA DI, DEST;
    MOV CX, 10H;
    
    back:
        MOV AL, [SI];
        MOV AH, [DI];
        MOV [DI], AL;
        MOV [SI], AH;
        INC SI
        INC DI
        DEC CX

    JNZ back
    HLT





