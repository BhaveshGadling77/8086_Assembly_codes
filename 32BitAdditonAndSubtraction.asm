.model small        

.stack 100h

.data

.code
    ;32 Bit addition
    ;Num1 of 4bytes in register.
    ;consider Ax is lower 2 bytes of Num1
    ;BX will store the higher 2 bytes of Num2
    MOV AX, 1020H;
    MOV BX, 1012H;
    ;Num2 of 4 bytes in registers.       
    ;consider CX is lower 2 bytes of Num2
    ; DX will store the higher 2 bytes of 
    MOV CX, 0FFFFH
    MOV DX, 1944H;
    ;additing 2 lower bytes.
    ADD AX, CX;
    ADC BX, DX;
    
    ;32 bit subtraction
    ;Num1 of 4bytes in register
    ;consider Ax is lower 2 bytes of Num1
    ;BX will store the higher 2 bytes of Num2
    MOV AX, 1020H;
    MOV BX, 1012H;
    ;Num2 of 4 bytes in registers.       
    ;consider CX is lower 2 bytes of Num2
    ; DX will store the higher 2 bytes of 
    MOV CX, 0FFFFH
    MOV DX, 1944H;
    ;subtracting 2 lower bytes.
    SUB AX, CX;
    ;subtracting 2 higher bytes.
    SBB BX, DX;

    HLT