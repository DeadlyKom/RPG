
                ifndef _CORE_MODULE_GAME_LOOP_MAIN_MENU_
                define _CORE_MODULE_GAME_LOOP_MAIN_MENU_
; -----------------------------------------
; игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Loop:       
.Render         ; ************ RENDER ************
                CHECK_RENDER_FLAG FINISHED_BIT
                RET NZ
                JP Render.Draw

                endif ; ~_CORE_MODULE_GAME_LOOP_MAIN_MENU_
