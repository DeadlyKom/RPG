
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_INCLUDE_

                module Collision

                display " - Collision:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $
                include "Collision.asm"
                include "Prepare.asm"
                include "Detection.asm"
                include "AABB/Include.inc"
                include "Types/Include.inc"
Size            EQU $-Begin

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_INCLUDE_
