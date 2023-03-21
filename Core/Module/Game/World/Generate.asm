
                ifndef _MODULE_GAME_WORLD_GENERATE_
                define _MODULE_GAME_WORLD_GENERATE_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       LD HL, RenderBuffer
.X              EQU $+1
                LD DE, #0000
.Y              EQU $+1
                LD BC, #0000
                LD (Math.PN_LocationX), DE
                LD (Math.PN_LocationY), BC
                EXX
                LD C, SCR_WORLD_SIZE_X + 1

.ColumnLoop     EXX
                PUSH BC
                EXX
                
                LD B, SCR_WORLD_SIZE_Y
.RowsLoop       EXX

                PUSH HL
                PUSH DE
                PUSH BC
                CALL Math.PerlinNoise2D
                POP BC
                POP DE

                LD A, L
                XOR H
                CP #10
                JR C, $+8
                AND %10100101
                RRCA
                XOR %10100101
                RLCA
                XOR %00101000

                POP HL

                LD (HL), A
                INC HL

                INC BC
                LD (Math.PN_LocationY), BC

                EXX
                DJNZ .RowsLoop

                EXX
                POP BC
                INC DE
                LD (Math.PN_LocationX), DE
                EXX
                DEC C
                JR NZ, .ColumnLoop

                SET_RENDER_FLAG GEN_BIT
                
                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_
