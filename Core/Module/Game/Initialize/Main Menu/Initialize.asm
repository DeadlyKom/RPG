
                ifndef _CORE_MODULE_GAME_MAIN_MENU_INITIALIZE_
                define _CORE_MODULE_GAME_MAIN_MENU_INITIALIZE_
; -----------------------------------------
; инициализация главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; установка бордюра
                BORDER BLACK

                ; инициализация главного цикла
                SetMainLoop Packs.MainMenu.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.MainMenu.Interrupt

                RET

                endif ; ~_CORE_MODULE_GAME_MAIN_MENU_INITIALIZE_
