
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
                LD DE, (PlayerState.PositionX + 3)
                LD HL, (PlayerState.PositionX + 1)
                
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
                LD DE, (PlayerState.PositionY + 3)
                LD HL, (PlayerState.PositionY + 1)
                
                ; вычесть половину смещения (верхний край мини карты)
                LD BC, SCR_MINIMAP_OFFSET_Y >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE

                ; сдвигаем спрайт мини карты на одну строку ниже
                LD HL, Adr.MinimapSpr + Size.MinimapSpr - 4 - 1                 ; адрес левого-верхнего байта спрайта (-1 строка)
                LD DE, Adr.MinimapSpr + Size.MinimapSpr - 1                     ; адрес левого-верхнего байта спрайта
                LD BC, Size.MinimapSpr - 4
                LDDR

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                INC L
                ; EX DE, HL
                ;LD HL, Adr.MinimapSpr                                           ; адрес левого-вверхний байта спрайта
                                                                                ; сдвигаем снизу вверх
                LD B, 4;SCR_MINIMAP_SIZE_X >> 1
                LD A, (PlayerState.PositionY + 1)
                LD C, A
  
                ; если x = 1 (не выровнен), берётся только 1 значение из шума 02/04
                LD A, (PlayerState.PositionX + 1)
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
                LD A, (PlayerState.PositionX + 1)
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
                JR Z, .L11

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
.Test           LD HL, .BufferUp

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

                display " - Move up: \t\t\t\t\t\t", /A, MoveUp, " = busy [ ", /D, $ - MoveUp, " bytes  ]"

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_UP_
