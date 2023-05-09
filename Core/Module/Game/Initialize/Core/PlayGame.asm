
                ifndef _MODULE_GAME_INITIALIZE_PLAY_GAME_
                define _MODULE_GAME_INITIALIZE_PLAY_GAME_
; -----------------------------------------
; инициализация игры (первый запуск)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PlayGame:       ; ToDo
                ; генерация карты и окружения

                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                JP Execute.Settlement

                endif ; ~_MODULE_GAME_INITIALIZE_PLAY_GAME_
