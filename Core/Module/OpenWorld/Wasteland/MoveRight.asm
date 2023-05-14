
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_RIGHT_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_RIGHT_
; -----------------------------------------
; генерация мини карты (скрол вправо)
; In:
; Out:
; Corrupt:
; Note:
;   шаг 1 пикселя
; -----------------------------------------
MoveRight:      ; -----------------------------------------
                ; центрирование мини карты по горизонтали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD DE, (PlayerState.CameraPosX + 3)
                LD HL, (PlayerState.CameraPosX + 1)
                
                ; прибавить смещение и ширину карты мира (правый край мини карты)
                LD BC, SCR_MINIMAP_SIZE_X
                ADD HL, BC
                JR NC, $+3
                INC DE

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
                LD HL, Adr.MinimapSpr + 3                                       ; адрес правого-вехнего байта спрайта
                LD B, SCR_MINIMAP_SIZE_Y

.RollLoop       ; 
                EXX
                CALL Kernel.Math.PerlinNoise2D.Y
                CALL WastelandNoise

                ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                
                LD A, L
                ADD A, 3 + 4
                LD L, A

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

                RES_WORLD_FLAG WORLD_RIGHT_BIT

                RET

.Tile           ; сдвигаем всё влево на ширину видимой чати карты
                LD HL, RenderBuffer + (SCR_WORLD_SIZE_Y + 1)
                LD DE, RenderBuffer
                LD BC, (SCR_WORLD_SIZE_X - 1) * (SCR_WORLD_SIZE_Y + 1)
                CALL Memcpy.FastLDIR

                LD HL, Adr.MinimapSpr + 2 + 4 * 10 - 4                          ; адрес правой грани видимой части карты мира (-1 строка)
                LD A, SCR_WORLD_SIZE_Y + 1

.TileLoop       EX AF, AF

                LD C, (HL)
                INC L
                INC L
                INC L
                INC L

                ; проверка, что бит не пустой
                BIT 3, (HL)
                LD A, #0F
                JR NZ, .Fill                                                    ; нет необходимости проверки, что находится вокруг
                                                                                ; тайл является полностью зарисованным
                LD A, (HL)

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | L  | 0  | R  | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                RRA
                RRA
                LD B, A
                RRA
                RRA
                RR B
                RLA

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | .. | .. | L  | R  |
                ;   +----+----+----+----+----+----+----+----+

                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | U  | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                RR C
                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | .. | U  | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                XOR C
                AND %00000011
                XOR C

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | .. | U  | L  | R  |
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
                ;   | .. | .. | .. | .. | D  | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                XOR (HL)
                AND %00000111
                XOR (HL)
                LD L, B                                                         ; восстановление адреса (положение для следующей проверки)

.Fill           ; значение результата выборки в аккумуляторе
                LD C, A

                ;
                ;   значение в регистре C
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | D  | U  | L  | R  |
                ;   +----+----+----+----+----+----+----+----+
                LD B, E                                                         ; сохранение адреса (текущий адрес тайла)

                ; смещение адреса на тайл левее
                LD A, E
                SUB SCR_WORLD_SIZE_Y + 1
                LD E, A

                ; совмещение левого тайла (3..0 биты) и текущую выбоку
                LD A, (DE)
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                XOR C
                AND %11110000
                XOR C
                LD E, B                                                         ; восстановление адреса (текущий адрес тайла)

                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | I3 | I2 | I1 | I0 | D  | U  | L  | R  |
                ;   +----+----+----+----+----+----+----+----+

                ; сохраним тайлопару
                LD (DE), A
                INC E

                EX AF, AF'
                DEC A
                JR NZ, .TileLoop

                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_MOVE_RIGHT_
