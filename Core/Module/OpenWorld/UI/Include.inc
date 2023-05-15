
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_

                module UI
Begin           EQU $
                include "Bar_Animation.asm"

                display "\t- UI bar animation :\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_
