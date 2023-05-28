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

                ; ToDo переделать на нормальный
                LD IX, SETTLEMENT_ADR

                ; -----------------------------------------
                ; инициализация первого поселения
                ; -----------------------------------------

                ; тип поселения
                LD (IX + FSettlement.Type), SETTLEMENT_BEGIN
                
                ; позиция поселения в мире
                LD HL, #0000
                LD (PlayerState.CameraPosX + 1), HL
                LD (PlayerState.CameraPosY + 1), HL
                LD (IX + FSettlement.Location.X.Low), HL
                LD (IX + FSettlement.Location.Y.Low), HL
                
                CALL .RND_16
                LD (PlayerState.CameraPosX + 3), HL
                LD (IX + FSettlement.Location.X.High), HL

                CALL .RND_16
                LD (PlayerState.CameraPosY + 3), HL
                LD (IX + FSettlement.Location.Y.High), HL

                ; доступные строения в поселении
                LD (IX + FSettlement.Building), BUILDING_ENTRANCE | BUILDING_RESIDENTIAL_AREA; | BUILDING_WAREHOUSE | BUILDING_SHOPPING_AREA | BUILDING_BAR | BUILDING_WORKSHOP | BUILDING_PRISON | BUILDING_RADIO_TOWER

                ; генерация ключа
                CALL Math.Rand8
                LD (IX + FSettlement.Seed.Low), A
                CALL Math.Rand8
                LD (IX + FSettlement.Seed.High), A

                RET

.RND_16         CALL Math.Rand8
                EX AF, AF'
                CALL Math.Rand8
                LD L, A
                EX AF, AF'
                LD H, A
                RET

                display "\t- World:\t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_GENERATE_
