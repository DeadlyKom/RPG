
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_DOWN_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_DOWN_
; -----------------------------------------
; генерация мини карты (скрол вниз)
; In:
; Out:
; Corrupt:
; Note:
;   шаг 1 пикселя
; -----------------------------------------
MoveDown:       ; -----------------------------------------
                ; центрирование мини карты по горизонтали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD DE, (PlayerState.CameraPosX + 3)
                LD HL, (PlayerState.CameraPosX + 1)

                ; сохранить значение
                LD (Math.PN_LocationX + 0), HL
                LD (Math.PN_LocationX + 2), DE

                ; -----------------------------------------
                ; центрирование мини карты по вертикали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD DE, (PlayerState.CameraPosY + 3)
                LD HL, (PlayerState.CameraPosY + 1)

                ; прибавить смещение и ширину карты мира (правый край мини карты)
                LD BC, SCR_MINIMAP_SIZE_Y
                ADD HL, BC
                JR NC, $+3
                INC DE

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE
                CALL Kernel.Math.PerlinNoise2D.Y_

                ; сдвигаем спрайт мини карты на одну строку выше
                LD HL, Adr.MinimapSpr + 4                                       ; адрес левого-нижнего байта спрайта (+1 строка)
                LD DE, Adr.MinimapSpr                                           ; адрес левого-нижнего байта спрайта
                LD BC, Size.MinimapSpr - 4
                CALL Memcpy.FastLDIR

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                EX DE, HL
.RowLoop        LD B, 8
                
.RollLoop       ; 
                EXX
                CALL Kernel.Math.PerlinNoise2D.X
                CALL WastelandNoise

                ; сдвиг на 1 пиксель
                ADD A, A
                RL (HL)

                EX DE, HL
                ; INC 32
                LD HL, Math.PN_LocationX
                INC (HL)
                JR NZ, $+12
                INC L
                INC (HL)
                JR NZ, $+8
                INC L
                INC (HL)
                JR NZ, $+4
                INC L
                INC (HL)
                EX DE, HL

                DJNZ .RollLoop

                INC L
                BIT 2, L
                JR NZ, .RowLoop

                CALL .Tile

                RES_WORLD_FLAG WORLD_DOWN_BIT

                RET

.Tile           ; сдвигаем всё вверх на высоту видимой чати карты (левый вверхний)
                LD HL, RenderBuffer + 1
                LD DE, RenderBuffer + 0
                LD BC, (SCR_WASTELAND_SIZE_Y + 1) - 1
                LD A, C
                LDIR

                rept SCR_WASTELAND_SIZE_X - 1
                INC E
                INC L
                LD C, A
                LDIR
                endr

                LD DE, RenderBuffer + (SCR_WASTELAND_SIZE_Y + 1) - 1
                ; -----------------------------------------
                LD BC, Adr.MinimapSpr + 1 + 4 * 20 - 4                          ; адрес левой-нижней грани видимой части карты мира (-1 строка)
                JP MoveUp.AdaptTilepair

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_DOWN_
