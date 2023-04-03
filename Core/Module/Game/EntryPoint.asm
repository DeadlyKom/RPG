
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
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_03_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                ; -----------------------------------------
                ; инициализация таблиц
                ; -----------------------------------------
                CALL Generation.ScrAdr                                          ; генерация адресов экрана
                CALL Generation.PRNG_Gen                                        ; генерация PRNG карты мира
                CALL Generation.WorldSprite                                     ; генерация спрайтов для карты мира

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
                SetUserHendler Game.Interrupt

                CALL World.Generate

                ; JP GameLoop                                                   ; идёт следом

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
