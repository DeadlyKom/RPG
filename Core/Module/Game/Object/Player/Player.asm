
                ifndef _MODULE_GAME_OBJECT_UPDATE_PLAYER_
                define _MODULE_GAME_OBJECT_UPDATE_PLAYER_
; -----------------------------------------
; обновление игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Update:         CALL Rotation
                CALL Deceleration
                CALL Game.World.Camera
                JP Game.Object.Update.Velocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
