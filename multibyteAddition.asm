.model small

.stack 100h

.data
num1 DB 030H, 0F0H, 0FFH, 0FFh, 0FFH;
num2 DB 020H, 0F0H, 0FFH, 0FFH, 0FFH;
res DB 6 dup(?); defined 6 bytes for the res so that result should not overflow.

.code
    MOV AX, @data
    MOV DS, AX;
    LEA SI, num1 + 4;
    LEA DI, num2 + 4;
    LEA BX, res + 5;
    MOV CX, 0005H;
    CLC
    addition:
        MOV AL, [SI]
        MOV DL, [DI]
        ADC AL, DL
        MOV [BX], AL;
        DEC BX
        DEC SI
        DEC DI
    
    LOOP addition
    carry_not_found:
        MOV [BX], 01H;
        HLT
    JC carry_not_found
    MOV [BX], 00H;

    HLT


