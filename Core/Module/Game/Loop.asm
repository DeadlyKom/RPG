
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
.Address        EQU $+1
                CALL #0000
                JR .Loop

                display "\t- Game 'MainLoop':\t\t\t\t", /A, MainLoop, " = busy [ ", /D, $ - MainLoop, " bytes  ]"

                endif ; ~_CORE_MODULE_GAME_LOOP_
