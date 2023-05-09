                ifndef _CORE_MODULE_GENERATE_WORLD_
                define _CORE_MODULE_GENERATE_WORLD_
; -----------------------------------------
; генерация мира игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          ; инициализация мира
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
                
                RET

                display " - Generate 'WORLD':\t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"

                endif ; ~ _CORE_MODULE_GENERATE_WORLD_
