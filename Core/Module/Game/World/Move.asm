
                ifndef _MODULE_GAME_WORLD_MOVE_
                define _MODULE_GAME_WORLD_MOVE_

Left:           SET_RENDER_FLAG INERT_BIT

                LD HL, Delta
                LD A, (LocationX)
                SUB (HL)
                JR NC, .L1

                LD HL, (Game.World.Generate.X)
                INC HL
                LD (Game.World.Generate.X), HL

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

                LD HL, (Game.World.Generate.X)
                DEC HL
                LD (Game.World.Generate.X), HL

                RES_RENDER_FLAG GEN_BIT
                

                XOR A
.L1             LD (LocationX), A
                AND #0F
                LD (World.Shift_X), A
                RET

LocationX:      DB #00
Delta           DB #22

                endif ; ~_MODULE_GAME_WORLD_MOVE_
