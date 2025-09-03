.model small
.stack 100h

.data
    ser DB 7 01h, 02h, 03h, 04h, 05h, 06h, 07h;
.code
    MOV AX, @data;
    MOV DS, AX;
    lea SI, ser;
    MOV BX, 0000H;  
     MOV CX, 7
 back:    
    MOV AL, [SI];
    ROR AL, 01H;
    JNC even
    INC BH
    JMP next
  even:
    INC BL;
  next:
    INC SI
     
loop back;
hlt
  