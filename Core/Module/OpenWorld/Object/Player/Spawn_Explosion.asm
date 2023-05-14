
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_EXPLOSION_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_EXPLOSION_
; -----------------------------------------
; спавн взрыва
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Spawn_Explosion ; спавн мины
                LD DE, #0000
                LD BC, (PARTICLE_EXPLOSION << 8) | OBJECT_PARTICLE
                JP Packs.OpenWorld.Object.Initialize.Spawn

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_EXPLOSION_
