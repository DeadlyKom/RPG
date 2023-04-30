
                ifndef _MODULE_GAME_OBJECT_PLAYER_SPAWN_EXPLOSION_
                define _MODULE_GAME_OBJECT_PLAYER_SPAWN_EXPLOSION_
; -----------------------------------------
; спавн взрыва
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Spawn_Explosion ; получение смещение относительно пивата машины
                CALL Kernel.Object.GetBackSoket

                ; спавн мины
                LD BC, (PARTICLE_EXPLOSION << 8) | OBJECT_PARTICLE
                JP Func.SpawnObject

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_SPAWN_EXPLOSION_
