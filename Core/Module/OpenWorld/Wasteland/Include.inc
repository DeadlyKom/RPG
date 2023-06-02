
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_      

                module Wasteland

                display " * Game 'Wasteland':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $
                include "Camera.asm"
                include "Generate.asm"
                include "Initialize.asm"
                include "WastelandNoise.asm"

                include "MoveRight.asm"
                include "MoveUp.asm"
                include "MoveDown.asm"
                include "MoveLeft.asm"
Size            EQU $-Begin

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_INCLUDE_
