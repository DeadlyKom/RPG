
                ifndef _MODULE_GAME_INPUT_INCLUDE_
                define _MODULE_GAME_INPUT_INCLUDE_

                module Input
Begin           EQU $
                include "Gameplay/Include.inc"
                include "Pause/Include.inc"

                display " - Game 'Input':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_INPUT_INCLUDE_
