
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_INCLUDE_
                define _MODULE_GAME_RENDER_MAIN_MENU_INCLUDE_

                module Render
MENU_TYPE_MAIN      EQU 0x10
MENU_TYPE_CONTINUE  EQU 0x20
MENU_TYPE_OPTIONS   EQU 0x30
MENU_TYPE_REDEFINE  EQU 0x40
MENU_FADEOUT_FLAG   EQU 0x01

                include "Draw.asm"
                include "Main.asm"
                include "Continue.asm"
                include "Options.asm"
                include "RedefineKeys.asm"
                include "Fadeout.asm"

                endmodule

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_INCLUDE_
