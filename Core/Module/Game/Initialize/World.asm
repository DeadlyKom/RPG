
                ifndef _MODULE_GAME_INITIALIZE_WORLD_
                define _MODULE_GAME_INITIALIZE_WORLD_
; -----------------------------------------
; инициализация мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          ; -----------------------------------------
                ; инициализация объектов
                ; -----------------------------------------
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                CALL Func.InitObject                                            ; инициализация работы с объектами

                ; ToDo тестовый спавн игрока
                LD DE, #8060
                LD BC, OBJECT_PLAYER
                CALL Func.SpawnObject

                ; ; ToDo тестовый спавн противника
                ; LD DE, #9020
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Func.SpawnObject
                
                ; ; ToDo тестовый спавн противника
                ; LD DE, #5020
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Func.SpawnObject

                ; ; ToDo тестовый спавн противника
                ; LD DE, #50B0
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Func.SpawnObject

                ; ; ToDo спавн частицы
                ; LD DE, #5080
                ; LD BC, PARTICLE_DUST << 8 | OBJECT_PARTICLE
                ; CALL Func.SpawnObject
                
                ; ; ToDo спавн декали
                ; LD BC, OBJECT_COLLISION
                ; LD HL, #000C
                ; LD (Math.PN_LocationX + 0), HL
                ; LD HL, #0016
                ; LD (Math.PN_LocationY + 0), HL
                ; LD HL, #1000
                ; LD (Math.PN_LocationX + 2), HL
                ; LD (Math.PN_LocationY + 2), HL
                ; CALL Func.SpawnObject
                
                RET

                endif ; ~_MODULE_GAME_INITIALIZE_WORLD_
