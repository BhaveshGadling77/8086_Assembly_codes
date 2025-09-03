.model small

.stack 100h

.data
    even DB "It is Even Number!$";
    odd DB "It is Odd Number!$";
    num DB 15H;
    
.code
    MOV BX, @data
    MOV DS, BX;
    XOR BX, BX
    LEA BX, num;
    MOV AL, [BX];
    AND AL, 01H;
    JNZ odd_num        
    LEA DX, even;
    MOV AH, 09H;    
    INT 21H
    HLT
    odd_num:
        LEA DX, odd;
        MOV AH, 09H;    
        INT 21H
        hlt
