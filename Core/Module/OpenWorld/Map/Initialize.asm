
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_INITIALIZE_
                define _CORE_MODULE_OPEN_WORLD_MAP_INITIALIZE_
; -----------------------------------------
; подготовка карты мира
; In:
;   A' - количество элементов в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран

                ; очистка временного буфера
                LD HL, (MemBank_03 + BankSize) & 0xFFFF
                LD DE, #FFFF
                CALL SafeFill.b4096
                CALL SafeFill.b4096
                CALL SafeFill.b4096

                ; инициализация
                LD IX, SORT_BUF_ADR                                             ; указывает на временный буфер массива структур FVoronoiDiagram
                EX AF, AF'

.Loop           EX AF, AF'

                CALL SetValue                                                   ; установка значения
                
                ; следующий элемент диаграммы Вороного
                LD BC, FVoronoiDiagram
                ADD IX, BC
                EX AF, AF'
                DEC A
                JR NZ, .Loop

                RET

                display "\t- Initialize:\t\t\t\t\t", /A, Initialize, " = busy [ ", /D, $ - Initialize, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_INITIALIZE_
