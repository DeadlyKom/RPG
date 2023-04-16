
                ifndef _MODULE_GAME_OBJECT_PLAYER_INCLUDE_
                define _MODULE_GAME_OBJECT_PLAYER_INCLUDE_

                module Player
Begin           EQU $
                include "Player.asm"
                include "Input.asm"
                include "Rotation.asm"
                include "Deceleration.asm"
                include "Dust.asm"

                display " - Update object 'PLAYER':\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_INCLUDE_
