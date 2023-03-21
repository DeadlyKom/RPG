
                ifndef _CONST_INPUT_
                define _CONST_INPUT_

                include "Core/Module/Input/Mouse/VirtualKeys.inc"
                include "Core/Module/Input/Keyboard/VirtualKeys.inc"
                include "Core/Module/Input/Kempston/VirtualKeys.inc"

NUMBER_KEYS_ID      EQU 0x08
KEY_ID_UP           EQU 0x00                                                    ; клавиша "вверх"
KEY_ID_LEFT         EQU 0x01                                                    ; клавиша "влево"
KEY_ID_DOWN         EQU 0x02                                                    ; клавиша "вниз"
KEY_ID_RIGHT        EQU 0x03                                                    ; клавиша "вправо"
KEY_ID_SELECT       EQU 0x04                                                    ; клавиша "выбор"
KEY_ID_BACK         EQU 0x05                                                    ; клавиша "отмена/назад"
KEY_ID_ACCELERATION EQU 0x06                                                    ; клавиша "ускорить"
KEY_ID_MENU         EQU 0x07                                                    ; клавиша "меню/пауза"

                endif ; ~_CONST_INPUT_
                