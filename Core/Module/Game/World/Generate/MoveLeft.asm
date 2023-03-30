
                ifndef _MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
                define _MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
; -----------------------------------------
; генерация мини карты (скрол влево)
; In:
; Out:
; Corrupt:
; Note:
;   шаг 1 пикселя
; -----------------------------------------
MoveLeft:       ; -----------------------------------------
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
                
                ; вычесть половину смещения (верхний край мини карты)
                LD BC, SCR_MINIMAP_OFFSET_Y >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD HL, Adr.MinimapSpr                                           ; адрес левого-вверхний байта спрайта
                                                                                ; сдвигаем сверху вниз
                LD B, SCR_MINIMAP_SIZE_Y >> 1
                LD A, (GameState.PositionX + 1)
                LD C, A
  
                ; если y = 1 (не выровнен), берётся только 1 значение из шума 03/04
                LD A, (GameState.PositionY + 1)
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

                ; смещение до 03 значения
                ADD A, A
                ADD A, A

                ; смещение шума влево (значения 04), если х = 1
                BIT 0, C
                JR Z, $+3
                ADD A, A

                ; сдвиг строки вправо на 1 пиксель
                ADD A, A
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L

.RollLoop       EX DE, HL

                ; INC 32
                LD HL, Math.PN_LocationY
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

.Aligned        CALL Generate.Noise

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 01 | 02 | 03 | 04 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   при сдвиге влево берутся значения
                ;       01/03, если x = 0
                ;       02/04, если x = 1

                ; смещение шума влево (значения 02 и 04), если х = 1
                BIT 0, C
                JR Z, $+3
                ADD A, A

                ; сдвиг строки вправо на 1 пиксель
                ADD A, A
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L

                ADD A, A

                ; сдвиг строки вправо на 1 пиксель
                ADD A, A
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L
                RR (HL)
                INC L

                DJNZ .RollLoop

                RES_WORLD_FLAG WORLD_LEFT_BIT

                RET
                
                ; LD HL, RenderBuffer + (SCR_WORLD_SIZE_X - 1) * SCR_WORLD_SIZE_Y
                ; LD DE, RenderBuffer + (SCR_WORLD_SIZE_X + 0) * SCR_WORLD_SIZE_Y
                ; LD BC, (SCR_WORLD_SIZE_X - 1) * SCR_WORLD_SIZE_Y
                ; LDDR
                ; RET

                display " - Move left: \t\t\t\t\t", /A, MoveLeft, " = busy [ ", /D, $ - MoveLeft, " bytes  ]"

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
