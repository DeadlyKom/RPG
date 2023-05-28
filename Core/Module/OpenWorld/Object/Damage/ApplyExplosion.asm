
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_APPLY_EXPLOSION_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_APPLY_EXPLOSION_
; -----------------------------------------
; применить урон от взрыва транспортному средству игрока
; In:
;   IX - адрес объекта FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ApplyExplosion: LD A, (IX + FObject.Character.Health)
                SUB 120
                JR Apply

                display "\t- Apply explosion:\t\t\t\t", /A, ApplyExplosion, " = busy [ ", /D, $ - ApplyExplosion, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_APPLY_EXPLOSION_
