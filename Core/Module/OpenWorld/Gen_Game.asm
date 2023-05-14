                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_
; -----------------------------------------
; генерация мира игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_Game:       ; инициализация мира
                include "Initialize.asm"

                ; ToDo переделать на нормальный
                LD IX, Adr.Settlement

                ; -----------------------------------------
                ; инициализация первого поселения
                ; -----------------------------------------

                ; тип поселения
                LD (IX + FSettlement.Type), SETTLEMENT_BEGIN
                
                ; позиция поселения в мире
                LD HL, #0000
                LD (IX + FSettlement.Location.X.Low), HL
                LD HL, #0000
                LD (IX + FSettlement.Location.Y.Low), HL
                LD HL, #1000
                LD (IX + FSettlement.Location.X.High), HL
                LD (IX + FSettlement.Location.Y.High), HL

                ; доступные строения в поселении
                LD (IX + FSettlement.Building), BUILDING_ENTRANCE | BUILDING_RESIDENTIAL_AREA | BUILDING_WAREHOUSE | BUILDING_SHOPPING_AREA | BUILDING_BAR | BUILDING_WORKSHOP | BUILDING_PRISON | BUILDING_RADIO_TOWER

                ; генерация ключа
                CALL Math.Rand8
                LD (IX + FSettlement.Seed.Low), A
                CALL Math.Rand8
                LD (IX + FSettlement.Seed.High), A

                RET

                display " - Generate 'WORLD':\t\t\t\t\t", /A, Generate, " = busy [ ", /D, $ - Generate, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_GENERATE_
