.model small
.stack 100H

.data
    arr DB 25, 10, 45, 60, 5, 90, 12
    len DB 7

.code
    MOV AX, @data
    MOV DS, AX

    MOV CL, len ; OUTER LOOP COUNTER
    DEC CL         

outer_loop:
    MOV CH, CL; INNER LOOP COUNTER
    LEA SI, arr

inner_loop:
    MOV AL, [SI]; LOAD CURRENT ELEMENT
    MOV BL, [SI+1]; LOAD NEXT ELEMENT
    CMP AL, BL
    JAE no_swap ; IF AL >= BL, NO SWAP
    MOV [SI], BL
    MOV [SI+1], AL

no_swap:
    INC SI
    DEC CH
    JNZ inner_loop

    DEC CL
    JNZ outer_loop