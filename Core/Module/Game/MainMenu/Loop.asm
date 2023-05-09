
                ifndef _CORE_MODULE_GAME_LOOP_MAIN_MENU_
                define _CORE_MODULE_GAME_LOOP_MAIN_MENU_
; -----------------------------------------
; цикл главного меню
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
                
                ; цикл завершён, запуск игры
                JP Execute.PlayGame

                endif ; ~_CORE_MODULE_GAME_LOOP_MAIN_MENU_
