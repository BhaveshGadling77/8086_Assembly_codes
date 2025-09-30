.model small

.stack 100h

.data
    str1 DB "Hello "
    str2 DB "World$"
    msg1 db "Concatenated String: $"
    
.code
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, str1;
 
 find_end:
    MOV AL, [SI]
    CMP AL, 0H
    JE found_end;
    INC SI
    JMP find_end;
    
 found_end:
    LEA DI, str2;
    
 copy:
    MOV AL, [DI];
    CMP AL, '$';
    JE concat
    MOV [SI],AL
    INC SI;
    INC DI
    JMP copy
 
 concat:
    MOV BYTE PTR [SI], '$'
    
    LEA DX, msg1;
    MOV AH, 09H;
    INT 21H
    
    LEA DX, str1;
    MOV AH, 09H
    INT 21H  
    HLT
    