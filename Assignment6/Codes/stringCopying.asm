.model small

.stack 100h

.data
    src  db 'HELLO WORLD$',0
    dest db 20 dup('$')       

.code
    
    MOV AX, @data
    MOV DS, AX    
    MOV ES, AX      
    LEA SI, src     
    LEA DI, dest    

copy_loop:
    MOV AL, [SI] 
    MOV [DI], AL   
    INC SI          
    INC DI          
    CMP AL, '$'     
    JNE copy_loop   
    LEA DX, dest
    MOV AH, 09h  
    INT 21h
    HLT