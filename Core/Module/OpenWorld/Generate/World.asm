                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_
; -----------------------------------------
; генерация мира игры
; In:
;   IY - адрес структуры FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          ; -----------------------------------------
                ; инициализация флагов настройки игры
                ; -----------------------------------------
                LD A, (IY + FGenerateWorld.MapSize)
                AND MAP_SIZE_MASK
                ADD A, A
                ADD A, A
                ADD A, A
                LD C, A

                LD A, (IY + FGenerateWorld.Climate)
                AND CLIMATE_MASK
                ADD A, A
                ADD A, A
                ADD A, C
                LD C, A

                LD A, (IY + FGenerateWorld.Difficulty)
                AND DIFFICULTY_MASK
                OR C
                LD (GameState.Setting), A

                ; -----------------------------------------
                ; получение хеш из строки
                ; -----------------------------------------
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
                LD DE, #2060                                                    ; значение в педелах (32-96)
                CALL Math.Clamp
                LD (Math.PN_Frequency), A

                ; инициализация мира
                include "Initialize.asm"

                ; генерация центра мира
                CALL Math.Rand8
                LD (IY + FGenerateWorld.Center.X.High.Low), A
                CALL Math.Rand8
                LD (IY + FGenerateWorld.Center.X.High.High), A
                CALL Math.Rand8
                LD (IY + FGenerateWorld.Center.Y.High.Low), A
                CALL Math.Rand8
                LD (IY + FGenerateWorld.Center.Y.High.High), A

                ; -----------------------------------------
                ; инициализация левого верхнего угла
                ; -----------------------------------------

                ; определение размера карты
                LD E, #00
                LD A, (GameState.Setting)
                AND SETTING_MAP_SIZE_MASK
                LD D, MAP_SIZE_SMALL_SQUARED >> 1
                JR Z, .MapSize                                                  ; MAP_SIZE_SMALL
                LD D, MAP_SIZE_AVERAGE_SQUARED >> 1
                CP SETTING_MAP_SIZE_AVERAGE
                JR Z, .MapSize                                                  ; MAP_SIZE_AVERAGE
                LD D, MAP_SIZE_BIG_SQUARED >> 1
.MapSize        PUSH DE
                
                LD HL, (IY + FGenerateWorld.Center.X.Low)
                EXX
                LD HL, (IY + FGenerateWorld.Center.X.High)
                LD DE, #0000
                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32
                LD (Packs.OpenWorld.Map.Prepare.LeftTop_X_Low), HL
                LD (Packs.OpenWorld.Map.Prepare.LeftTop_X_High), DE

                LD HL, (IY + FGenerateWorld.Center.Y.Low)
                POP DE
                EXX
                LD HL, (IY + FGenerateWorld.Center.Y.High)
                LD DE, #0000
                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32
                LD (Packs.OpenWorld.Map.Prepare.LeftTop_Y_Low), HL
                LD (Packs.OpenWorld.Map.Prepare.LeftTop_Y_High), DE

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

                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT_BEGIN            ; тип региона "начальный/стартовый"
                LD (IX + FRegion.InfluenceRadius), #02                          ; радиус влияния поселения

                ; генерация ключа
                CALL Math.Rand8
                LD (IX + FRegion.Seed.Low), A
                CALL Math.Rand8
                LD (IX + FRegion.Seed.High), A

                ; установка стартового положения камеры (игрока в мире)
                LD HL, (IY + FGenerateWorld.Center.X.Low)
                LD (PlayerState.CameraPosX + 1), HL
                LD (IX + FRegion.Location.X.Low), HL
                
                LD HL, (IY + FGenerateWorld.Center.Y.Low)
                LD (PlayerState.CameraPosY + 1), HL
                LD (IX + FRegion.Location.Y.Low), HL

                LD HL, (IY + FGenerateWorld.Center.X.High)
                LD (PlayerState.CameraPosX + 3), HL
                LD (IX + FRegion.Location.X.High), HL

                LD HL, (IY + FGenerateWorld.Center.Y.High)
                LD (PlayerState.CameraPosY + 3), HL
                LD (IX + FRegion.Location.Y.High), HL

                ; -----------------------------------------
                ; резервирование ячейки поселения
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; In:
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры метаданных
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Metadata.Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки

                ; установка ID региона
                EX AF, AF'
                LD (IX + FSettlement.RegionID), A

                ; ToDo добавить рандом от сложности игры

                ; доступные строения в поселении
                LD (IX + FSettlement.Building), BUILDING_ENTRANCE | BUILDING_RESIDENTIAL_AREA; | BUILDING_WAREHOUSE | BUILDING_SHOPPING_AREA | BUILDING_BAR | BUILDING_WORKSHOP | BUILDING_PRISON | BUILDING_RADIO_TOWER

                JP Region.Balancer                                              ; запуск балансировщика регионов

                display "\t- World:\t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_GENERATE_
