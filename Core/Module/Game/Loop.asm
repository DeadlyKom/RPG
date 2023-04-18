
                ifndef _CORE_MODULE_GAME_LOOP_
                define _CORE_MODULE_GAME_LOOP_
; -----------------------------------------
; главный игровой цикл
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MainLoop:       
.Loop           ;
.Handler        EQU $+1
                CALL World.Loop
                JR .Loop

                endif ; ~_CORE_MODULE_GAME_LOOP_
