
                ifndef _MODULE_GAME_INITIALIZE_WORLD_
                define _MODULE_GAME_INITIALIZE_WORLD_
; -----------------------------------------
; инициализация объектов в пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; -----------------------------------------
                ; инициализация объектов
                ; -----------------------------------------
                CALL Packs.OpenWorld.Object.Initialize.Base                     ; инициализация работы с объектами

                ; ToDo тестовый спавн игрока
                LD DE, #8060
                LD BC, OBJECT_PLAYER
                CALL Packs.OpenWorld.Object.Initialize.Spawn

                ; ToDo тестовый спавн противника
                LD DE, #9020
                LD BC, ENEMY_FACTION_A | OBJECT_NPC
                CALL Packs.OpenWorld.Object.Initialize.Spawn
                
                ; ; ToDo тестовый спавн противника
                ; LD DE, #5020
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Packs.OpenWorld.Object.Initialize.Spawn

                ; ; ToDo тестовый спавн противника
                ; LD DE, #50B0
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Packs.OpenWorld.Object.Initialize.Spawn

                ; ; ToDo спавн частицы
                ; LD DE, #5080
                ; LD BC, PARTICLE_DUST << 8 | OBJECT_PARTICLE
                ; CALL Packs.OpenWorld.Object.Initialize.Spawn
                
                ; ; ToDo спавн декали
                ; LD BC, (FLAG_COLLISION_OBJECT << 8) | OBJECT_COLLISION
                ; LD HL, #000C
                ; LD (Math.PN_LocationX + 0), HL
                ; LD HL, #0016
                ; LD (Math.PN_LocationY + 0), HL
                ; LD HL, #1000
                ; LD (Math.PN_LocationX + 2), HL
                ; LD (Math.PN_LocationY + 2), HL
                ; CALL Packs.OpenWorld.Object.Initialize.Spawn
                
                RET

                endif ; ~_MODULE_GAME_INITIALIZE_WORLD_
