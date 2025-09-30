.model small

.data
  str db 'HELLO$', 0
  msg1 db 'Original String: $'
  msg2 db 0DH,0AH, 'Length of String: $'
  msg3 db 0DH,0AH, 'Reversed String: $'
  len dW 0;
.stack 100h

.code
    MOV AX, @data
    MOV DS, AX
    LEA DX, msg1
    mov ah, 09h
    int 21h    
    
    LEA SI, str
    MOV DX, SI;
    MOV AH, 09H
    INT 21H
    MOV CX, 00H;
    
    ;finding Length
 find_len:
    MOV AL, [SI];
    CMP AL, '$';
    JE len_found
    INC CX;
    INC SI;
    JMP find_len
 len_found:
    MOV len, CX;
    MOV DX, offset msg2
    MOV ah, 09h
    INT 21h
    MOV AX, len
    ADD AX, 30h
    MOV DX, AX
    MOV AH, 02h
    INT 21h 
    
    MOV SI, offset str;
    MOV DI, SI;
    ADD DI,len ;
    DEC DI 
 
 reverse_str:
    CMP SI, DI
    JGE print_rev;
    MOV AL, [SI]
    MOV BL, [DI]
    MOV [SI], BL
    MOV [DI], AL
    INC SI
    DEC DI
    JMP reverse_str;
 
 print_rev:
    MOV DX, offset msg3;
    MOV AH, 09H;
    INT 21H;
    
    MOV DX, offset str;
    MOV AH, 09H
    INT 21H 
    
    HLT