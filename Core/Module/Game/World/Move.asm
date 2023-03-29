
                ifndef _MODULE_GAME_WORLD_MOVE_
                define _MODULE_GAME_WORLD_MOVE_

Left:           SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationX)
                SUB (HL)
                JR NC, .L1

                ; DEC 40
                LD HL, GameState.PositionX
                LD C, #01
                LD A, (HL)
                SUB #80
                LD (HL), A
                JR NC, $+24
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+18
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+12
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+6
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A

                SET_WORLD_FLAG WORLD_LEFT_BIT

                LD A, #EE
.L1             LD (LocationX), A
                AND #0F
                LD (World.Shift_X), A
                RET

Right:          SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationX)
                ADD A, (HL)
                JR NC, .L1

                ; INC 40
                LD HL, GameState.PositionX
                LD A, #80
                ADD A, (HL)
                LD (HL), A
                JR NC, $+16
                INC L
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

                SET_WORLD_FLAG WORLD_RIGHT_BIT

                XOR A
.L1             LD (LocationX), A
                AND #0F
                LD (World.Shift_X), A
                RET

Up:             SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationY)
                ADD A, (HL)
                JR NC, .L1

                ; DEC 40
                LD HL, GameState.PositionX
                LD C, #01
                LD A, (HL)
                SUB #80
                LD (HL), A
                JR NC, $+24
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+18
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+12
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A
                JR NC, $+6
                INC L
                LD A, (HL)
                SUB C
                LD (HL), A

                SET_WORLD_FLAG WORLD_UP_BIT

                XOR A
.L1             LD (LocationY), A
                AND #0F
                LD (World.Shift_Y), A
                RET

Down:           SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationY)
                SUB (HL)
                JR NC, .L1

                ; INC 40
                LD HL, GameState.PositionY
                LD A, #80
                ADD A, (HL)
                LD (HL), A
                JR NC, $+16
                INC L
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

                SET_WORLD_FLAG WORLD_DOWN_BIT

                LD A, #EE
.L1             LD (LocationY), A
                AND #0F
                LD (World.Shift_Y), A
                RET

LocationX:      DB #00
LocationY:      DB #00
Delta           DB #22

                endif ; ~_MODULE_GAME_WORLD_MOVE_
