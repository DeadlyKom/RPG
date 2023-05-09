
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
                JP Render.Draw

                endif ; ~_CORE_MODULE_GAME_LOOP_SETTLEMENT_
