
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
                CALL Rotation
                CALL Game.World.Camera
                CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                CALL NZ, Dust
                JP Object.ApplyVelocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
