
                ifndef _MODULE_GAME_WORLD_MOVE_
                define _MODULE_GAME_WORLD_MOVE_

Left:           ; DEC 40
                LD HL, PlayerState.CameraPosX
                LD B, #01
                LD A, (HL)
                SUB #10
                LD (HL), A
                LD C, A
                JR NC, .L1
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_ 
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_ 
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_ 
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
.L1_            SET_WORLD_FLAG WORLD_LEFT_BIT

.L1             LD A, C
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_X), A

                ; SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                ; rept 32
                ; LD HL, #C000 + FObject.Position.X
                ; LD A, (HL)
                ; SUB #01
                ; LD (HL), A
                ; JR NC, $+7
                ; INC HL
                ; LD A, (HL)
                ; SUB #01
                ; LD (HL), A
                ; endr
                ; SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET

Right:          
                ; INC 40
                LD HL, PlayerState.CameraPosX
                LD A, #10
                ADD A, (HL)
                LD (HL), A
                JR NC, .L1
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
.L1_            SET_WORLD_FLAG WORLD_RIGHT_BIT

.L1             RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_X), A

                ; SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                ; rept 32
                ; LD HL, #C000 + FObject.Position.X
                ; INC (HL)
                ; JR NZ, $+4
                ; INC HL
                ; INC (HL)
                ; endr
                ; SET_SCREEN_SHADOW                                               ; включение страницы второго экрана
                RET

Down:           ; DEC 40
                LD HL, PlayerState.CameraPosY
                LD B, #01
                LD A, (HL)
                SUB #10
                LD (HL), A
                LD C, A
                JR NC, .L1
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, .L1_
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
.L1_            SET_WORLD_FLAG WORLD_DOWN_BIT

.L1             LD A, C
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_Y), A

                ; SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                ; rept 32
                ; LD HL, #C000 + FObject.Position.Y
                ; LD A, (HL)
                ; SUB #01
                ; LD (HL), A
                ; JR NC, $+7
                ; INC HL
                ; LD A, (HL)
                ; SUB #01
                ; LD (HL), A
                ; endr
                ; SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET

Up:             ; INC 40
                LD HL, PlayerState.CameraPosY
                LD A, #10
                ADD A, (HL)
                LD (HL), A
                JR NC, .L1
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
                JR NZ, .L1_
                INC L
                INC (HL)
.L1_            SET_WORLD_FLAG WORLD_UP_BIT

.L1             RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_Y), A

                ; SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                ; rept 32
                ; LD HL, #C000 + FObject.Position.Y
                ; INC (HL)
                ; JR NZ, $+4
                ; INC HL
                ; INC (HL)
                ; endr
                ; SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET

                endif ; ~_MODULE_GAME_WORLD_MOVE_
