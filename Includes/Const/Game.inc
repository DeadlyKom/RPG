
                ifndef _CONST_GAME_
                define _CONST_GAME_
CURSOR_DEC      EQU #FF
CURSOR_INC      EQU #01

MENU_STARTUP_BIT        EQU 0x00                                                ; бит, первичного запуска меню (необходимо для инициализации)
MENU_UPDTAE_BIT         EQU 0x01                                                ; бит, обновления меню
MENU_LOOP_BIT           EQU 0x02                                                ; бит, завершения цикла меню
MENU_FADEOUT_BIT        EQU 0x03                                                ; бит, эффекта затемнения
MENU_FADEIN_BIT         EQU 0x04                                                ; бит, эффекта осветления
MENU_UPDATE_SCROLL_BIT  EQU 0x05                                                ; бит, необходимости обновить скролл
MENU_SCROLL_BIT         EQU 0x06                                                ; бит, необходимости скролла
MENU_SCROLL_DIR_BIT     EQU 0x07                                                ; бит, направления скролла
                                                                                ; 0 - вверх
                                                                                ; 1 - вниз

MENU_STARTUP            EQU 1 << MENU_STARTUP_BIT
MENU_UPDTAE             EQU 1 << MENU_UPDTAE_BIT
MENU_LOOP               EQU 1 << MENU_LOOP_BIT
MENU_FADEOUT            EQU 1 << MENU_FADEOUT_BIT
MENU_FADEIN             EQU 1 << MENU_FADEIN_BIT
MENU_UPDATE_SCROLL      EQU 1 << MENU_UPDATE_SCROLL_BIT
MENU_SCROLL             EQU 1 << MENU_SCROLL_BIT
MENU_SCROLL_UP          EQU 0 << MENU_SCROLL_DIR_BIT
MENU_SCROLL_DOWN        EQU 1 << MENU_SCROLL_DIR_BIT

                endif ; ~_CONST_GAME_
