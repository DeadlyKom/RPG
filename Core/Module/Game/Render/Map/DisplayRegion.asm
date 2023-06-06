
                ifndef _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_REGION_
                define _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_REGION_
VISIBLE_REGION_SCR  EQU 22
; -----------------------------------------
; отображение регионов карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayRegion:  SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; инициализация
                LD HL, Adr.MapBuffer + 18 * MAP_SIZE_SMALL_SQUARED + 20
                SCREEN_ATTR_ADR_REG DE, #4000, 1, 1

                ; -----------------------------------------
                ; получить размер карты (из настроек)
                ; In:
                ;   C - размер карты
                ; -----------------------------------------
                CALL Packs.Map.GetMapSize
                LD A, VISIBLE_REGION_SCR

.LoopY          EX AF, AF'
                LD B, VISIBLE_REGION_SCR
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
                SUB VISIBLE_REGION_SCR
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
