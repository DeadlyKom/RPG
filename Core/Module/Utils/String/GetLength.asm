
                ifndef _CORE_MODULE_UTILS_GET_LENGTH_STRING_
                define _CORE_MODULE_UTILS_GET_LENGTH_STRING_
; -----------------------------------------
; длина строки
; In:
;   HL - адрес строки
; Out:
;   BC - длина строки
; Corrupt:
; Note:
; -----------------------------------------
GetLength:      XOR A
                LD B, A
                LD C, A

.WordLoop       CPI
                JR NZ, .WordLoop

                ; NEG BC
                SUB C
                LD C, A
                SBC A, A
                SUB B
                LD B, A

                RET

                endif ; ~_CORE_MODULE_UTILS_GET_LENGTH_STRING_
