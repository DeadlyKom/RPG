
                ifndef _MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_
                define _MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_

                module Input
KEY_ID_SELECT_1 EQU 0x00
KEY_ID_SELECT_2 EQU 0x01
KEY_ID_SELECT_3 EQU 0x02
KEY_ID_SELECT_4 EQU 0x03
KEY_ID_SELECT_5 EQU 0x04
KEY_ID_SELECT_6 EQU 0x05
KEY_ID_SELECT_7 EQU 0x06
KEY_ID_SELECT_8 EQU 0x07
KEY_ID_SELECT_9 EQU 0x08

                include "Scan.asm"
                include "InputHandler.asm"
                include "RedefineKeys.asm"

                endmodule

                endif ; ~_MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_
