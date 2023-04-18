
                ifndef _CORE_MODULE_GAME_LOOP_WORLD_
                define _CORE_MODULE_GAME_LOOP_WORLD_
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
                JP Game.Render.World.Pass

                endif ; ~_CORE_MODULE_GAME_LOOP_WORLD_
