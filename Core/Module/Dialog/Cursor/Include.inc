
                ifndef _CORE_MODULE_DIALOG_CURSOR_INCLUDE_
                define _CORE_MODULE_DIALOG_CURSOR_INCLUDE_

                module Cursor
Begin           EQU $
                include "Draw.asm"
                include "Up.asm"
                include "Down.asm"
                include "Prev.asm"
                include "Next.asm"

                display " - Dialog cursor:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_INCLUDE_
