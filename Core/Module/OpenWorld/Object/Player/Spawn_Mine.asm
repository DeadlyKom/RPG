
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_MINE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_MINE_
; -----------------------------------------
; спавн мины
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Spawn_Mine:     ; получение смещение относительно пивата машины
                CALL Packs.OpenWorld.Object.GetBackSocket

                ; спавн мины
                LD BC, (INTERACTION_MINE << 8) | OBJECT_MINE
                JP Packs.OpenWorld.Object.Initialize.Spawn

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_SPAWN_MINE_
