
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_NPC_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_NPC_INCLUDE_

                module NPC
Begin           EQU $
                include "Update.asm"
                include "Movement.asm"
                include "RotationToTarget.asm"

                display "\t- Update object 'NPC':\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_NPC_INCLUDE_
