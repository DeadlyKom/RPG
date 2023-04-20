
                ifndef _MODULE_GAME_OBJECT_UPDATE_NPC_
                define _MODULE_GAME_OBJECT_UPDATE_NPC_
; -----------------------------------------
; обновление игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Update:         ; CALL Deceleration
                CALL RotationTo
                ; CALL Game.World.Camera
                ; CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                ; CALL NZ, Dust
                CALL Movement
                JP Game.Object.Update.Velocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_NPC_
