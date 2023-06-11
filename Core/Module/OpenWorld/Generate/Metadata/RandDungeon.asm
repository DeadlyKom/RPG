
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_DUNGEON_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_DUNGEON_
; -----------------------------------------
; стартовая рандомизация зона подземелий
; In:
; Out:
;   A' - ID региона
;   IX - адрес структуры FRegion
;   IY - адрес структуры FGenerateWorld
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
RandDungeon:    ; -----------------------------------------
                ; резервирование ячейки метаданных
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; In:
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента метаданных
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки

                ; установка ID региона
                EX AF, AF'
                LD (IX + FDungeon.RegionID), A
                
                ; ToDo рандомизация данных
    
                RET

                display "\t- Random dungeon:\t\t\t\t", /A, RandDungeon, " = busy [ ", /D, $ - RandDungeon, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_DUNGEON_
