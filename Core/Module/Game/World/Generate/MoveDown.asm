
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
                LD HL, (GameState.PositionX + 3)
                EX DE, HL
                LD HL, (GameState.PositionX + 1)
                
                ; прибавить смещение и ширину карты мира (правый край мини карты)
                LD BC, SCR_MINIMAP_SIZE_X - SCR_MINIMAP_OFFSET_X
                ADD HL, BC
                JR NC, $+3
                INC DE

                ; сохранить значение
                LD (Math.PN_LocationX + 0), HL
                LD (Math.PN_LocationX + 2), DE

                ; -----------------------------------------
                ; центрирование мини карты по вертикали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD HL, (GameState.PositionY + 3)
                EX DE, HL
                LD HL, (GameState.PositionY + 1)
                
                ; прибавить смещение и высоту карты мира (нижний край мини карты)
                LD BC, SCR_MINIMAP_SIZE_Y - SCR_MINIMAP_OFFSET_Y
                ADD HL, BC
                JR NC, $+3
                INC DE

                ; сохранить значение
                LD (Math.PN_LocationY + 0), HL
                LD (Math.PN_LocationY + 2), DE

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD HL, Adr.MinimapSpr + Size.MinimapSpr - 1                     ; адрес правого-нижнего байта спрайта
                                                                                ; сдвигаем снизу вверх
                LD B, SCR_MINIMAP_SIZE_Y >> 1
                LD A, (GameState.PositionX + 0)
                LD C, A
  
                ; если y = 1 (не выровнен), берётся только 1 значение из шума 01/02
                LD A, (GameState.PositionY + 0)
                ADD A, A
                JR NC, .Aligned

                ;
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
                

                ; смещение шума влево (значения 02), если х = 1
                BIT 1, C
                JR Z, $+3
                ADD A, A

                ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L

.RollLoop       EX DE, HL

                ; DEC 32
                LD HL, Math.PN_LocationY
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, $+21
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, $+14
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, $+7
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A

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

                ; меняем местами значени 01/02 и 03/04
                LD D, A
                RR D
                RR D
                ADD A, A
                ADD A, A
                XOR D
                AND %11000000
                XOR D

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 03 | 04 | 01 | 02 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                ; смещение шума влево (значения 02 и 04), если х = 1
                BIT 1, C
                JR Z, $+3
                ADD A, A

                ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L

                ADD A, A

                ; сдвиг строки влево на 1 пиксель
                ADD A, A
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L
                RL (HL)
                DEC L

                DJNZ .RollLoop

                RES_WORLD_FLAG WORLD_DOWN_BIT

                RET

                display " - Move down: \t\t\t\t\t", /A, MoveDown, " = busy [ ", /D, $ - MoveDown, " bytes  ]"

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_DOWN_
