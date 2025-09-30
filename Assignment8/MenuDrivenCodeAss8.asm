.model small
.stack 100
.data
    inp_msg DB "ENTER AN array OF 10, 8 BIT HEX INTEGERS", 10, 13, "$"
    menu DB 10, 13, "PLEASE ENTER YOUR choice", 10, 13,"1: FIND maxIMUM NUMBER", 10, 13, "2: FIND minimum NUMBER", 10, 13, "3: SORT IN ascending ORDER", 10, 13, "4: SORT IN descending ORDER", 10, 13, "5: exit", 10, 13, '$'
    arr DB 16 DUP(?)
    min DB 0FFH
    max DB 00H
    space DB " $"
    min_msg DB 10, 13, " minimum: $"
    max_msg DB 10, 13, " maximum: $"  
    ascending_msg DB 10, 13, " ASCENDING ORDER: $"
    descending_msg DB 10, 13, " DESCEDNING ORDER: $" 
    choice DB '?'
    exit_msg DB 10, 13, "EXITING ... $"  
    result DB ?
                
.code
    MOV AX, @data
    MOV DS, AX
    LEA SI, arr
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H    
    MOV BH, 0AH
again: 
    CALL input
    MOV [SI], BL
    LEA DX, space
    MOV AH, 09H     
    INT 21H
    INC SI         
    DEC BH    
    JNZ again


    
restart:
    LEA DX, menu
    MOV AH, 09H     
    INT 21H      
    
    MOV AH, 01H
    INT 21H
    
    SUB AL, 30H 
    MOV choice, AL  
    
    CMP choice, 05H
    JZ exit        
    
    CMP choice, 01H
    JZ maximum
    
    CMP choice, 02H
    JZ minimum
    
    CMP choice, 03H
    JZ ascending
    
    CMP choice, 04H
    JZ descending
 
              
RET
 
exit:
    LEA DX, exit_msg
    MOV AH, 09H
    INT 21H
    HLT   
    


func_max:
    LEA SI, DI    ; j = i
    MOV AH, [SI]    ; max = arr[j]
    MOV max, AH
    MOV BX, SI 

    INC SI          ; j++
    
    
    max_loop:
        MOV DL, [SI]  
        CMP DL, max              
        JBE SKIP       
            MOV max, DL  
            LEA BX, SI    
        SKIP:
        INC SI                   ; J++
        DEC CL
    JNZ max_loop
    RET    

maximum:        
    LEA DI, arr
    MOV CL, 09H
    CALL func_max      ;max = maximum element  
    LEA DX, max_msg
    MOV AH, 09H
    INT 21H
    MOV AL, max
    MOV result, AL
    CALL print
    JMP restart
          
     
          
func_min:
    LEA SI, DI     ; j = i
    MOV AH, [SI]    ; min = arr[j]
    MOV min, AH
    MOV BX, SI 

    INC SI          ; j++
    
    min_loop:
        MOV DL, [SI]      
        CMP min, DL
        JBE SKIP2          
            MOV min, DL        
            LEA BX, SI 
        SKIP2:
        INC SI                   ; i++
        DEC CL
    JNZ min_loop
    RET    

minimum:        
    LEA DI, arr
    MOV CL, 09H
    CALL func_min      ;min = minimum element  
    LEA DX, min_msg
    MOV AH, 09H
    INT 21H
    MOV AL, min
    MOV result, AL
    CALL print
    JMP restart  
    
    
    
ascending:  
    LEA DI, arr
    MOV CH, 09H 
    sorting_loop_asc: 
        MOV CL, CH
        CALL func_min

        MOV AL, [DI] 
        MOV AH, [BX] 
        MOV [DI], AH 
        MOV [BX], AL  
        INC DI
        DEC CH
    JNZ sorting_loop_asc  
    
    LEA DX, ascending_msg
    MOV AH, 09H
    INT 21H   
    
    CALL print_array
    
    JMP restart
    
    
    
descending:     
    LEA DI, arr  
    MOV CH, 09H
    sorting_loop_desc: 
        MOV CL, CH
        CALL func_max
      
        MOV AL, [DI]
        MOV AH, [BX]  
        MOV [DI], AH
        MOV [BX], AL  
        INC DI
        DEC CH
    JNZ sorting_loop_desc  
    
    LEA DX, descending_msg
    MOV AH, 09H
    INT 21H   
    
    CALL print_array

    JMP restart
  
  
    
input:
    MOV CH, 02H
    MOV CL, 04H      
    XOR BL, BL        
    XOR DL, DL        
    
    back:   
    SHL BL, CL
    MOV AH, 01H
    INT 21H
    CMP AL, 41H
    JC NEXT
    
    SUB AL, 07H
    NEXT:
    SUB AL, 30H
    MOV DL, AL
    ADD BL, DL        
    DEC CH
    JNZ back 
    RET
     

print:    
    MOV CH, 02H
    MOV CL, 04H
    MOV BL, result
back2:    
    ROL BL, CL
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC l2
    ADD DL, 07H
l2:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ back2 
    RET        

            
print_array:            
    LEA DI, arr
    MOV BH, 0AH
    print_arr_loop:
        MOV AL, [DI]
        MOV result, AL
        CALL print
        LEA DX, space
        MOV AH, 09H
        INT 21H
        INC DI    
        DEC BH
    JNZ print_arr_loop
    
    RET            
