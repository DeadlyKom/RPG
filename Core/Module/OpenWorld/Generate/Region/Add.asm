
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_ADD_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_ADD_
; -----------------------------------------
; добавить/зарезервировать ячейку в массиве
; In:
; Out:
;   A  - ID элемента в массиве
;   IX - адрес найденого свободного элемента структуры FRegion
;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
Add:            ; инициализация
                LD HL, REGION_ADR
                LD DE, REGION_SIZE - 1
                LD BC, REGION_NUM + 1                                           ; количество элементов
                LD A, REGION_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Found
                ADD HL, DE
                JP PE, .Loop
                SCF                                                             ; нет место в массиве
                RET

.Found          ; преобразование ID
                LD A, REGION_NUM
                SUB C

                ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IX

                ; увеличение количества регионов в массиве
                LD HL, GameState.Region
                INC (HL)
                RET

                display "\t- Add region:\t\t\t\t\t", /A, Add, " = busy [ ", /D, $ - Add, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_REGION_ADD_
