
                ifndef _CONST_GAME_
                define _CONST_GAME_

EXECUTE_ID_MAP          EQU 0x00                                                ; идентификатор запуска "карта"
EXECUTE_ID_WASTELAND    EQU 0x01                                                ; идентификатор запуска "пустошь"


SETTING_MAP_SIZE_SMALL  EQU MAP_SIZE_SMALL << 3
SETTING_MAP_SIZE_AVERAGE EQU MAP_SIZE_AVERAGE << 3
SETTING_MAP_SIZE_BIG    EQU MAP_SIZE_BIG << 3
SETTING_MAP_SIZE_MASK   EQU MAP_SIZE_MASK << 3

                endif ; ~_CONST_GAME_
