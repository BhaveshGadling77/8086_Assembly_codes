.model small
.stack 100
.data
    menu DB 10, 13, "Please enter your choice (1-14) and press Enter:", 10, 13
         DB "-------------------------------------", 10, 13
         DB "1: One's complement (8-bit)", 10, 13
         DB "2: One's complement (16-bit)", 10, 13
         DB "3: Two's complement (8-bit)", 10, 13
         DB "4: Two's complement (16-bit)", 10, 13
         DB "5: Mask 4 LSB of 8-bit", 10, 13
         DB "6: Mask 4 MSB of 8-bit", 10, 13
         DB "7: Mask 8 LSB of 16-bit", 10, 13
         DB "8: Mask 8 MSB of 16-bit", 10, 13
         DB "9: Shift 8-bit left", 10, 13
         DB "10: Shift 8-bit right", 10, 13
         DB "11: Shift 16-bit left", 10, 13
         DB "12: Shift 16-bit right", 10, 13
         DB "13: Check even/odd", 10, 13
         DB "14: Exit", 10, 13, "$"

    inp_msg DB 10, 13, "Enter number (2 hex digits for 8-bit / 4 for 16-bit): $"
    exit_msg DB 10, 13, "Exiting... $"
    result_msg DB 10, 13, "Result: $"
    odd_msg DB "ODD$"
    even_msg DB "EVEN$"
    
    ; Variables
    choice DW ?
    num8   DB ?
    num16  DW ?
    result8 DB ?
    result16 DW ?

.code
MAIN:
    MOV AX, @data
    MOV DS, AX

restart:
    ; Display the menu
    LEA DX, menu
    MOV AH, 09H
    INT 21H

    ; --- Corrected Multi-Digit Choice Input ---
    XOR BX, BX ; Clear BX to store the choice
read_choice_loop:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 0DH ; Check for Enter key
    JE process_choice

    ; Convert ASCII digit to number
    SUB AL, 30H 
    MOV AH, 0   ; Clear AH for addition
    
    ; Multiply current choice by 10 and add new digit
    PUSH AX     ; Save new digit
    MOV AX, BX
    MOV CX, 10
    MUL CX      ; AX = AX * 10
    MOV BX, AX
    POP AX      ; Restore new digit
    ADD BX, AX  ; Add new digit to total
    JMP read_choice_loop
    
process_choice:
    MOV choice, BX

    ; --- Jump Table ---
    CMP choice, 1
    JE ones8
    CMP choice, 2
    JE ones16
    CMP choice, 3
    JE twos8
    CMP choice, 4
    JE twos16
    CMP choice, 5
    JE mask8lsb
    CMP choice, 6
    JE mask8msb
    CMP choice, 7
    JE mask16lsb
    CMP choice, 8
    JE mask16msb
    CMP choice, 9
    JE shl8
    CMP choice, 10
    JE shr8
    CMP choice, 11
    JE shl16
    CMP choice, 12
    JE shr16
    CMP choice, 13
    JE evenodd
    CMP choice, 14
    JE exit

    JMP restart ; Invalid choice, restart

; ------------------ Menu Option Implementations ------------------

ones8:
    ; INPUT 8-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_1:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_1
    SUB AL, 7
d1_1: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_1
    MOV num8, BL
    
    ; LOGIC
    MOV AL, num8
    NOT AL
    MOV result8, AL
    
    ; PRINT 8-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_1:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_1
    ADD DL, 7
p81_1: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_1
    JMP restart

ones16:
    ; INPUT 16-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_2:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_2
    SUB AL, 7
d2_2: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_2
    MOV num16, BX
    
    ; LOGIC
    MOV AX, num16
    NOT AX
    MOV result16, AX
    
    ; PRINT 16-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_2:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_2
    ADD DL, 7
p161_2: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_2
    JMP restart

twos8:
    ; INPUT 8-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_3:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_3
    SUB AL, 7
d1_3: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_3
    MOV num8, BL
    
    ; LOGIC
    MOV AL, num8
    NEG AL ; NEG is equivalent to NOT then INC
    MOV result8, AL
    
    ; PRINT 8-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_3:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_3
    ADD DL, 7
p81_3: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_3
    JMP restart

twos16:
    ; INPUT 16-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_4:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_4
    SUB AL, 7
d2_4: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_4
    MOV num16, BX
    
    ; LOGIC
    MOV AX, num16
    NEG AX
    MOV result16, AX
    
    ; PRINT 16-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_4:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_4
    ADD DL, 7
p161_4: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_4
    JMP restart
    
mask8lsb:
    ; INPUT 8-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_5:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_5
    SUB AL, 7
d1_5: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_5
    MOV num8, BL
    
    ; LOGIC
    MOV AL, num8
    AND AL, 0F0H ; Mask lower 4 bits
    MOV result8, AL
    
    ; PRINT 8-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_5:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_5
    ADD DL, 7
p81_5: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_5
    JMP restart

mask8msb:
    ; INPUT 8-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_6:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_6
    SUB AL, 7
d1_6: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_6
    MOV num8, BL
    
    ; LOGIC
    MOV AL, num8
    AND AL, 0FH ; Mask upper 4 bits
    MOV result8, AL
    
    ; PRINT 8-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_6:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_6
    ADD DL, 7
p81_6: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_6
    JMP restart
    
mask16lsb:
    ; INPUT 16-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_7:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_7
    SUB AL, 7
d2_7: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_7
    MOV num16, BX
    
    ; LOGIC
    MOV AX, num16
    AND AX, 0FF00H ; Mask lower 8 bits
    MOV result16, AX
    
    ; PRINT 16-BIT HEX
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_7:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_7
    ADD DL, 7
p161_7: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_7
    JMP restart

mask16msb:
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_8:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_8
    SUB AL, 7
d2_8: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_8
    MOV num16, BX
    
    MOV AX, num16
    AND AX, 00FFH 
    MOV result16, AX
    
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_8:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_8
    ADD DL, 7
p161_8: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_8
    JMP restart
    
shl8:
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_9:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_9
    SUB AL, 7
d1_9: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_9
    MOV num8, BL
    
    MOV AL, num8
    SHL AL, 1
    MOV result8, AL
    
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_9:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_9
    ADD DL, 7
p81_9: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_9
    JMP restart
    
shr8:
    ; INPUT 8-BIT HEX
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_10:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_10
    SUB AL, 7
d1_10: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_10
    MOV num8, BL
    
    ; LOGIC
    MOV AL, num8
    SHR AL, 1
    MOV result8, AL
    
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BL, result8
    MOV CH, 2
pr8_loop_10:
    ROL BL, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p81_10
    ADD DL, 7
p81_10: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr8_loop_10
    JMP restart
    
shl16:
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_11:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_11
    SUB AL, 7
d2_11: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_11
    MOV num16, BX
    
    MOV AX, num16
    SHL AX, 1
    MOV result16, AX
    
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_11:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_11
    ADD DL, 7
p161_11: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_11
    JMP restart
    
shr16:
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CX, 4
    XOR BX, BX
input16_loop_12:
    SHL BX, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d2_12
    SUB AL, 7
d2_12: 
    SUB AL, 30H
    ADD BL, AL
    LOOP input16_loop_12
    MOV num16, BX
    
    MOV AX, num16
    SHR AX, 1
    MOV result16, AX
    
    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    MOV BX, result16
    MOV CH, 4
pr16_loop_12:
    ROL BX, 4
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 0AH
    JC p161_12
    ADD DL, 7
p161_12: 
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC CH
    JNZ pr16_loop_12
    JMP restart
    
evenodd:
    LEA DX, inp_msg
    MOV AH, 09H
    INT 21H
    MOV CH, 2
    XOR BL, BL
input8_loop_13:
    SHL BL, 4
    MOV AH, 01H
    INT 21H
    CMP AL, '9'
    JBE d1_13
    SUB AL, 7
d1_13: 
    SUB AL, 30H
    ADD BL, AL
    DEC CH
    JNZ input8_loop_13
    MOV num8, BL

    LEA DX, result_msg
    MOV AH, 09H
    INT 21H
    
    MOV AL, num8
    TEST AL, 01H ; Test the last bit
    JZ is_even
    
is_odd:
    LEA DX, odd_msg
    MOV AH, 09H
    INT 21H
    JMP restart

is_even:
    LEA DX, even_msg
    MOV AH, 09H
    INT 21H
    JMP restart

exit:
    LEA DX, exit_msg
    MOV AH, 09H
    INT 21H
    HLT