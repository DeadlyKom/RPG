
                ifndef _MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_
                define _MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_

                module Input
KEY_ID_SELECT_1 EQU 0x80
KEY_ID_SELECT_2 EQU 0x81
KEY_ID_SELECT_3 EQU 0x82
KEY_ID_SELECT_4 EQU 0x83
KEY_ID_SELECT_5 EQU 0x84
KEY_ID_SELECT_6 EQU 0x85
KEY_ID_SELECT_7 EQU 0x86
KEY_ID_SELECT_8 EQU 0x87
KEY_ID_SELECT_9 EQU 0x88

                include "Scan.asm"
                include "InputHandler_GameMode.asm"
                include "InputHandler_SecetionMode.asm"
                include "RedefineKeys.asm"
INPUT_MODE_SELECT_KEYS      EQU 0x00                                            ; режим выбора цифрами
INPUT_MODE_NUMBER_KEYS      EQU 0x01                                            ; режим выбора набора цифр
INPUT_MODE_REDEFINE_KEYS    EQU 0x02                                            ; режим переназначения клавиш
INPUT_MODE_GAME_KEYS        EQU 0x03                                            ; режим игровых клавиш

InputFlag       DB INPUT_MODE_SELECT_KEYS
OldInputFlag    DB INPUT_MODE_SELECT_KEYS

                endmodule

                endif ; ~_MODULE_GAME_INPUT_MAIN_MENU_INCLUDE_
