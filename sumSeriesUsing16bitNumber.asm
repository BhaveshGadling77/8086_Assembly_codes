.model small

.stack 100h

.data
num DW 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFh, 0FFFFH;
len Dw 05H



.code
    ;result will be stored in AX and DX. DX will be used for carry.
    MOV AX, @data;
    MOV DS, AX
    LEA SI, num
    MOV CX, len;
    XOR AX, AX
    XOR DX, AX
    sum:
        ADD AX, [SI]
        ADC DX, 0
        INC SI
        INC SI
    
    LOOP sum
    HLT
