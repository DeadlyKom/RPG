
                ifndef _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
                define _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
; -----------------------------------------
; инициализация главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MainMenu:       ; установка бордюра
                BORDER BLACK

                ; инициализация главного цикла
                SetGameLoop Packs.MainMenu.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.MainMenu.Interrupt

                ; инициализация стартового ID меню
                LD A, MENU_ID_MAIN
                LD (GameState.MenuID), A

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
