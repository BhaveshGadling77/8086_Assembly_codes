
.model small
.stack 100H

.data
    ARR DB 25, 10, 45, 60, 5, 90, 12
    LEN DB 7
    LARGEST DB ?

.code
    MOV AX, @data
    MOV DS, AX

    LEA SI, ARR
    MOV CL, LEN
    MOV AL, [SI]
    MOV LARGEST, AL
    INC SI
    DEC CL

next_large:
    MOV DL, [SI]
    CMP DL, LARGEST
    JLE SKIP_LARGE
    MOV LARGEST, DL

skip_large:
    INC SI
    DEC CL
    JNZ NEXT_LARGE
    HLT
