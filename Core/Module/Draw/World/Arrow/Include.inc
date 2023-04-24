                ifndef _CORE_MODULE_DRAW_WORLD_DRAW_ARROW_INCLUDE_
                define _CORE_MODULE_DRAW_WORLD_DRAW_ARROW_INCLUDE_

                module Arrow
Begin           EQU $

                include "Draw.asm"

                display " - Draw UI Arrow :\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_WORLD_DRAW_ARROW_INCLUDE_
