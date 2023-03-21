                ifndef _MACRO_FLAGS_
                define _MACRO_FLAGS_
; -----------------------------------------
; проверка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
CHECK_FLAG      macro FlagBit?
                BIT FlagBit?, (HL)
                endm
; -----------------------------------------
; проверка флага
; In:
;   A  - значения флагов
; Out:
; Corrupt:
; -----------------------------------------
CHECK_FLAG_A    macro FlagBit?
                BIT FlagBit?, A
                endm
; -----------------------------------------
; установка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
SET_FLAG        macro FlagBit?
                SET FlagBit?, (HL)
                endm
; -----------------------------------------
; сброс флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
RES_FLAG        macro FlagBit?
                RES FlagBit?, (HL)
                endm
; -----------------------------------------
; изъятие флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
POP_FLAG        macro FlagBit?
                CHECK_FLAG FlagBit?
                JR Z, .Next
                RES_FLAG FlagBit?
.Next           ;
                endm

                endif ; ~_MACRO_FLAGS_
