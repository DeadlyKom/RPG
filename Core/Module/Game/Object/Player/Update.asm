
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
Update:         ; кеширование очков здоровья игрока
                LD A, (PlayerState.Health + 2)
                OR A
                JR NZ, .Skip
                LD A, (PlayerState.Health + 0)
                SUB (IX + FObject.Character.Health)
                NEG
                LD (PlayerState.Health + 2), A
.Skip
                ; применние сил
                CALL Deceleration
                CALL Rotation
                CALL Game.World.Camera
                CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                CALL NZ, Spawn_Dust
                JP Object.ApplyVelocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
