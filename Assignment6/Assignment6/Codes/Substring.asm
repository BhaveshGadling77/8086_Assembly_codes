.model small

.stack 100h

.data
    main_str db 'HELLO WORLD$', 0
    sub_str  db 'HELLO$', 0
    msg1 db 'Substring FOUND!$'
    msg2 db 'Substring NOT FOUND!$'

.code
    MOV AX, @data;
    MOV DS, AX;
    LEA SI, main_str;
    
 next_position:
    LEA DI, sub_str;
    MOV BX, SI;
   
 check_match:
    MOV AL, [BX];
    MOV CL, [DI];
    CMP CL, '$'
    JE found
    CMP AL, '$'
    JE not_found;
    CMP AL, CL;
    JNE no_match
    INC BX
    INC DI
    JMP check_match;
    
 no_match:
    INC SI;
    MOV AL, [SI];
    CMP AL, '$'
    JE not_found
    JMP next_position
    
 found:
    LEA DX, msg1;
    MOV AH, 09H
    INT 21H;
    JMP exit
 
 not_found:
    LEA DX, msg2;
    MOV AH, 09H;
    INT 21H;
   
 exit:
    HLT
    