
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_INCLUDE_

                module Generate

                display " - Generate:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes ]"
Begin           EQU $
                include "World.asm"
                
                ; generator
                include "Core/Module/Table/Gen_PRNG.asm"
Size            EQU $-Begin

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_INCLUDE_
