
                ifndef _MODULE_GAME_WORLD_GENERATE_
                define _MODULE_GAME_WORLD_GENERATE_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; -----------------------------------------
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
    
                RET

.Noise          EXX
                CALL Math.PerlinNoise2D

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
