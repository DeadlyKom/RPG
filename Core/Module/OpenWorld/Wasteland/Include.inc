
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_      

                module Wasteland
Begin           EQU $
                include "Camera.asm"
                include "Generate.asm"
                include "Initialize.asm"
                include "WastelandNoise.asm"

                include "MoveUp.asm"
                include "MoveRight.asm"
                include "MoveDown.asm"
                include "MoveLeft.asm"

                display " - Game 'Wasteland':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_
