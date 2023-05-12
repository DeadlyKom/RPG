
                ifndef _CORE_MODULE_DIALOG_CURSOR_INCLUDE_
                define _CORE_MODULE_DIALOG_CURSOR_INCLUDE_

                module Cursor
Begin           EQU $
                include "Draw.asm"
                include "Up.asm"

                display " - Dialog cursor:\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_INCLUDE_
