
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PARTICLE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PARTICLE_
; -----------------------------------------
; обновление частицы
; In:
;   IX - адрес обрабатываемого объекта FObjectParticle
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Particle:       ; уменьшить счётчик продолжительности фрейма
                DEC (IX + FObjectParticle.AnimCounter)
                JR NZ, .Move

                ; обновить счётчик продолжительности фрейма
                LD A, (IX + FObjectParticle.AnimDuration)
                LD (IX + FObjectParticle.AnimCounter), A

                ; следующий фрейм
                LD A, (IX + FObjectParticle.AnimFrame)
                SUB #08
                JP M, Packs.OpenWorld.Object.Utils.Remove
                LD (IX + FObjectParticle.AnimFrame), A

.Move           ; -----------------------------------------
                ; расчёт смещения относительно камеры
                ; -----------------------------------------

                ; расчёт смещения частицы по высоте
                LD HL, (IX + FObjectParticle.Height)
                LD A, (IX + FObjectParticle.Gravity)
                LD E, A
                ADD A, A
                SBC A, A
                LD D, A
                ADD HL, DE
                LD (IX + FObjectParticle.Height), HL

                CALL UpdateOffset
                JP Packs.OpenWorld.Object.Update.Velocity

                display "\t- Update object 'PARTICLE':\t\t\t", /A, Particle, " = busy [ ", /D, $ - Particle, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PARTICLE_
