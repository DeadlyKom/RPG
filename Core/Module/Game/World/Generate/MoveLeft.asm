
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
                ; ADD A, A
                RRA
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

                ; -----------------------------------------
                LD A, (GameState.PositionY + 1)
                ; ADD A, A
                RRA
                JR NC, .Aligned_

                CALL Generate.Noise

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
.Aligned_
                ; -----------------------------------------

                CALL .Tile

                RES_WORLD_FLAG WORLD_LEFT_BIT

                RET

.Tile           ; сдвигаем всё вправо на ширину видимой чати карты
                LD HL, RenderBuffer + (SCR_WORLD_SIZE_X - 1) * (SCR_WORLD_SIZE_Y + 1) - 1
                LD DE, RenderBuffer + (SCR_WORLD_SIZE_X + 0) * (SCR_WORLD_SIZE_Y + 1) - 1
                LD BC, (SCR_WORLD_SIZE_X - 1) * (SCR_WORLD_SIZE_Y + 1)
                LDDR

                INC HL
                EX DE, HL

                LD HL, Adr.MinimapSpr + 1 + 4 * 10 - 4                          ; адрес левой грани видимой части карты мира (-1 строка)
                LD A, SCR_WORLD_SIZE_Y + 1

.TileLoop       EX AF, AF'

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | U  | .. | .. | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                LD C, (HL)
                INC L
                INC L
                INC L
                INC L

                ; проверка, что бит не пустой
                BIT 6, (HL)
                LD A, #F0
                JR NZ, .Fill                                                    ; нет необходимости проверки, что находится вокруг
                                                                                ; тайл является полностью зарисованным
                LD A, (HL)

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | L  | 0  | R  | .. | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                ; ADD A, A
                LD B, A
                ADD A, A
                ADD A, A
                RL B
                RRA
                RRA
                RRA

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | L  | R  | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                ; RL C

                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | U  | .. | .. | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                XOR C
                AND %00110000
                XOR C

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | U  | L  | R  | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                LD B, L                                                         ; сохранени адреса (положение для следующей проверки)
                INC L
                INC L
                INC L
                INC L

                ;
                ;   значение в (HL)
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | D  | .. | .. | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                LD C, (HL)
                RL C

                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | D  | .. | .. | .. | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                XOR C
                AND %01110000
                XOR C
                LD L, B                                                         ; восстановление адреса (положение для следующей проверки)

.Fill           ; значение выборки в аккумуляторе
                LD C, A

                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | D  | U  | L  | R  | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                LD B, E                                                         ; сохранение адреса (текущий адрес тайла)

                ; смещение адреса на тайл левее
                LD A, E
                ADD A, (SCR_WORLD_SIZE_Y + 1)
                LD E, A

                ; совмещение левого тайла (3..0 биты) и текущую выбоку
                LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                XOR C
                AND %00001111
                XOR C
                LD E, B                                                         ; восстановление адреса (текущий адрес тайла)

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | D  | U  | L  | R  | I3 | I2 | I1 | I0 |
                ;   +----+----+----+----+----+----+----+----+

                ; сохраним тайлопару
                LD (DE), A
                INC E

                EX AF, AF'
                DEC A
                JR NZ, .TileLoop

                RET

                display " - Move left: \t\t\t\t\t", /A, MoveLeft, " = busy [ ", /D, $ - MoveLeft, " bytes  ]"

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
