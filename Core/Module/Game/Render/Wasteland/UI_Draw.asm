
                ifndef _MODULE_GAME_RENDER_WASTELAND_UI_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_UI_DRAW_
; -----------------------------------------
; отображение UI пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UI_Draw:        SHOW_BASE_SCREEN                                                ; отобразить основной экран
                HALT                                                            ; ожидание луча

                ; -----------------------------------------
                ; подготовка теневого экрана
                ; -----------------------------------------
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                CLS_C000
                ATTR_C000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_03_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                JP UI.Initialize

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_UI_DRAW_
