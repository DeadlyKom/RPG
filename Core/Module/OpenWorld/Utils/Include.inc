
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_

                module Utils
Begin           EQU $

                include "GetHash.asm"
                include "GetName.asm"
                include "GetRegion.asm"
                include "CalcMetadata.asm"
                include "SetGenerateKey.asm"
                include "ShuffleCoordinates.asm"
                include "RotateLeft_x32.asm"
                include "RotateRight_x32.asm"

                display " * Open world utils:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_UTILS_INCLUDE_
