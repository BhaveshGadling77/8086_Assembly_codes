.model small               

.stack 100h

.data
    str db 'HeLLo WoRLd$',0
    msg1 db 'Original String: $'
    msg2 db 0Dh,0Ah,'Changed Case String: $'

.code    

    MOV AX, @data
    MOV DS, AX
    
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    LEA DX, str
    MOV AH, 09h
    INT 21h
    LEA SI, str

next_char:
    MOV AL, [SI]
    CMP AL, '$'
    JE done
    CMP AL, 'A'
    JB skip      
    CMP AL, 'Z'
    JBE to_lower

    CMP AL, 'a'
    JB skip      
    CMP AL, 'z'
    JBE to_upper 
    JMP skip

to_lower:
    ADD AL, 20h
    MOV [SI], AL
    JMP skip

to_upper:
    SUB AL, 20h  
    MOV [SI], AL

skip:
    INC SI
    JMP next_char

done:                                 

    LEA DX, msg2
    MOV AH, 09h
    INT 21h

    LEA dx, str
    MOV ah, 09h
    INT 21h 
    HLT