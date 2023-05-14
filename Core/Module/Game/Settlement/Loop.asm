
                ifndef _CORE_MODULE_GAME_LOOP_SETTLEMENT_
                define _CORE_MODULE_GAME_LOOP_SETTLEMENT_
; -----------------------------------------
; игровой цикл поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Loop:           
.Render         ; ************ RENDER ************
                CHECK_RENDER_FLAG FINISHED_BIT
                RET NZ

                ; проверка завершение цикла главного меню
                CHECK_MENU_FLAG MENU_LOOP_BIT
                JP Z, Render.Draw

                ; сброс флага завершение цикла
                RES_MENU_FLAG MENU_LOOP_BIT
                
                ; цикл завершён, запуск пустоши
                JP Execute.Wasteland

                endif ; ~_CORE_MODULE_GAME_LOOP_SETTLEMENT_
