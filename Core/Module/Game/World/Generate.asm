
                ifndef _MODULE_GAME_WORLD_GENERATE_
                define _MODULE_GAME_WORLD_GENERATE_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       ; очистка спрайта мини карты
                LD HL, Adr.MinimapSpr + 128
                LD DE, #0000
                CALL SafeFill.b128

                ; -----------------------------------------
                ; центрирование мини карты по горизонтали
                ; -----------------------------------------

                ; положение карты по горизонтали            DEHL
                LD HL, (GameState.PositionX + 3)
                EX DE, HL
                LD HL, (GameState.PositionX + 1)
                
                ; вычесть половину смещения (центрирование)
                LD BC, SCR_MINIMAP_OFFSET_X
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
                LD HL, (GameState.PositionY + 3)
                EX DE, HL
                LD HL, (GameState.PositionY + 1)
                
                ; вычесть половину смещения (центрирование)
                LD BC, SCR_MINIMAP_OFFSET_Y
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE

                ; сохранить значение
                LD (.LocationY_L), HL
                LD (.LocationY_H), DE

                ; -----------------------------------------
                ; генерация спрайта мини карты
                ; -----------------------------------------
                LD DE, Adr.MinimapSpr
                LD C, SCR_MINIMAP_SIZE_X >> 1

.RowLoop        PUSH DE

                ; копирование положение карты по вертикали
.LocationY_L    EQU $+1
                LD HL, #0000
                LD (Math.PN_LocationY + 0), HL
.LocationY_H    EQU $+1
                LD HL, #0000
                LD (Math.PN_LocationY + 2), HL

                LD B, SCR_MINIMAP_SIZE_Y >> 1

.ColumnLoop     ;
                CALL .Noise

                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 01 | 02 | 03 | 04 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+

                EX DE, HL
                AND %11000000
                OR (HL)
                RLCA
                RLCA
                LD (HL), A

                INC L
                INC L
                INC L
                INC L
                EX DE, HL

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

                CALL .Noise

                EX DE, HL
                ADD A, A
                ADD A, A
                AND %11000000
                OR (HL)
                RLCA
                RLCA
                LD (HL), A

                INC L
                INC L
                INC L
                INC L
                EX DE, HL

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

                DJNZ .ColumnLoop

                ; INC 32
                LD HL, Math.PN_LocationX
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

                ;
                POP DE
                LD A, C
                DEC A
                AND #03
                JR NZ, $+3
                INC E

                ;
                DEC C
                JR NZ, .RowLoop

                RET

.Noise          EXX
                CALL Math.PerlinNoise2D
                ; LD A, L
                ; CP #10
                ; JR C, $+8
                ; AND %10100101
                ; RRCA
                ; XOR %10100101
                ; RLCA
                ; XOR %00101000

                ; BIT 6, L
                ; LD A, #00
                ; JR NZ, $+4
                ; LD A, #FF

                LD A, L
                ADD A, #70
                CP #80
                LD A, #FF
                JR C, $+3
                INC A

                ; LD A, L
                ; ADD A, #90
                ; CP #40
                ; LD A, L
                ; ADD A, A
                ; JR C, $+3
                ; LD A, #00

                EXX
                CPL
                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_
