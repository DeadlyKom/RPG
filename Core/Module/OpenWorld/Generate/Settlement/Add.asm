
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_SETTLEMENT_ADD_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_SETTLEMENT_ADD_
; -----------------------------------------
; добавить/зарезервировать ячейку в массиве
; In:
; Out:
;   A  - ID элемента в массиве
;   IX - адрес найденого свободного элемента структуры FSettlement
;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
Add:            ; инициализация
                LD HL, SETTLEMENT_ADR
                LD DE, SETTLEMENT_SIZE - 1
                LD BC, SETTLEMENT_NUM + 1                                       ; количество элементов
                LD A, SETTLEMENT_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Found
                ADD HL, DE
                JP PE, .Loop
                SCF                                                             ; нет место в массиве
                RET

.Found          ; преобразование ID
                LD A, SETTLEMENT_NUM
                SUB C

                ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IX

                ; увеличение количества регионов в массиве
                LD HL, GameState.Settlement
                INC (HL)
                RET

                display "\t- Add Settlement:\t\t\t\t", /A, Add, " = busy [ ", /D, $ - Add, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_SETTLEMENT_ADD_
