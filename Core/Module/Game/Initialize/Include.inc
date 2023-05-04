
                ifndef _MODULE_GAME_INITIALIZE_INCLUDE_
                define _MODULE_GAME_INITIALIZE_INCLUDE_

                module Initialize
Begin           EQU $
                include "Core.asm"
                include "World.asm"
                include "Input.asm"
                include "Player.asm"

                display " - Game 'Initialize':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_INITIALIZE_INCLUDE_
