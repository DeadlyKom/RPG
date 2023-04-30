
                ifndef _MODULE_GAME_OBJECT_UPDATE_PARTICLE_
                define _MODULE_GAME_OBJECT_UPDATE_PARTICLE_
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
                JP M, Object.Remove
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
                JP Object.ApplyVelocity

                display " - Update object 'PARTICLE':\t\t\t\t", /A, Particle, " = busy [ ", /D, $ - Particle, " bytes  ]"

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PARTICLE_
