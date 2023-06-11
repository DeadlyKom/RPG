
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_HABITATS_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_HABITATS_
; -----------------------------------------
; стартовая рандомизация существ обитающих в зоне
; In:
; Out:
;   A' - ID региона
;   IX - адрес структуры FRegion
;   IY - адрес структуры FGenerateWorld
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
RandHabitats:   ; -----------------------------------------
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
                LD (IX + FHabitats.RegionID), A
                
                ; рандомизация тип существ
                CALL Math.Rand8
                LD DE, ANIMAL_MAX_NUM
                CALL Math.Clamp
                LD (IX + FHabitats.Type), A
    
                RET

                display "\t- Random habitats:\t\t\t\t", /A, RandHabitats, " = busy [ ", /D, $ - RandHabitats, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_HABITATS_
