
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_INCLUDE_

                module Player
Begin           EQU $
                include "Update.asm"
                include "Rotation.asm"
                include "Deceleration.asm"
                include "Spawn_Dust.asm"
                include "Spawn_Mine.asm"
                include "Spawn_Explosion.asm"

                display "\t- Update object 'PLAYER':\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_INCLUDE_
