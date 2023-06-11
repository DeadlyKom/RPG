
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_SETTLEMENT_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_SETTLEMENT_
; -----------------------------------------
; стартовая рандомизация поселения
; In:
; Out:
;   A' - ID региона
;   IX - адрес структуры FRegion
;   IY - адрес структуры FGenerateWorld
; Corrupt:
;   HL, DE, BC, AF, IX
; Note:
; -----------------------------------------
RandSettlement: ; радиус влияния поселения
                CALL Math.Rand8
                AND VORONOI_DIAGRAM_RADIUS
                LD (IX + FRegion.InfluenceRadius), A

                ; генерация ключа
                CALL Math.Rand8
                LD (IX + FRegion.Seed.Low), A
                CALL Math.Rand8
                LD (IX + FRegion.Seed.High), A
                CALL Packs.OpenWorld.Generate.RandLocation                      ; генерация позиции в мире

                ; -----------------------------------------
                ; резервирование ячейки поселения
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; In:
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FSettlement
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки

                ; установка ID региона
                EX AF, AF'
                LD (IX + FSettlement.RegionID), A

                ; доступные строения в поселении
                LD (IX + FSettlement.Building), BUILDING_ENTRANCE | BUILDING_RESIDENTIAL_AREA; | BUILDING_WAREHOUSE | BUILDING_SHOPPING_AREA | BUILDING_BAR | BUILDING_WORKSHOP | BUILDING_PRISON | BUILDING_RADIO_TOWER

                RET

                display "\t- Random settlement:\t\t\t\t", /A, RandSettlement, " = busy [ ", /D, $ - RandSettlement, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_METADATA_RANDOM_SETTLEMENT_
