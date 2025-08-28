.model small

.stack 100h

.data
arr DB 0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH;
len DB 06H

.code
    MOV AX, @data;
    MOV DS,AX
    LEA SI, arr;
    LEA CX, len;
    XOR AX, AX
    
    addition:
        ADD AL, [SI];
        ADC AH, 0;
        INC SI
    
    LOOP addition
    HLT
