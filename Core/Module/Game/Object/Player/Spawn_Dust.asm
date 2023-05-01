
                ifndef _MODULE_GAME_OBJECT_PLAYER_SPAWN_DUST_
                define _MODULE_GAME_OBJECT_PLAYER_SPAWN_DUST_
; -----------------------------------------
; спавн пыли от колёс
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Spawn_Dust:     LD A, (IX + FObject.EnginePower)
                CP #04
                RET C

                LD A, (IX + FObject.VFX)
                DEC A
                JR NZ, .Set

                ; получение смещение относительно пивата машины
                CALL Kernel.Object.GetBackSocket

                ; спавн частиц пыли от колёс
                LD BC, (PARTICLE_DUST << 8) | OBJECT_PARTICLE
                CALL Func.SpawnObject
                ;   IY - адрес объекта FObjectDecal
                JR C, .RET                                                      ; выход, т.к. нет места

                LD HL, (IY + FObject.Velocity.X)

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                LD L, H

                rept 3
                SRA H
                RR L
                endr

                LD (IY + FObjectParticle.Velocity.X), HL
                LD HL, (IY + FObject.Velocity.Y)

                rept 3
                SRA H
                RR L
                endr

                LD (IY + FObjectParticle.Velocity.Y), HL
.RET            LD A, #04
.Set            LD (IX + FObject.VFX), A

                RET

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_SPAWN_DUST_
