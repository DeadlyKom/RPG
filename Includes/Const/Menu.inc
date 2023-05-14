
                ifndef _CONST_GAME_MENU_
                define _CONST_GAME_MENU_
MENU_ID_MAIN      EQU 0x10
MENU_ID_START     EQU 0x20
MENU_ID_CONTINUE  EQU 0x30
MENU_ID_OPTIONS   EQU 0x40
MENU_ID_REDEFINE  EQU 0x50


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

                endif ; ~_CONST_GAME_MENU_
