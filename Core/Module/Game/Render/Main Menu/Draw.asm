
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_
                define _MODULE_GAME_RENDER_MAIN_MENU_
; -----------------------------------------
; отображение главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ;
                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_
