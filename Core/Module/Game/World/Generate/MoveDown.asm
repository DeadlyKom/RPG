
                ifndef _MODULE_GAME_WORLD_GENERATE_MOVE_DOWN_
                define _MODULE_GAME_WORLD_GENERATE_MOVE_DOWN_
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
                LD DE, (GameState.PositionX + 3)
                LD HL, (GameState.PositionX + 1)
                
                ; вычесть половину смещения (левый край мини карты)
                LD BC, SCR_MINIMAP_OFFSET_X >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE

                ; сохранить значение
                LD (Math.PN_LocationX + 0), HL
                LD (Math.PN_LocationX + 2), DE

                ; -----------------------------------------
                ; центрирование мини карты по вертикали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD DE, (GameState.PositionY + 3)
                LD HL, (GameState.PositionY + 1)
                
                ; прибавить смещение и высоту карты мира (нижний край мини карты)
                LD BC, (SCR_MINIMAP_SIZE_Y - SCR_MINIMAP_OFFSET_Y) >> 1
                ADD HL, BC
                JR NC, $+3
                INC DE

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE

                ; сдвигаем спрайт мини карты на одну строку выше
                LD HL, Adr.MinimapSpr + 4                                       ; адрес левого-нижнего байта спрайта (+1 строка)
                LD DE, Adr.MinimapSpr                                           ; адрес левого-нижнего байта спрайта
                LD BC, Size.MinimapSpr - 4
                CALL Memcpy.FastLDIR

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                EX DE, HL
                ;LD HL, Adr.MinimapSpr                                           ; адрес левого-вверхний байта спрайта
                                                                                ; сдвигаем снизу вверх
                LD B, 4;SCR_MINIMAP_SIZE_X >> 1
                LD A, (GameState.PositionY + 1)
                LD C, A
  
                ; если x = 1 (не выровнен), берётся только 1 значение из шума 02/04
                LD A, (GameState.PositionX + 1)
                ADD A, A
                JR NC, .Aligned

                DEC B                                                           ; на 1 строку меньше
                CALL Generate.Noise

                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 01 | 02 | 03 | 04 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   при сдвиге влево берутся значения
                ;       01/03, если x = 0
                ;       02/04, если x = 1

                ; смещение до 02 значения
                ADD A, A

                ; смещение шума влево (значения 04), если y = 1
                BIT 0, C
                JR Z, $+4
                ADD A, A
                ADD A, A

.L11            ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)

.RollLoop       EX DE, HL

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

.Aligned        ;
                CALL Generate.Noise

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 01 | 02 | 03 | 04 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   при сдвиге влево берутся значения
                ;       01/03, если x = 0
                ;       02/04, если x = 1

                ; смещение шума влево (значения 02 и 04), если y = 1
                BIT 0, C
                JR Z, $+4
                ADD A, A
                ADD A, A

                ; сдвиг на 1 пиксель
                ADD A, A
                RL (HL)

                ; сдвиг на 1 пиксель
                ADD A, A
                RL (HL)

                DJNZ .RollLoop

                LD B, 4;SCR_MINIMAP_SIZE_X >> 1

                ; если x = 1 (не выровнен), берётся только 1 значение из шума 02/04
                LD A, (GameState.PositionX + 1)
                ADD A, A
                JR NC, .Aligned_

                DEC B

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

                CALL Generate.Noise

                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 01 | 02 | 03 | 04 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   при сдвиге влево берутся значения
                ;       01/03, если x = 0
                ;       02/04, если x = 1

                ; смещение шума влево (значения 04), если y = 1
                BIT 0, C
                JR Z, $+4
                ADD A, A
                ADD A, A

                ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)

.Aligned_       INC L
                BIT 2, L
                JR NZ, .L11

                CALL .Tile

                RES_WORLD_FLAG WORLD_DOWN_BIT

                RET

.Tile           ; сдвигаем всё вверх на высоту видимой чати карты (левый вверхний)
                LD HL, RenderBuffer + 1
                LD DE, RenderBuffer + 0
                LD BC, (SCR_WORLD_SIZE_Y + 1) - 1
                LD A, C
                LDIR

                rept SCR_WORLD_SIZE_X - 1
                INC E
                INC L
                LD C, A
                LDIR
                endr

                LD DE, RenderBuffer + (SCR_WORLD_SIZE_Y + 1) - 1
                LD BC, Adr.MinimapSpr + 1 + 4 * 20 - 4                          ; адрес левой-нижней грани видимой части карты мира (-1 строка)
                JP MoveUp.Test

                display " - Move down: \t\t\t\t\t", /A, MoveDown, " = busy [ ", /D, $ - MoveDown, " bytes  ]"

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_DOWN_
