
                ifndef _CORE_MODULE_UTILS_STRING_GET_STRING_ID_
                define _CORE_MODULE_UTILS_STRING_GET_STRING_ID_
; -----------------------------------------
; получение строки по индексу
; In:
;   A  - индекс строки
;   HL - адрес массива строк
; Out:
;   HL - адрес строки с указанным индексом
; Corrupt:
;   HL, D, BC, AF
; Note:
; -----------------------------------------
GetStringID:    OR A
                RET Z

                INC A
                LD D, A
                XOR A

.Loop           LD B, A
                LD C, A

.WordLoop       CPI
                JR NZ, .WordLoop

                DEC D
                JR NZ, .Loop

                ; расчёт адреса начала строки
                ADD HL, BC
                RET

                endif ; ~_CORE_MODULE_UTILS_STRING_GET_STRING_ID_
