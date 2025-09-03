.model small
.stack 100h

.data
    ; Define 2x2 matrices (row-wise)
    matA DB 01h, 02h, 03h, 04h    ; [1 2; 3 4]
    matB DB 05h, 06h, 07h, 08h    ; [5 6; 7 8]
    matAdd DB 4 dup(?)            ; result of addition  
    
.code         

    MOV AX, @data;
    MOV DS, AX;
    LEA SI, matA;
    LEA DI, matB;
    LEA BX, matAdd;
    MOV CX, 4;
    AddLoop:
        MOV AL, [SI];
        ADD AL, [DI];
        MOV [BX], AL;
        INC BX;
        INC DI
        INC SI
            
    loop AddLoop;        