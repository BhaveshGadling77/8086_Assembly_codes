 .model small
.stack 100h

.data
    main_str db 'ABABABA$',0    
    sub_str  db 'AB$',0        
    msg1 db 'Occurrences = $'
    count db 0   

.code            
    MOV AX, @data
    MOV DS, AX   
    LEA SI, main_str 
    LEA BX, sub_str  

next_pos:
    mov DI, SI       
    lea BX, sub_str  

check_sub:
    MOV AL, [BX]      
    CMP AL, '$'       
    JE found_one      

    MOV DL, [DI]      
    CMP DL, '$'       
    JE done           

    cmp AL, DL        
    JNE not_match       

    INC BX
    INC DI
    JMP check_sub

found_one:              
    INC count           
    
not_match:
    INC SI              
    MOV AL, [SI]
    CMP AL, '$'
    JNE next_pos        

done:                   
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    MOV AL, count     
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    HLT
