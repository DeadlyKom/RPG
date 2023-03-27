
                ifndef _MODULE_GAME_WORLD_MOVE_
                define _MODULE_GAME_WORLD_MOVE_

Left:           SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationX)
                SUB (HL)
                JR NC, .L1

                ; LD HL, (Game.World.Generate.X)
                ; INC HL
                ; LD (Game.World.Generate.X), HL

                RES_RENDER_FLAG GEN_BIT

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

                ; INC 32
                LD HL, GameState.PositionX
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

                RES_RENDER_FLAG GEN_BIT

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

                ; LD HL, (Game.World.Generate.Y)
                ; DEC HL
                ; LD (Game.World.Generate.Y), HL

                RES_RENDER_FLAG GEN_BIT
                

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

                ; LD HL, (Game.World.Generate.Y)
                ; INC HL
                ; LD (Game.World.Generate.Y), HL

                RES_RENDER_FLAG GEN_BIT

                LD A, #EE
.L1             LD (LocationY), A
                AND #0F
                LD (World.Shift_Y), A
                RET

LocationX:      DB #00
LocationY:      DB #00
Delta           DB #22

                endif ; ~_MODULE_GAME_WORLD_MOVE_
