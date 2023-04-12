
                ifndef _MODULE_GAME_WORLD_GENERATE_
                define _MODULE_GAME_WORLD_GENERATE_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       LD HL, (PlayerState.CameraPosX + 3)
                PUSH HL
                LD HL, (PlayerState.CameraPosX + 1)
                PUSH HL

                ; -----------------------------------------
                ; генерация спрайта мини карты
                ; -----------------------------------------
                LD A, SCR_MINIMAP_SIZE_X

.Loop           PUSH AF
                CALL MoveRight

                ; INC 32
                LD HL, PlayerState.CameraPosX + 1
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

                POP AF
                DEC A
                JR NZ, .Loop

                POP HL
                LD (PlayerState.CameraPosX + 1), HL
                POP HL
                LD (PlayerState.CameraPosX + 3), HL

                RET

.Noise          EXX
                
                ; LD A, #10
                ; LD (Math.PN_Frequency), A
                CALL Math.PerlinNoise2D
                ; PUSH HL
                ; LD A, #30
                ; LD (Math.PN_Frequency), A
                ; CALL Math.PerlinNoise2D
                ; POP DE
                ; LD A, D
                ; AND H
                ; PUSH AF
                ; LD A, #A0
                ; LD (Math.PN_Frequency), A
                ; CALL Math.PerlinNoise2D
                ; POP AF
                ; AND H

                ; LD A, L
                ; CP #10
                ; JR C, $+8
                ; AND %10100101
                ; RRCA
                ; XOR %10100101
                ; RLCA
                ; XOR %00101000

                ; BIT 6, L
                ; LD A, #FF
                ; JR Z, $+3
                ; INC A

                ; LD A, L
                ; ADD A, #70
                ; CP #60
                ; LD A, #FF
                ; JR NC, $+3
                ; INC A

                ; LD A, L
                ; ADD A, #90
                ; CP #40
                ; LD A, L
                ; ADD A, A
                ; JR C, $+3
                ; LD A, #00

                ; LD A, H

                ; ADD A, A
                ; JR C, .L1
                ; LD A, L
                ; CP #1F
                ; JR C, .L1
                ; LD BC, OBJECT_DECAL
                ; CALL Func.SpawnObject

                ; фильтр
                LD A, H
                OR L
                ADD A, A
                JR C, .Ground

                ; спавн на песке
                LD A, L
                CP #1E              ; кактусы
                JR NZ, .IsSkull

.IsCactus       LD A, R
                AND #03
                CP #03
                JR C, $+4
                LD A, #02
                LD B, A
                LD C, OBJECT_COLLISION
                JR .Spawn

.IsSkull        CP #55              ; череп
                JR NZ, .Skip
                LD B, #0C
                LD C, OBJECT_DECAL
                JR .Spawn

.Ground         ; спавн на грунте
                LD A, L
                CP #20              ; камень
                JR NZ, .Skip
                LD B, #0E
                LD C, OBJECT_COLLISION
                ; JR .Spawn

.Spawn          EXX
                PUSH HL
                PUSH DE
                PUSH BC
                EXX

                CALL Func.SpawnObject

                EXX
                POP BC
                POP DE
                POP HL
                EXX

.Skip           LD A, H
                OR L
                EXX
                CPL
                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_
