
                ifndef _MODULE_GAME_RENDER_INCLUDE_
                define _MODULE_GAME_RENDER_INCLUDE_

                module Render
Begin           EQU $
                include "World/Include.inc"
                include "Pause/Include.inc"

                include "Sort/Include.inc"
                include "Swap.asm"

                display " - Game 'Render':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_RENDER_INCLUDE_
