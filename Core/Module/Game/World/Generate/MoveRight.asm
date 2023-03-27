
                ifndef _MODULE_GAME_WORLD_GENERATE_MOVE_RIGHT_
                define _MODULE_GAME_WORLD_GENERATE_MOVE_RIGHT_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveRight:      ; положение карты по горизонтали            DEHL
                LD HL, (GameState.PositionX + 2)
                EX DE, HL
                LD HL, (GameState.PositionX + 0)
                
                ; прибавить к оси X смещение ширины карты
                LD BC, SCR_WORLD_SIZE_X-1
                ADD HL, BC
                JR NC, $+3
                INC DE

                ; сохранить значение
                LD (Math.PN_LocationX + 0), HL
                LD (Math.PN_LocationX + 2), DE

                ; копирование положение карты по вертикали
                LD HL, (GameState.PositionY + 0)
                LD (Math.PN_LocationY + 0), HL
                LD HL, (GameState.PositionY + 2)
                LD (Math.PN_LocationY + 2), HL

                ; сдвигаем всё влево на высоту видимой чати карты
                LD HL, RenderBuffer +  SCR_WORLD_SIZE_Y
                LD DE, RenderBuffer
                LD BC, (SCR_WORLD_SIZE_X - 1) * SCR_WORLD_SIZE_Y
                CALL Memcpy.FastLDIR

                ;
                LD B, SCR_WORLD_SIZE_Y

.Loop           ;
                LD HL, -SCR_WORLD_SIZE_Y
                ADD HL, DE
                LD A, (HL)

                ;
                EXX
                CALL Tilepair
                EXX

                ; сохраним тайлопару
                LD (DE), A
                INC DE

                ; INC 32
                LD HL, Math.PN_LocationY
                INC (HL)
                JR NZ, $+12
                INC HL
                INC (HL)
                JR NZ, $+8
                INC HL
                INC (HL)
                JR NZ, $+4
                INC HL
                INC (HL)

                DJNZ .Loop

                SET_RENDER_FLAG GEN_BIT

                CALL Game.World.Generate

                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_RIGHT_
