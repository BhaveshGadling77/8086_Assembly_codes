.model small

.stack 100h
    
.data   
    str1 db 'HELLO$'
    str2 db 'HEL$'
    msg_eq db 'Strings are equal.$'
    msg_ne db 'Strings are NOT equal.$'


.code
    MOV AX, @data
    MOV DS, AX;
    LEA SI, str1;
    LEA DI, str2;
    
 compare:
    MOV AL, [SI];
    MOV BL, [DI];
    CMP AL, BL;
    JNE not_equaL 
    CMP AL, '$'
    JE equal
    INC SI;
    INC DI;
    JMP compare
    
 equal:
    LEA DX, msg_eq;
    MOV AH, 09H
    INT 21H
    JMP exit
 
 not_equal:
     LEA DX, msg_ne
     MOV AH, 09H
     INT 21H
     JMP exit
 exit:
    HLT;
