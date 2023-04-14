
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

                ; правки по горизонтали
                LD HL, (Math.PN_LocationX + 0)
                LD DE, (Math.PN_LocationX + 2)
                LD BC, SCR_MINIMAP_SIZE_X >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE
                LD (IX + FObjectDecal.Location.X.Low), HL
                LD (IX + FObjectDecal.Location.X.High), DE

                ; правки по вертикали
                LD HL, (Math.PN_LocationY + 0)
                LD DE, (Math.PN_LocationY + 2)
                LD BC, SCR_MINIMAP_SIZE_Y >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE
                LD (IX + FObjectDecal.Location.Y.Low), HL
                LD (IX + FObjectDecal.Location.Y.High), DE

                RET

                display " - Spawn object 'DECAL' in world : \t\t\t", /A, Decal, " = busy [ ", /D, $ - Decal, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_DECAL_
