
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_INCLUDE_
                
                module Types
Begin           EQU $
                include "Handler.asm"
                include "Decal.asm"
                include "Mine.asm"

                display "\t- Types:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_INCLUDE_
