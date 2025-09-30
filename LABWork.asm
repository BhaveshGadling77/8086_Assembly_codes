.model small

.data
 msg1 DB 'Enter Number: $'
 num1 DB ?
 num2 DB ?
 msg2 DB 0DH, 0AH,'For + press 1$'
 msg3 DB 0DH, 0AH,'For - press 2$'
 msg4 DB 0DH, 0AH,'For * press 3$'
 msg5 DB 0DH, 0AH,'For / press 4$', 0DH, 0AH;
  
 res DB ?
 
.stack 100h 

.code   
    MOV AX, @data
    MOV DS, AX;
    
    MOV AH, 09H;
    INT 21H
    LEA DX, msg2;
    INT 21H
    LEA DX, msg3;
    INT 21H
    LEA DX, msg4;
    INT 21H
    LEA DX, msg5;
    INT 21H
    MOV DX, offset num1
    MOV AH, 01H
    INT 21H
    XOR AH, AH
    MOV DX, AX; 
    INC DX
    MOV AH, 01H
    INT 21H
    MOV DX, AX;
    LEA AX, num1;
    LEA CX, num2;
    LEA BX, res;
    HLT
    