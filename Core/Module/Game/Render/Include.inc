
                ifndef _MODULE_GAME_RENDER_INCLUDE_
                define _MODULE_GAME_RENDER_INCLUDE_

                module Render
                
                include "World.asm"
                include "Swap.asm"

                include "Sort/Include.inc"

                module Object
                include "Object.asm"
                endmodule
                endmodule

                endif ; ~_MODULE_GAME_RENDER_INCLUDE_
