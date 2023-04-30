
                ifndef _MODULE_GAME_OBJECT_PLAYER_SPAWN_MINE_
                define _MODULE_GAME_OBJECT_PLAYER_SPAWN_MINE_
; -----------------------------------------
; спавн мины
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Spawn_Mine:     ; получение смещение относительно пивата машины
                CALL Kernel.Object.GetBackSoket

                ; спавн мины
                LD BC, (INTERACTION_MINE << 8) | OBJECT_MINE
                JP Func.SpawnObject

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_SPAWN_MINE_
