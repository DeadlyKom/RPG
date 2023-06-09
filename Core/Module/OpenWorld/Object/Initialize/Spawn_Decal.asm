
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_SPAWN_DECAL_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_SPAWN_DECAL_
; -----------------------------------------
; спавн декали в мире
; In:
;   BC - параметры      (B - подтип декали, C - тип объекта)
;   IY - адрес объекта FObjectDecal
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
Decal:          ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD (IY + FObjectDecal.Type), C                                  ; тип объекта
                LD A, B
                AND %11100000
                LD (IY + FObjectParticle.Flags), A                              ; установка флагов
                LD A, B
                AND %00011111
                LD (IY + FObjectParticle.Subtype), A                            ; подтип частицы

                ; правки по горизонтали
                LD HL, (Math.PN_LocationX + 0)
                LD DE, (Math.PN_LocationX + 2)
                LD BC, SCR_MINIMAP_SIZE_X >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE
                LD (IY + FObjectDecal.Location.X.Low), HL
                LD (IY + FObjectDecal.Location.X.High), DE

                ; правки по вертикали
                LD HL, (Math.PN_LocationY + 0)
                LD DE, (Math.PN_LocationY + 2)
                LD BC, SCR_MINIMAP_SIZE_Y >> 1
                OR A
                SBC HL, BC
                JR NC, $+3
                DEC DE
                LD (IY + FObjectDecal.Location.Y.Low), HL
                LD (IY + FObjectDecal.Location.Y.High), DE

                OR A                                                            ; успешный спавн
                RET

                display "\t- Spawn object 'DECAL' in world:\t\t", /A, Decal, " = busy [ ", /D, $ - Decal, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_OBJECT_SPAWN_DECAL_
