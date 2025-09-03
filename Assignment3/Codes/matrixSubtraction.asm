.model small
.stack 100h

.data
    ; Define 2x2 matrices (row-wise)
    matA DB 01h, 02h, 14h, 90h    
    matB DB 15h, 09h, 07h, 08h    
    matAdd DB 4 dup(?)              
    
.code         

    MOV AX, @data;
    MOV DS, AX;
    LEA SI, matA;
    LEA DI, matB;
    LEA BX, matAdd;
    MOV CX, 4;
    AddLoop:
        MOV AL, [SI];
        SUB AL, [DI];
        MOV [BX], AL;
        INC BX;
        INC DI
        INC SI
            
    loop AddLoop;