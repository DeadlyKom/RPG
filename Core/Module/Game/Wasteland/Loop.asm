
                ifndef _CORE_MODULE_GAME_LOOP_WASTELAND_
                define _CORE_MODULE_GAME_LOOP_WASTELAND_
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
                
                ; цикл завершён
                JR$

                endif ; ~_CORE_MODULE_GAME_LOOP_WASTELAND_
