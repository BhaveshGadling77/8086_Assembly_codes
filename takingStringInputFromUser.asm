.model small

.stack 100h

.data
    str db 'hello worlD$'
    input DB 10 ?
    
.code
    MOV AX, @data;
    MOV DS, AX;
    XOR AX, AX;
    MOV AH, 0AH;
    LEA DX, input;
    INT 21H
;    MOV AH, 09H;
 ;   LEA DX, str;
  ;  INT 21H;
    HLT
