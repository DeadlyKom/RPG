
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_LEFT_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_LEFT_
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
                LD DE, (PlayerState.CameraPosX + 3)
                LD HL, (PlayerState.CameraPosX + 1)

                ; сохранить значение
                LD (Math.PN_LocationX + 0), HL
                LD (Math.PN_LocationX + 2), DE
                CALL Kernel.Math.PerlinNoise2D.X_

                ; -----------------------------------------
                ; центрирование мини карты по вертикали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD DE, (PlayerState.CameraPosY + 3)
                LD HL, (PlayerState.CameraPosY + 1)

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD HL, Adr.MinimapSpr                                           ; адрес левого-вверхний байта спрайта
                LD B, SCR_MINIMAP_SIZE_Y

.RollLoop       ; 
                EXX
                CALL Kernel.Math.PerlinNoise2D.Y
                CALL WastelandNoise

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

                EX DE, HL
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

                DJNZ .RollLoop

                CALL .Tile

                RES_WORLD_FLAG WORLD_LEFT_BIT

                RET

.Tile           ; сдвигаем всё вправо на ширину видимой чати карты
                LD HL, RenderBuffer + (SCR_WASTELAND_SIZE_X - 1) * (SCR_WASTELAND_SIZE_Y + 1) - 1
                LD DE, RenderBuffer + (SCR_WASTELAND_SIZE_X + 0) * (SCR_WASTELAND_SIZE_Y + 1) - 1
                LD BC, (SCR_WASTELAND_SIZE_X - 1) * (SCR_WASTELAND_SIZE_Y + 1)
                LDDR

                INC HL
                EX DE, HL

                LD HL, Adr.MinimapSpr + 1 + 4 * 10 - 4                          ; адрес левой грани видимой части карты мира (-1 строка)
                LD A, SCR_WASTELAND_SIZE_Y + 1

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
                ADD A, (SCR_WASTELAND_SIZE_Y + 1)
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

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_LEFT_
