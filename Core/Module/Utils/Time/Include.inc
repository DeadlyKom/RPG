
                ifndef _CORE_MODULE_UTILS_TIME_INCLUDE_
                define _CORE_MODULE_UTILS_TIME_INCLUDE_

                module Utils
                module Time
Begin           EQU $

                include "Tick.asm"

                display " - Utils time:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule
                endmodule

                endif ; ~_CORE_MODULE_UTILS_TIME_INCLUDE_
