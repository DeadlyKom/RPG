
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_MINE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_MINE_
; -----------------------------------------
; обновление позиции мины
; In:
;   IX - адрес обрабатываемого объекта FObjectInteraction
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Mine:           ; уменьшить счётчик продолжительности фрейма
                DEC (IX + FObjectInteraction.Lifetime)
                JP NZ, UpdateOffset                                             ; переход, если время жизни объекта не вышло

                ; уничтожение объекта
                CALL Packs.OpenWorld.Object.Utils.Remove

                JP Packs.OpenWorld.Object.Player.Spawn_Explosion

                display " - Update object 'MINE':\t\t\t\t", /A, Mine, " = busy [ ", /D, $ - Mine, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_MINE_
