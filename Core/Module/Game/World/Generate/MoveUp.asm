
                ifndef _MODULE_GAME_WORLD_GENERATE_MOVE_UP_
                define _MODULE_GAME_WORLD_GENERATE_MOVE_UP_
; -----------------------------------------
; генерация мини карты (скрол вверх)
; In:
; Out:
; Corrupt:
; Note:
;   шаг 1 пикселя
; -----------------------------------------
MoveUp:         ; -----------------------------------------
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

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE
                CALL Kernel.Math.PerlinNoise2D.Y_

                ; сдвигаем спрайт мини карты на одну строку ниже
                LD HL, Adr.MinimapSpr + Size.MinimapSpr - 4 - 1                 ; адрес левого-верхнего байта спрайта (-1 строка)
                LD DE, Adr.MinimapSpr + Size.MinimapSpr - 1                     ; адрес левого-верхнего байта спрайта
                LD BC, Size.MinimapSpr - 4
                LDDR

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                INC L
.RowLoop        LD B, 8
.RollLoop       ;
                EXX
                CALL Kernel.Math.PerlinNoise2D.X
                CALL Generate.Noise

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
                JR Z, .RowLoop

                CALL .Tile

                RES_WORLD_FLAG WORLD_UP_BIT

                RET

.Tile           ; сдвигаем всё вниз на высоту видимой чати карты (правый нижний)
                LD HL, RenderBuffer + SCR_WORLD_SIZE_X * (SCR_WORLD_SIZE_Y + 1) - 2
                LD DE, RenderBuffer + SCR_WORLD_SIZE_X * (SCR_WORLD_SIZE_Y + 1) - 1
                LD BC, (SCR_WORLD_SIZE_Y + 1) - 1
                LD A, C
                LDDR

                rept SCR_WORLD_SIZE_X - 1
                DEC E
                DEC L
                LD C, A
                LDDR
                endr

                ; -----------------------------------------
                LD BC, Adr.MinimapSpr + 1 + 4 * 10 - 4                          ; адрес левой-верхней грани видимой части карты мира (-1 строка)
.AdaptTilepair  LD HL, .BufferUp

                ; -----------------------------------------
                ; копирование Up
                ; -----------------------------------------
                LD A, (BC)
                LD (HL), A
                INC C
                INC L
                LD A, (BC)
                LD (HL), A
                INC C
                INC C
                INC C

                ; -----------------------------------------
                ; копирование Left/Right
                ; -----------------------------------------
                LD L, LOW .BufferRight
                LD A, (BC)
                LD (HL), A
                INC L
                INC L
                LD (HL), A
                DEC L
                INC C
                LD A, (BC)
                LD (HL), A
                INC L
                INC L
                LD (HL), A
                INC C
                INC C
                INC C

                ; -----------------------------------------
                ; копирование Down
                ; -----------------------------------------
                LD L, LOW .BufferDown
                LD A, (BC)
                LD (HL), A
                INC C
                INC L
                LD A, (BC)
                LD (HL), A

                ; -----------------------------------------
                ; сдвиг Down
                ; -----------------------------------------
                RL (HL)
                DEC L
                RL (HL)
                DEC L

                ; -----------------------------------------
                ; сдвиг Up
                ; -----------------------------------------
                RL (HL)
                DEC L
                RL (HL)
                DEC L

                DEC L
                DEC L

                ; -----------------------------------------
                ; сдвиг Left/Right
                ; -----------------------------------------
                RL (HL)
                DEC L
                RL (HL)
                INC L
                RL (HL)
                DEC L
                RL (HL)

                ; -----------------------------------------
                ; -----------------------------------------
                LD L, LOW .BufferLast
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                ADC A, A
                
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                ADC A, A

                RL (HL)
                DEC L
                RL (HL)
                LD C, (HL)
                DEC L
                ADC A, A

                RL (HL)
                DEC L
                RL (HL)
                ADC A, A

                ; проверка, что бит не пустой
                BIT 7, C
                JR Z, $+4                                                       ; проверка, что тайл является пустым
                LD A, #0F

                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                LD B, A

                ;
                ;   значение в регистре B
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | D  | U  | L  | R  | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                LD A, SCR_WORLD_SIZE_X
.TileLoop       EX AF, AF

                ; -----------------------------------------
                ; -----------------------------------------
                LD L, LOW .BufferLast
                XOR A
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                ADC A, A
                
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                ADC A, A

                RL (HL)
                DEC L
                RL (HL)
                LD C, (HL)
                DEC L
                ADC A, A

                RL (HL)
                DEC L
                RL (HL)
                ADC A, A

                ; проверка, что бит не пустой
                BIT 7, C
                JR Z, $+4                                                       ; проверка, что тайл является пустым
                LD A, #0F

                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | D  | U  | L  | R  |
                ;   +----+----+----+----+----+----+----+----+

                ; совмещение левого тайла (7..4 биты) и текущую выбоку (3..0)
                OR B
                
                ;
                ;   значение в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | I3 | I2 | I1 | I0 | D  | U  | L  | R  |
                ;   +----+----+----+----+----+----+----+----+

                ; сохраним тайлопару
                LD (DE), A

                ;
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                LD B, A

                ;
                LD A, E
                ADD A, SCR_WORLD_SIZE_Y + 1
                LD E, A

                EX AF, AF'
                DEC A
                JR NZ, .TileLoop
 
                RET

.Buffer         DS 8, 0
.BufferRight    EQU .Buffer + 0
.BufferLeft     EQU .Buffer + 2
.BufferUp       EQU .Buffer + 4
.BufferDown     EQU .Buffer + 6
.BufferLast     EQU $-1

                if (.Buffer >> 8) - ($ >> 8)
                error "must be within single 256 byte block"
                endif

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_UP_
