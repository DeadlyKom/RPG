
                ifndef _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
                define _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
; -----------------------------------------
; инициализация поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Settlement:     ; установка бордюра
                BORDER BLACK

                ; инициализация главного цикла
                SetMainLoop Packs.Settlement.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.Settlement.Interrupt

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
