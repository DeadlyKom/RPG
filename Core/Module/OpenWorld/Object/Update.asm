
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_
; -----------------------------------------
; обновление объектов
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Update:         ; переход в зависимости от типа объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; OBJECT_PLAYER
                JP Player.Update
                DB #00                                                          ; dummy
                ; OBJECT_NPC
                JP NPC.Update
                DB #00                                                          ; dummy
                ; OBJECT_DECAL
                JP Decal
                DB #00                                                          ; dummy
                ; OBJECT_COLLISION
                JP Decal
                DB #00                                                          ; dummy
                ; OBJECT_PARTICLE
                JP Particle
                DB #00                                                          ; dummy
                ; OBJECT_MINE
                JP Mine
                DB #00                                                          ; dummy
                ; 6
                JP .RET
                DB #00                                                          ; dummy
                ; 7
                JP .RET

.Velocity       ; ----------------------------------------
                ; общая логика поведения для всех объектов
                ; ----------------------------------------

                ; расчитать новую позицию объекта, учитывая его скорость
                LD HL, (IX + FObject.Velocity.X)

                rept 4
                SRA H
                RR L
                endr

                LD DE, (IX + FObject.Position.X)
                ADD HL, DE
                LD (IX + FObject.Position.X), HL

                LD HL, (IX + FObject.Velocity.Y)

                rept 4
                SRA H
                RR L
                endr
                
                LD DE, (IX + FObject.Position.Y)
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL
 
.RET            RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_
