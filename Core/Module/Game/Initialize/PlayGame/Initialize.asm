
                ifndef _CORE_MODULE_GAME_INITIALIZE_PLAY_GAME_
                define _CORE_MODULE_GAME_INITIALIZE_PLAY_GAME_
; -----------------------------------------
; инициализация "начло игры"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PlayGame:       ; установка бордюра
                BORDER BLACK

                ; сброса и уход в затемнение
                CALL Func.ResetFadeout

                ; генерация карты и окружения
                SET_PAGE_BLOK_0                                                 ; включение страницы с блоком кода
                CALL Packs.OpenWorld.Generate.World

                JP Execute.Settlement

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
