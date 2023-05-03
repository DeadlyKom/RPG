
                ifndef _CORE_MODULE_OBJECT_SPAWN_MINE_
                define _CORE_MODULE_OBJECT_SPAWN_MINE_
; -----------------------------------------
; спавн декали "мины" в мире
; In:
;   DE - смещение частицы   (D - y, E - x)
;   BC - параметры          (B - подтип декали, C - тип объекта)
;   IX - адрес объекта копирования позиции FObject
;   IY - адрес объекта FObjectInteraction
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
Mine:           ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                SET VISIBLE_OBJECT_BIT, C
                LD (IY + FObjectInteraction.Type), C                                    ; тип объекта
                LD (IY + FObjectInteraction.Flags), FLAG_DECAL | FLAG_COLLISION_OBJECT  ; установка флагов
                LD (IY + FObjectInteraction.Subtype), B                                 ; подтип декали
                LD (IY + FObjectInteraction.Lifetime), LIFETIME_MINE                    ; время жизни объекта

                CALL Func.WorldPosition
                LD (IY + FObjectInteraction.Position.Y), HL
                LD (IY + FObjectInteraction.Position.X), DE

                OR A                                                            ; успешный спавн
                RET

                display " - Spawn object 'MINE' in world:\t\t\t", /A, Mine, " = busy [ ", /D, $ - Mine, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_MINE_
