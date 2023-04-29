
                ifndef _MODULE_GAME_RENDER_UI_INCLUDE_
                define _MODULE_GAME_RENDER_UI_INCLUDE_

                module UI
HEALTH_BAR      EQU 0x01
GAS_BAR         EQU 0x02
TURBO_BAR       EQU 0x03

SLOT_NONE       EQU 0x00
SLOT_MACHINEGUN EQU 0x01
SLOT_MINE       EQU 0x02
SLOT_ROCKET     EQU 0x03
SLOT_REPAIRKIT  EQU 0x03

                include "Icons.asm"
                include "Slot.asm"
                include "Bars.asm"
                include "Frame.asm"
                include "Draw.asm"
                include "Initialize.asm"

                endmodule

                endif ; ~_MODULE_GAME_RENDER_UI_INCLUDE_
