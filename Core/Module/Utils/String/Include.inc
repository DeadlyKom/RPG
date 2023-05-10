
                ifndef _CORE_MODULE_UTILS_STRING_INCLUDE_
                define _CORE_MODULE_UTILS_STRING_INCLUDE_

                module Utils
                module String
Begin           EQU $

                include "Copy.asm"
                include "GetWidth.asm"
                include "GetLength.asm"
                include "GetStringID.asm"
                include "ConvertNumberToString.asm"

                display " - Utils string:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule
                endmodule

                endif ; ~_CORE_MODULE_UTILS_STRING_INCLUDE_
