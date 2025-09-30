
 .model small
.stack 100h

.data
    str db 'PAL$',0
    msg1 db 'String is a PALINDROME.$'
    msg2 db 'String is NOT a palindrome.$'

.code     

    MOV AX, @data
    MOV DS, AX
    
    LEA SI, str
    MOV CX, 0
    
len_loop:
    MOV AL, [SI]
    CMP AL, '$'
    JE len_found
    INC CX
    INC SI
    JMP len_loop

len_found: 
    LEA SI, str      
    LEA DI, str
    ADD DI, CX       
    DEC DI           

check_loop:
    CMP SI, DI
    JAE palindrome 
    MOV AL, [SI]
    MOV BL, [DI]
    cmp AL, BL
    JNE not_palindrome
    INC SI
    DEC DI
    JMP check_loop

palindrome:
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    JMP exit

not_palindrome:
    LEA DX, msg2
    MOV AH, 09h
    INT 21h

exit:
    HLT
