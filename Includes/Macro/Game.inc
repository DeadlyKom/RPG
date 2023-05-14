
                ifndef _MACRO_GAME_
                define _MACRO_GAME_
; -----------------------------------------
; установка обработчика игрового цикла
; In:
; Out:
; Corrupt:
; -----------------------------------------
SetGameLoop:    macro Func?
                LD BC, Func?
                LD (Game.MainLoop.Address), BC
                endm
; -----------------------------------------
; установка обработчика игрового цикла
; In:
; Out:
; Corrupt:
; -----------------------------------------
ResGameLoop:    macro
                LD BC, Interrupt_RET
                LD (Game.MainLoop.Address), BC
                endm
                endif ; ~_MACRO_GAME_
