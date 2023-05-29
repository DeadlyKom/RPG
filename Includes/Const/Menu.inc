
                ifndef _CONST_GAME_MENU_
                define _CONST_GAME_MENU_

; стартовое меню
MENU_ID_MAIN                EQU 0x10
MENU_ID_START               EQU 0x20
MENU_ID_CONTINUE            EQU 0x30
MENU_ID_OPTIONS             EQU 0x40
MENU_ID_REDEFINE            EQU 0x50

; меню начала игры
MENU_ID_KEY_GENERATION      EQU 0x00                                            ; ID меню, ключ генерации
MENU_ID_DIFFICULTY          EQU 0x01                                            ; ID меню, выбора сложности
MENU_ID_CLIMATE             EQU 0x02                                            ; ID меню, выбора климата
MENU_ID_MAP_SIZE            EQU 0x03                                            ; ID меню, выбор размера карты
MENU_ID_SETTLES_NUM         EQU 0x04
MENU_ID_PLAY                EQU 0x04                                            ; ID меню, начало

; меню поселение

MENU_ID_ENTRANCE            EQU 0x00                                            ; главный вход, наличие ограждённого периметра
MENU_ID_RESIDENTIAL_AREA    EQU 0x01                                            ; жилой район
MENU_ID_WAREHOUSE           EQU 0x02                                            ; склад и сборщик лома
MENU_ID_SHOPPING_AREA       EQU 0x03                                            ; торговый район
MENU_ID_BAR                 EQU 0x04                                            ; бар
MENU_ID_WORKSHOP            EQU 0x05                                            ; мастерская
MENU_ID_PRISON              EQU 0x06                                            ; тюрьма
MENU_ID_RADIO_TOWER         EQU 0x07                                            ; радио вышка
MENU_ID_WASTELAND           EQU 0x08                                            ; пустошь


; управление меню
CURSOR_DEC                  EQU #FF
CURSOR_INC                  EQU #01


; флаги работы с меню
MENU_STARTUP_BIT            EQU 0x00                                            ; бит, первичного запуска меню (необходимо для инициализации)
MENU_UPDTAE_BIT             EQU 0x01                                            ; бит, обновления меню
MENU_LOOP_BIT               EQU 0x02                                            ; бит, завершения цикла меню
MENU_FADEOUT_BIT            EQU 0x03                                            ; бит, эффекта затемнения
MENU_FADEIN_BIT             EQU 0x04                                            ; бит, эффекта осветления
MENU_UPDATE_SCROLL_BIT      EQU 0x05                                            ; бит, необходимости обновить скролл
MENU_SCROLL_BIT             EQU 0x06                                            ; бит, необходимости скролла
MENU_SCROLL_DIR_BIT         EQU 0x07                                            ; бит, направления скролла
                                                                                ; 0 - вверх
                                                                                ; 1 - вниз

MENU_STARTUP                EQU 1 << MENU_STARTUP_BIT
MENU_UPDTAE                 EQU 1 << MENU_UPDTAE_BIT
MENU_LOOP                   EQU 1 << MENU_LOOP_BIT
MENU_FADEOUT                EQU 1 << MENU_FADEOUT_BIT
MENU_FADEIN                 EQU 1 << MENU_FADEIN_BIT
MENU_UPDATE_SCROLL          EQU 1 << MENU_UPDATE_SCROLL_BIT
MENU_SCROLL                 EQU 1 << MENU_SCROLL_BIT
MENU_SCROLL_UP              EQU 0 << MENU_SCROLL_DIR_BIT
MENU_SCROLL_DOWN            EQU 1 << MENU_SCROLL_DIR_BIT

                endif ; ~_CONST_GAME_MENU_
