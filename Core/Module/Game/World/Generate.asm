
                ifndef _MODULE_GAME_WORLD_GENERATE_
                define _MODULE_GAME_WORLD_GENERATE_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       ; -----------------------------------------
                ; генерация спрайта мини карты
                ; -----------------------------------------

                LD A, SCR_MINIMAP_SIZE_Y >> 1

.Loop           EX AF, AF'
                CALL MoveRight
                CALL MoveRight

                ; INC 32
                LD HL, GameState.PositionX + 1
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

                EX AF, AF'
                DEC A
                JR NZ, .Loop

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

                ; BIT 7, L
                ; LD A, #FF
                ; JR Z, $+3
                ; INC A

                LD A, L
                ADD A, #10
                CP #60
                LD A, #FF
                JR NC, $+3
                INC A

                ; LD A, L
                ; ADD A, #90
                ; CP #40
                ; LD A, L
                ; ADD A, A
                ; JR C, $+3
                ; LD A, #00

                EXX
                ; CPL
                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_
