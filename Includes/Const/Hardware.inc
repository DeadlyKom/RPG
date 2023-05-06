
                ifndef _CONST_HARDWARE_FLAGS_
                define _CONST_HARDWARE_FLAGS_

HARDWARE_KEMPSTON_BIT           EQU 0x00                                        ; бит наличия кемстон джойстика
HARDWARE_KEMPSTON_BUTTON_BIT    EQU 0x01                                        ; бит тип кемстон джойстика
                                                                                ;   0 - 5 кнопок (классический)
                                                                                ;   1 - 8 кнопок

                endif ; ~_CONST_HARDWARE_FLAGS_
