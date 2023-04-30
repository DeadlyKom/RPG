
                ifndef _MODULE_GAME_OBJECT_UPDATE_MINE_
                define _MODULE_GAME_OBJECT_UPDATE_MINE_
; -----------------------------------------
; обновление позиции мины
; In:
;   IX - адрес обрабатываемого объекта FObjectInteraction
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Mine:           ; уменьшить счётчик продолжительности фрейма
                LD A, (IX + FObjectInteraction.Lifetime)
                INC A
                JP Z, UpdateOffset                                              ; переход, если объект не уничтожается

                DEC (IX + FObjectInteraction.Lifetime)
                JP NZ, UpdateOffset                                             ; переход, если время жизни объекта не вышло
                
                ; уничтожение объекта
                JP Object.Remove

                display " - Update object 'MINE':\t\t\t\t", /A, Mine, " = busy [ ", /D, $ - Mine, " bytes  ]"

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_MINE_
