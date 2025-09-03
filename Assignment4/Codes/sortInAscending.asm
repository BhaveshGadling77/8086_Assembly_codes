.model small
.stack 100H

.data
    arr DB 25, 10, 45, 60, 5, 90, 12
    len DB 7

.code
    MOV AX, @data
    MOV DS, AX

    MOV DL, [len]      ; OUTER LOOP COUNTER
    DEC DL             ; N-1 PASSES

outer_loop:
    MOV CL, DL         ; INNER LOOP COUNTER
    LEA SI, arr

inner_loop:
    MOV AL, [SI]
    MOV BL, [SI+1]
    CMP AL, BL
    JBE no_swap
    MOV [SI], BL
    MOV [SI+1], AL

no_swap:
    INC SI
    DEC CL
    JNZ inner_loop

    DEC DL
    JNZ outer_loop
