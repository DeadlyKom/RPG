
                ifndef _MODULE_GAME_RENDER_OBJECTS_
                define _MODULE_GAME_RENDER_OBJECTS_
; -----------------------------------------
; отображение объектов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Object:         ; инициализация
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

.Num            EQU $+1                                                         ; количество элементов в отсортированном массиве
                LD A, #00
                OR A
                RET Z                                                           ; выход, если массив пуст

                LD HL, SortBuffer
                LD B, A
                
.Loop           PUSH BC
                LD A, (HL)
                AND #F8                                                         ; ToDo очищается младшие 3 бита
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL
                PUSH HL

                CALL Draw.Object
                
                POP HL
                POP BC
                DJNZ .Loop

                RET

                endif ; ~_MODULE_GAME_RENDER_OBJECTS_
