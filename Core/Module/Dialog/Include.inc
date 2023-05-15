
                ifndef _CORE_MODULE_DIALOG_INCLUDE_
                define _CORE_MODULE_DIALOG_INCLUDE_

                module Dialog
Begin           EQU $
                include "Display.asm"
                include "Scroll.asm"

                display " - Dialog base:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_DIALOG_INCLUDE_
