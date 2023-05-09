
                ifndef _CONST_GAME_
                define _CONST_GAME_
CURSOR_DEC      EQU #FF
CURSOR_INC      EQU #01

MENU_STARTUP_BIT    EQU 0x00                                                    ; бит, первичного запуска меню (необходимо для инициализации)
MENU_LOOP_BIT       EQU 0x01                                                    ; бит, завершения цикла меню
MENU_FADEOUT_BIT    EQU 0x02                                                    ; бит, эффекта затемнения

MENU_STARTUP    EQU 1 << MENU_STARTUP_BIT
MENU_LOOP       EQU 1 << MENU_LOOP_BIT
MENU_FADEOUT    EQU 1 << MENU_FADEOUT_BIT

                endif ; ~_CONST_GAME_
