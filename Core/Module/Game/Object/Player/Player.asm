
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
Update:         CALL Deceleration
                CALL Input

                CALL Rotation
                CALL Game.World.Camera

                CHECK_PLAYER_FLAG INCREASE_SPEED_BIT
                CALL NZ, Dust

                JP Game.Object.Update.Velocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
