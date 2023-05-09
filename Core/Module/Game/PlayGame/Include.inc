
                ifndef _CORE_MODULE_GAME_PLAY_GAME_INCLUDE_
                define _CORE_MODULE_GAME_PLAY_GAME_INCLUDE_

                module PlayGame
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/PlayGame/Initialize.asm"   ; первый, точка входа
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin

                display " - Game 'Play Game':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_PLAY_GAME_INCLUDE_
