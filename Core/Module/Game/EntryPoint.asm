
                ifndef _CORE_MODULE_GAME_ENTRY_POINT_
                define _CORE_MODULE_GAME_ENTRY_POINT_
; -----------------------------------------
; точка входа запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EntryPoint:     ; -----------------------------------------
                ; установка бордюра
                ; -----------------------------------------
                BORDER BLACK
                
                ; -----------------------------------------
                ; подготовка теневого экрана
                ; -----------------------------------------
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                CLS_C000
                ATTR_C000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_03_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                ; -----------------------------------------
                ; инициализация таблиц
                ; -----------------------------------------
                CALL Generation.ScrAdr                                          ; генерация адресов экрана
                CALL Generation.PRNG                                            ; генерация PRNG карты мира
                CALL Generation.ShiftTable                                      ; генерация таблицы сдвигов
                CALL Generation.MulSprTable                                     ; генерация таблицы умножения для спрайтов
                CALL Generation.WorldSprite                                     ; генерация спрайтов для карты мира

                ; -----------------------------------------
                ; инициализация объектов
                ; -----------------------------------------
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                CALL Func.InitObject                                            ; инициализация работы с объектами

                ; ToDo тестовый спавн игрока
                LD DE, #8060
                LD BC, PLAYER_FACTION | OBJECT_PLAYER
                CALL Func.SpawnObject

                ; ; ToDo тестовый спавн противника
                ; LD DE, #9020
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Func.SpawnObject
                
                ; ToDo тестовый спавн противника
                LD DE, #5020
                LD BC, ENEMY_FACTION_A | OBJECT_NPC
                CALL Func.SpawnObject

                ; ; ToDo тестовый спавн противника
                ; LD DE, #50B0
                ; LD BC, ENEMY_FACTION_A | OBJECT_NPC
                ; CALL Func.SpawnObject

                ; ; ToDo спавн частицы
                ; LD DE, #5080
                ; LD BC, PARTICLE_DUST << 8 | OBJECT_PARTICLE
                ; CALL Func.SpawnObject
                
                ; ToDo спавн декали
                ; LD BC, OBJECT_COLLISION
                ; LD HL, #0010
                ; LD (Math.PN_LocationX + 0), HL
                ; LD HL, #0010
                ; LD (Math.PN_LocationY + 0), HL
                ; LD HL, #1000
                ; LD (Math.PN_LocationX + 2), HL
                ; LD (Math.PN_LocationY + 2), HL
                ; CALL Func.SpawnObject

                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана
                ; -----------------------------------------
                ; подготовка основного экрана
                ; -----------------------------------------
                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_01_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_01_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_01_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                ; -----------------------------------------
                ; инициализация обработчика прерываний
                ; -----------------------------------------
                SetUserHendler Game.World.Interrupt

                CALL World.Generate

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
