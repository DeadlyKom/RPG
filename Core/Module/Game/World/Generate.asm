
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
                ; центровка карты мира
                ; -----------------------------------------
                LD B, #01

                ; DEC 32
                LD HL, PlayerState.CameraPosX + 1
                LD A, (HL)
                SUB SCR_MINIMAP_SIZE_X
                LD (HL), A
                JR NC, $+18
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, $+12
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, $+6
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A

                ; LD HL, (PlayerState.CameraPosX + 3)
                ; PUSH HL
                ; LD HL, (PlayerState.CameraPosX + 1)
                ; PUSH HL

                ; ; DEC 40
                ; LD HL, PlayerState.CameraPosY + 1
                ; LD A, (HL)
                ; SUB SCR_MINIMAP_SIZE_Y >> 1
                ; LD (HL), A
                ; JR NC, $+18
                ; INC L
                ; LD A, (HL)
                ; SUB B
                ; LD (HL), A
                ; JR NC, $+12
                ; INC L
                ; LD A, (HL)
                ; SUB B
                ; LD (HL), A
                ; JR NC, $+6
                ; INC L
                ; LD A, (HL)
                ; SUB B
                ; LD (HL), A

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

                ; POP HL
                ; LD (PlayerState.CameraPosX + 1), HL
                ; POP HL
                ; LD (PlayerState.CameraPosX + 3), HL

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
                JR NC, .Ground

                ; спавн на песке
                LD A, L
                CP #D0              ; кактусы
                JR NZ, .IsDecal

.IsCactus       LD A, R
                AND #03
                SUB #01
                ADC A, #00
                LD B, A
                JR .Collision

.IsDecal        SUB #A8
                LD B, #04           ; череп 1
                JR Z, .Decal
                SUB #02
                LD B, #0C           ; череп 2
                JR Z, .Decal
                SUB #02
                LD B, #03           ; куст
                JR Z, .Decal
                SUB #02
                LD B, #09           ; бревно 2
                JR Z, .Collision
                SUB #02
                LD B, #0D           ; канава 1
                JR NZ, .Skip

.Decal          LD C, OBJECT_DECAL
                JR .Spawn

.Ground         ; спавн на грунте
                LD A, L
                SUB #20
                ; JR C, .Skip
                ; LD B, #05           ; бревно 1
                ; JR Z, .Collision
                SUB #02
                LD B, #0A           ; бревно 3
                JR Z, .Collision
                SUB #04
                LD B, #06           ; камень 1
                JR Z, .Collision
                ; SUB #05
                ; LD B, #07           ; камень 2
                ; JR Z, .Collision
                ; SUB #06
                ; LD B, #08           ; камень 3
                ; JR Z, .Collision
                SUB #07
                LD B, #0E           ; камень 4
                JR Z, .Collision
                SUB #08
                LD B, #0B           ; канава 2
                JR NZ, .Skip

.Collision      LD C, OBJECT_COLLISION
                ; JR .Spawn

.Spawn          PUSH HL
                EXX
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
                POP HL

.Skip           LD A, H
                OR L
                EXX
                CPL
                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_
