.model small

.stack 100h

.data
    num1 DB 0FFH
    num2 DB 0FFH
    res DW ? ; result might overflow that'S why 16 bit
    Numb1 DW 0FFFFH
    Numb2 DW 0FFFFH
    Result DD ?

.code   
    ;multiplication. of two 8 bit numbers
    MOV AX, @data
    MOV DS, AX;
    XOR AX, AX
    LEA SI, num1
    LEA DI, res
    MOV AL, [SI]
    INC SI
    MOV BL, [SI]
    MUL BL; this will store the result in AX
    MOV [DI], AX;
    
    ;multiplication of two 16bit numbers.
    XOR AX, AX
    XOR BX, BX
    LEA SI, Numb1;
    LEA DI, Result;
    MOV AX,[SI];
    LEA SI, Numb2;
    MOV BX, [SI];
    MUL BX;
    MOV [DI], AX;
    INC DI
    INC DI
    MOV [DI], DX;
    
    HLT