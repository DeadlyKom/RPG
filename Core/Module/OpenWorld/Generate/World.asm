                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_
; -----------------------------------------
; генерация мира игры
; In:
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          ; получение хеш из строки
                PUSH IY
                POP HL                                                          ; FGenerateWorld.TextSeed
                ; -----------------------------------------
                ; получение хеш значения из строки
                ; In:
                ;   HL   - адрес строки
                ; Out:
                ;   DEHL - хеш-значение
                ; -----------------------------------------
                CALL Packs.OpenWorld.Utils.GetHash

                ; инициализация генератора
                CALL Math.SetSeed32

                ; установка frequency генератора пустоши (шума Перлина)
                CALL Math.Rand8
                LD DE, #2060                                                    ; значение в педелах (64-128)
                CALL Math.Clamp
                LD (Math.PN_Frequency), A

                ; инициализация мира
                include "Initialize.asm"

                ; -----------------------------------------
                ; инициализация первого поселения
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; In:
                ; Out:
                ;   С  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Region.Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки

                ; сохранение ID региона
                EX AF, AF'

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------
                
                ; тип региона
                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT

                ; позиция поселения в мире
                LD HL, #0000
                LD (PlayerState.CameraPosX + 1), HL
                LD (PlayerState.CameraPosY + 1), HL
                LD (IX + FRegion.Location.X.Low), HL
                LD (IX + FRegion.Location.Y.Low), HL
                
                CALL .RND_16
                LD (PlayerState.CameraPosX + 3), HL
                LD (IX + FRegion.Location.X.High), HL

                CALL .RND_16
                LD (PlayerState.CameraPosY + 3), HL
                LD (IX + FRegion.Location.Y.High), HL

                ; радиус влияния поселения
                LD (IX + FRegion.InfluenceRadius), #08

                ; генерация ключа
                CALL Math.Rand8
                LD (IX + FRegion.Seed.Low), A
                CALL Math.Rand8
                LD (IX + FRegion.Seed.High), A

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
                CALL Settlement.Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки

                ; установка ID региона
                EX AF, AF'
                LD (IX + FSettlement.RegionID), A

                ; доступные строения в поселении
                LD (IX + FSettlement.Building), BUILDING_ENTRANCE | BUILDING_RESIDENTIAL_AREA; | BUILDING_WAREHOUSE | BUILDING_SHOPPING_AREA | BUILDING_BAR | BUILDING_WORKSHOP | BUILDING_PRISON | BUILDING_RADIO_TOWER

                RET

.RND_16         EXX
                CALL Math.Rand8
                EXX
                LD L, A
                EXX
                CALL Math.Rand8
                EXX
                LD H, A
                RET

                display "\t- World:\t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_GENERATE_
