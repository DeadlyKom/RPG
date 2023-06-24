
                ifndef _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_REGION_
                define _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_REGION_
; -----------------------------------------
; отображение регионов карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayRegion:  SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------

                ; расчёт адреса выводимой области
                ; Adr.MapBuffer + MapPosY * MapSize + MapPosX

                ; -----------------------------------------
                ; получить размер карты (из настроек)
                ; In:
                ;   C - размер карты
                ; -----------------------------------------
                CALL Packs.Map.GetMapSize
                LD D, #00
                LD E, C
                LD A, (PlayerState.MapPosY)
                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                CALL Math.Mul16x8_16
                LD A, (PlayerState.MapPosX)
                LD E, A
                ADD HL, DE
                LD DE, Adr.MapBuffer
                ADD HL, DE

                SCREEN_ATTR_ADR_REG DE, #4000, SCR_MAP_POS_X, SCR_MAP_POS_Y     ; адрес области атрибутов (вывода карты)

                LD A, SCR_MAP_SIZE_X

.LoopY          EX AF, AF'
                LD B, SCR_MAP_SIZE_X
                PUSH HL

.LoopX          LD A, (HL)
                INC HL
                ADD A, A
                ADD A, A
                ADD A, A
                LD (DE), A
                INC E
                DJNZ .LoopX

                POP HL
                ADD HL, BC

                LD A, E
                SUB SCR_MAP_SIZE_X
                ADD A, #20
                LD E, A
                ADC A, D
                SUB E
                LD D, A

                EX AF, AF'
                DEC A
                JR NZ, .LoopY

                RET

                endif ; ~_MODULE_GAME_RENDER_MAP_DISPLAY_MAP_REGION_
