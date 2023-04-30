
                ifndef _CORE_MODULE_OBJECT_SPAWN_MINE_
                define _CORE_MODULE_OBJECT_SPAWN_MINE_
; -----------------------------------------
; спавн декали "мины" в мире
; In:
;   BC - параметры      (B - подтип декали, C - тип объекта)
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
                LD (IY + FObjectInteraction.Type), C                            ; тип объекта
                LD (IY + FObjectInteraction.Flags), DECAL_FLAG                  ; установка флагов
                LD (IY + FObjectInteraction.Subtype), B                         ; подтип декали
                LD (IY + FObjectInteraction.Lifetime), #40                      ; время жизни объекта

                CALL CalcPosition

                OR A                                                            ; успешный спавн
                RET

                display " - Spawn object 'MINE' in world:\t\t\t", /A, Mine, " = busy [ ", /D, $ - Mine, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_MINE_
