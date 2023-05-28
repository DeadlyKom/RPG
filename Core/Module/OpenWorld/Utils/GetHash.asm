
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_GET_HASH_
                define _CORE_MODULE_OPEN_WORLD_UTILS_GET_HASH_
; -----------------------------------------
; получение хеш значения из строки
; In:
;   HL   - адрес строки
; Out:
;   DEHL - хеш-значение
; Corrupt:
; Note:
;   Хеш-функция №8: GNU
;   https://habr.com/ru/articles/732542/
; -----------------------------------------
GetHash:        ; инициализация
                EXX 
                LD HL, #A55A
                LD DE, #5AA5

.Loop           EXX
                LD A, (HL)
                INC HL
                OR A
                EXX
                RET Z

                ; -----------------------------------------
                ; hash = (hash >> 5 + hash) + value[i];
                ; -----------------------------------------
                PUSH DE
                PUSH HL
                EX AF, AF'                                                      ; сохранение значения

                ; hash >> 5
                LD B, #05
                CALL RotateRight

                ; hash >> 5 + hash
                POP BC
                ADD HL, BC
                EX DE, HL
                POP BC
                ADC HL, BC
                EX DE, HL

                ; (hash >> 5 + hash) + value[i]
                EX AF, AF'                                                      ; восстановление значения
                LD C, A
                LD B, #00
                ADD HL, BC
                JR NC, $+3
                INC DE

                JR .Loop

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_GET_HASH_
