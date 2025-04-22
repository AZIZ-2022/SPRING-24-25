.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB "ENTER FIRST NUMBER:$"
MSG2 DB 0AH,0DH,"ENTER SECOND NUMBER:$"
MSG_GREATER DB 0AH, 0DH, "GREATER NUMBER IS: $"  
MSG_GT5 DB 0AH, 0DH, "NUMBER 1 IS GREATER THAN 5$"
MSG_NOT_GT5 DB 0AH, 0DH, "NUMBER 2 IS NOT GREATER THAN 5$"
NUM1 DB ?
NUM2 DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for first number
    MOV DX, OFFSET MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H        ; Read character
    INT 21H
    SUB AL, '0'
    MOV NUM1, AL

    ; Prompt for second number
    MOV DX, OFFSET MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H        ; Read character
    INT 21H
    SUB AL, '0'
    MOV NUM2, AL

    ; Compare and decide
    MOV AL, NUM1
    MOV BL, NUM2
    CMP AL, BL
    JG PRINT_NUM1      ; If AL > BL, go print NUM1
    JL PRINT_NUM2      ; If AL < BL, go print NUM2

    ; If equal
    MOV DX, OFFSET MSG_GREATER
    MOV AH, 09H
    INT 21H

    MOV DL, NUM1
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    JMP CHAKE_NUM      ; Now check both numbers

PRINT_NUM1:
    MOV DX, OFFSET MSG_GREATER
    MOV AH, 09H
    INT 21H

    MOV DL, NUM1
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    JMP CHAKE_NUM      ; Now check both numbers

PRINT_NUM2:
    MOV DX, OFFSET MSG_GREATER
    MOV AH, 09H
    INT 21H

    MOV DL, NUM2
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    JMP CHAKE_NUM      ; Now check both numbers

CHAKE_NUM:
    MOV AL, NUM1
    CMP AL, 5
    JG NUM1_GT5
    JMP NUM1_NOT_GT5

NUM1_GT5:
    MOV DX, OFFSET MSG_GT5
    MOV AH, 09H
    INT 21H
    JMP CHECK_NUM2

NUM1_NOT_GT5:
    MOV DX, OFFSET MSG_NOT_GT5
    MOV AH, 09H
    INT 21H

CHECK_NUM2:
    MOV AL, NUM2
    CMP AL, 5
    JG NUM2_GT5
    JMP NUM2_NOT_GT5

NUM2_GT5:
    MOV DX, OFFSET MSG_GT5
    MOV AH, 09H
    INT 21H
    JMP END_PROGRAM

NUM2_NOT_GT5:
    MOV DX, OFFSET MSG_NOT_GT5
    MOV AH, 09H
    INT 21H

END_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
