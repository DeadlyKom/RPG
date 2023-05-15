
                ifndef _CORE_MODULE_OPEN_WORLD_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_INCLUDE_

                module OpenWorld

                display " - OpenWorld:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes ]"
Begin           EQU $
                include "Utils/Include.inc"
                include "Object/Include.inc"
                include "Wasteland/Include.inc"
                include "Gen_Game.asm"

                include "UI/Include.inc"

                ; generator
                include "Core/Module/Table/Gen_PRNG.asm"
Size            EQU $-Begin
                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_INCLUDE_
