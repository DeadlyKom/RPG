
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

                ; затемнение и очистка экрана
                CALL VFX.Diagonal

                ; очистка основного окна
                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                ; очистка теневого окна
                SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03_SCR
                LD BC, ScreenSize
                CALL Memcpy.FastLDIR

                ; генерация карты и окружения
                CALL Generate.World

                JP Execute.Settlement

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
