
                ifndef _MODULE_GAME_WORLD_INCLUDE_
                define _MODULE_GAME_WORLD_INCLUDE_

                module World
Begin           EQU $
                ifdef _DEBUG
                include "Move.asm"
                endif
                
                include "Loop.asm"
                include "Camera.asm"
                include "Generate.asm"
                include "Interrupt.asm"

                include "Generate/MoveUp.asm"
                include "Generate/MoveRight.asm"
                include "Generate/MoveDown.asm"
                include "Generate/MoveLeft.asm"

                display " - Game 'World':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_MODULE_GAME_WORLD_INCLUDE_
