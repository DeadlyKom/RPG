
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
Update:         CALL RotationTo
                SUB (IX + FObject.Direction)
                AND %01111000
                JR Z, .IncreaseSpeed

                ; инверсия поворота, если угол 180 град
                LD C, 8
                JP P, .L2
                LD C, -8
                NEG

.L2             CP #08 << 3
                LD A, C
                JR C, .L1
                NEG
.L1             

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | B3 | B2 | B1 | B0 | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [6..3]  - направление
                ;                       0000 - 0.0°     right
                ;                       0001 - 22.5°
                ;                       0010 - 45.0°    up-right
                ;                       0011 - 67.5°
                ;                       0100 - 90.0°    up
                ;                       0101 - 112.5°
                ;                       0110 - 135.0°   up-left
                ;                       0111 - 157.5°
                ;                       1000 - 180.0°   left
                ;                       1001 - 202.5°
                ;                       1010 - 225.0°   down-left
                ;                       1011 - 247.0°
                ;                       1100 - 270.0°   down
                ;                       1101 - 292.5°
                ;                       1110 - 315.0°   down-right
                ;                       1111 - 337.5°
                ; -----------------------------------------
                ADD A, (IX + FObject.Direction)
                LD (IX + FObject.Direction), A

.DecreaseSpeed  LD A, (IX + FObject.EnginePower)
                DEC A
                CP 256-MAX_REVERSE_SPEED
                JR C, .Update
                LD (IX + FObject.EnginePower), A
                JR .Update

.IncreaseSpeed  LD BC, MAX_FORWARD_SPEED << 8 | 3
                LD A, (IX + FObject.EnginePower)
                ADD A, C
                CP B
                JR NC, .Update
                LD (IX + FObject.EnginePower), A

.Update         CALL Game.Object.Player.Deceleration
                LD A, (IX + FObject.Direction)
                CALL Game.Object.Player.Rotation.ApplySpeed

                CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                CALL NZ, Game.Object.Player.Dust
                CALL Movement
                JP Game.Object.Update.Velocity

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_NPC_
