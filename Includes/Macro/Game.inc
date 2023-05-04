
                ifndef _MACRO_GAME_
                define _MACRO_GAME_
SetMainLoop:    macro Func?
                LD BC, Func?
                LD (Game.MainLoop.Address), BC
                endm

                endif ; ~_MACRO_GAME_
