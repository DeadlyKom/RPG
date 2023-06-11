
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_ABANDONED_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_ABANDONED_
; -----------------------------------------
; стартовая рандомизация заброшенных/покинутых поселений в зоне
; In:
; Out:
;   A' - ID региона
;   IX - адрес структуры FRegion
;   IY - адрес структуры FGenerateWorld
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
RandAbandoned:  ; -----------------------------------------
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
                LD (IX + FAbandoned.RegionID), A
                
                ; ToDo рандомизация данных
    
                RET

                display "\t- Random abandoned:\t\t\t\t", /A, RandAbandoned, " = busy [ ", /D, $ - RandAbandoned, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_ABANDONED_
