
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_NOISE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_NOISE_
; -----------------------------------------
; генерация пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
WastelandNoise: ; фильтр
                LD A, H
                OR L
                ADD A, A
                JR NC, .Ground

                ; спавн на песке
                LD A, L
                CP #D0                  ; кактусы
                JR NZ, .IsDecal

.IsCactus       LD A, R
                AND #03
                SUB #01
                ADC A, #00
                OR FLAG_COLLISION_OBJECT
                LD B, A
                JR .Collision

.IsDecal        SUB #A8
                LD B, OBJECT_SCULL_A    ; череп 1
                JR Z, .Decal
                SUB #02
                LD B, OBJECT_SCULL_B    ; череп 2
                JR Z, .Decal
                SUB #02
                LD B, OBJECT_GRASS      ; трава
                JR Z, .Decal
                SUB #02
                LD B, OBJECT_LOG_B      ; бревно 2
                JR Z, .Collision
                SUB #02
                LD B, OBJECT_DITCH_B    ; канава 2
                JR NZ, .Skip

.Decal          LD C, OBJECT_DECAL
                JR .Spawn

.Ground         ; спавн на грунте
                LD A, L
                SUB #30
                ; JR C, .Skip
                ; LD B, OBJECT_LOG_A      ; бревно 1
                ; JR Z, .Collision
                SUB #02
                LD B, OBJECT_LOG_C      ; бревно 3
                JR Z, .Collision
                SUB #04
                LD B, OBJECT_STONE_A    ; камень 1
                JR Z, .Collision
                ; SUB #05
                ; LD B, OBJECT_STONE_B    ; камень 2
                ; JR Z, .Collision
                ; SUB #06
                ; LD B, OBJECT_STONE_C    ; камень 3
                ; JR Z, .Collision
                SUB #07
                LD B, OBJECT_DITCH_A    ; канава 1
                JR NZ, .Skip

.Collision      LD C, OBJECT_COLLISION
                ; JR .Spawn

.Spawn          PUSH HL
                EXX
                PUSH HL
                PUSH DE
                PUSH BC
                EXX

                CALL Packs.OpenWorld.Object.Initialize.Spawn

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

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_NOISE_
