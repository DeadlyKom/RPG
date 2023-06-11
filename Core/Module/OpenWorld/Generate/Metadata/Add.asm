
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_ADD_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_ADD_
; -----------------------------------------
; добавить/зарезервировать ячейку в массиве
; In:
; Out:
;   A  - ID элемента в массиве
;   IX - адрес найденого свободного элемента метаданных региона
;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
Add:            ; инициализация
                LD HL, METADATA_ADR
                LD DE, METADATA_SIZE - 1
                LD BC, METADATA_NUM + 1                                         ; количество элементов
                LD A, METADATA_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Found
                ADD HL, DE
                JP PE, .Loop
                SCF                                                             ; нет место в массиве
                RET

.Found          ; преобразование ID
                LD A, METADATA_NUM
                SUB C

                ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IX

                ; увеличение количества метаданных региона в массиве
                LD HL, GameState.Metadata
                INC (HL)
                RET

                display "\t- Add metadata:\t\t\t\t", /A, Add, " = busy [ ", /D, $ - Add, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_ADD_
