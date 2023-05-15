
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PLAYER_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PLAYER_
; -----------------------------------------
; обновление игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Update:         ; применние сил
                CALL Deceleration
                CALL Rotation
                CALL Packs.OpenWorld.Wasteland.Camera
                CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                CALL NZ, Spawn_Dust
                JP Packs.OpenWorld.Object.Update.Velocity

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PLAYER_
