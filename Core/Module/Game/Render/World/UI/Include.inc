
                ifndef _MODULE_GAME_RENDER_UI_INCLUDE_
                define _MODULE_GAME_RENDER_UI_INCLUDE_

                module UI
HEALTH_BAR      EQU 0x01
GAS_BAR         EQU 0x02
TURBO_BAR       EQU 0x03

                include "Icons.asm"
                include "Bars.asm"
                include "Frame.asm"
                include "Draw.asm"
                include "Initialize.asm"

                endmodule

                endif ; ~_MODULE_GAME_RENDER_UI_INCLUDE_
