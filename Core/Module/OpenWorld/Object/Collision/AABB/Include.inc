
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_AABB_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_AABB_INCLUDE_
                
                module AABB
Begin           EQU $
                include "GetAABB.asm"
                include "Pawn.asm"
                include "Decal.asm"
                include "Mine.asm"

                display "\t- AABB:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_AABB_INCLUDE_
