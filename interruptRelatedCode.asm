org 100h

.model small
.stack 100h

.data                           
    msg db 10, 13,'Breaking!!!$';
    
.code 
    Mov ax, @data;
    mov ds, ax
   ; lea bx, next;
  ;  mov cs:[bx], 00CCh;
    
    mov bx, offset ISR1
    mov ax, 0000h
    mov es, ax;
    mov es:[000CH], bx
    mov es:[000EH], cs;
    
 back:
    MOV AH, 01H
    INT 21H 
    CMP AL, 'B';
    JZ NEXT;
    JMP back
    
 NEXT: INT 3
 
 JMP LAST
 
 PROC ISR1
    LEA DX, msg;
    MOV AH, 09H
    INT 21H
    IRET
 ENDP ISR1
 
 LAST:
    MOV AH, 4CH;
    INT 21H
 END
 
 RET   