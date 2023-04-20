
                ifndef _MODULE_GAME_OBJECT_NPC_INCLUDE_
                define _MODULE_GAME_OBJECT_NPC_INCLUDE_

                module NPC
Begin           EQU $
                include "Update.asm"
                include "Movement.asm"
                include "RotationToTarget.asm"

                display " - Update object 'NPC':\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_OBJECT_NPC_INCLUDE_
