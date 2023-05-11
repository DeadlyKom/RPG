
                ifndef _CORE_MODULE_GAME_UI_INCLUDE_
                define _CORE_MODULE_GAME_UI_INCLUDE_

                module UI
Begin           EQU $
                include "Charecter/Include.inc"

                display " - UI animation:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_UI_INCLUDE_
