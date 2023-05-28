
                ifndef _CORE_MODULE_OPEN_WORLD_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_INCLUDE_

                module OpenWorld

                display " - OpenWorld:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes ]"
Begin           EQU $
                include "UI/Include.inc"
                include "Map/Include.inc"
                include "Utils/Include.inc"
                include "Object/Include.inc"
                include "Generate/Include.inc"
                include "Wasteland/Include.inc"
Size            EQU $-Begin
                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_INCLUDE_
