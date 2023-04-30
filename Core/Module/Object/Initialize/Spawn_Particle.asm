
                ifndef _CORE_MODULE_OBJECT_SPAWN_PARTICLE_
                define _CORE_MODULE_OBJECT_SPAWN_PARTICLE_
; -----------------------------------------
; спавн частицы в мире
; In:
;   DE - смещение частицы   (D - y, E - x)
;   BC - параметры          (B - подтип частицы, C - )
;   IX - адрес объекта копирования позиции FObject
;   IY - адрес объекта FObjectParticle
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
Particle:       ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                
                LD (IY + FObjectParticle.Type), DYNAMIC_OBJECT | OBJECT_PARTICLE | VISIBLE_OBJECT   ; тип объекта
                LD (IY + FObjectParticle.Flags), NOT_DECAL_FLAG                 ; установка флагов
                LD (IY + FObjectParticle.Subtype), B                            ; подтип частицы

                CALL Func.WorldPosition
                LD (IY + FObjectParticle.Position.Y), HL
                LD (IY + FObjectParticle.Position.X), DE

                XOR A

                ; сброс скорости
                LD (IY + FObjectParticle.Velocity.X.Low), A
                LD (IY + FObjectParticle.Velocity.X.High), A
                LD (IY + FObjectParticle.Velocity.Y.Low), A
                LD (IY + FObjectParticle.Velocity.Y.High), A

                ; сброс высоты
                LD (IY + FObjectParticle.Height.Low), A
                LD (IY + FObjectParticle.Height.High), A

                ; определение адреса константных данных частицы
                LD E, (IY + FObjectParticle.Subtype)
                LD A, E
                ADD A, A ; x2
                ADD A, E ; x3
                ADD A, LOW .ParticleConst
                LD L, A
                ADC A, HIGH .ParticleConst
                SUB L
                LD H, A

                ; чтение константных данных
                LD A, (HL)                                                      ; Gravity
                INC HL
                LD C, (HL)                                                      ; AnimFrameNum
                INC HL
                LD B, (HL)                                                      ; AnimDuration

                ; установка константных данных
                LD (IY + FObjectParticle.Gravity), A
                LD (IY + FObjectParticle.AnimDuration), B

                ; установка анимации
                LD (IY + FObjectParticle.AnimFrame), C
                LD (IY + FObjectParticle.AnimCounter), B

                OR A                                                            ; успешный спавн
                RET

.ParticleConst  ; PARTICLE_DUST                                                 ; 0x00
                FParticleConst { #FE, (#07 - 1) << 3,  #05 }
                ; PARTICLE_SMOKE                                                ; 0x01
                FParticleConst { #F7, (#07 - 1) << 3,  #05 }
                ; PARTICLE_EXPLOSION                                            ; 0x02
                FParticleConst { #F1, (#04 - 1) << 3,  #03 }

                display " - Spawn object 'PARTICLE' in world :\t\t\t", /A, Decal, " = busy [ ", /D, $ - Decal, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_PARTICLE_
