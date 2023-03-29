
                ifndef _MODULE_GAME_WORLD_INCLUDE_
                define _MODULE_GAME_WORLD_INCLUDE_

                module World
                
                include "Generate.asm"
                include "Move.asm"

                include "Generate/MoveLeft.asm"
                include "Generate/MoveRight.asm"
                include "Generate/MoveDown.asm"
                include "Generate/Tilepair.asm"

                endmodule

                endif ; ~_MODULE_GAME_WORLD_INCLUDE_
