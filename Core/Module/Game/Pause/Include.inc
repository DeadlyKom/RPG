
                ifndef _MODULE_GAME_PAUSE_INCLUDE_
                define _MODULE_GAME_PAUSE_INCLUDE_

                module Pause
Begin           EQU $
                include "Loop.asm"
                include "Interrupt.asm"

                display " - Game 'Pause Menu':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_PAUSE_INCLUDE_
