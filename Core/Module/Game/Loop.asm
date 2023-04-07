
                ifndef _CORE_MODULE_GAME_LOOP_
                define _CORE_MODULE_GAME_LOOP_
; -----------------------------------------
; игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GameLoop:       
.Loop           ;
.Render         ; ************ RENDER ************
                CHECK_RENDER_FLAG FINISHED_BIT
                CALL Z, Render.World

                JP .Loop

                endif ; ~_CORE_MODULE_GAME_LOOP_
