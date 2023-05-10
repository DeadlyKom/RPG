
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_

                module Utils
Begin           EQU $

                include "GetName.asm"
                include "SetGenerateKey.asm"
                include "CalcSettlement.asm"
                include "ShuffleCoordinates.asm"

                display " - Open world utils:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_
