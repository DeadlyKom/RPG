
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_MAP_INCLUDE_

                module Map

                display " * Map:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes ]"
Begin           EQU $
                include "Prepare.asm"
Size            EQU $-Begin

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_INCLUDE_
