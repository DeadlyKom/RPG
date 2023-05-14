
                ifndef _CORE_MODULE_OPEN_WORLD_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_INCLUDE_

                module OpenWorld

                include "Utils/Include.inc"
                include "Object/Include.inc"
                include "Wasteland/Include.inc"
                include "Gen_Game.asm"

                ; generator
                include "Core/Module/Table/Gen_PRNG.asm"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_INCLUDE_
