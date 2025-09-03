.model small
.stack 100h

.data
    series DB 15 dup(?)
    
.code
        MOV AX, @data
    MOV DS, AX

    LEA SI, series           ; SI -> series array

    ; first two terms
    MOV AL, 00h
    MOV [SI], AL
    INC SI

    MOV AL, 01h
    MOV [SI], AL
    INC SI

    MOV DL, 00H; pre = 0
    MOV BL, 01H; curr = 1

    MOV CX, 08h;
    series_loop:
        MOV AL, DL;AL = pre
        ADD AL, BL; AL = pre + curr

        MOV [SI], AL; store next term
        INC SI
        ; update pre and curr
        MOV DL, BL;pre = curr
        MOV BL, AL;

    LOOP series_loop
    