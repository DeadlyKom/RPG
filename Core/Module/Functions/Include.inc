
                ifndef _CORE_MODULE_FUNCTIONS_INCLUDE_
                define _CORE_MODULE_FUNCTIONS_INCLUDE_

                module Functions
Begin           EQU $
                include "Fadeout.asm"                                           ; (0)
                include "ScreenCopy.asm"                                        ; (1)

                display " - Functions:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_FUNCTIONS_INCLUDE_
