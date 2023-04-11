
                ifndef _CORE_MODULE_OBJECT_SPAWN_DECAL_
                define _CORE_MODULE_OBJECT_SPAWN_DECAL_
; -----------------------------------------
; спавн объекта в мире
; In:
;   BC - параметры      (B - подтип декали, C - тип объекта)
;   IX - адрес объекта
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IX
; Note:
; -----------------------------------------
Decal:          ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                
                LD (IX + FObjectDecal.Type), C                                  ; тип объекта
                LD (IX + FObjectDecal.Subtype), B                               ; подтип декали

                LD HL, (Math.PN_LocationX + 0)
                LD (IX + FObjectDecal.Location.X.Low), HL
                LD HL, (Math.PN_LocationX + 2)
                LD (IX + FObjectDecal.Location.X.High), HL

                LD HL, (Math.PN_LocationY + 0)
                LD (IX + FObjectDecal.Location.Y.Low), HL
                LD HL, (Math.PN_LocationY + 2)
                LD (IX + FObjectDecal.Location.Y.High), HL

                RET

                display " - Spawn object 'DECAL' in world : \t\t\t", /A, Decal, " = busy [ ", /D, $ - Decal, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_DECAL_
