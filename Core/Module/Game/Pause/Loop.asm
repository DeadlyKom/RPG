
                ifndef _CORE_MODULE_GAME_LOOP_PAUSE_
                define _CORE_MODULE_GAME_LOOP_PAUSE_
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
                JP Game.Render.Pause.Menu

                endif ; ~_CORE_MODULE_GAME_LOOP_PAUSE_
