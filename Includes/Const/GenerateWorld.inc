
                ifndef _CONST_GENERATE_WORLD_
                define _CONST_GENERATE_WORLD_
DIFFICULTY_EASY             EQU 0x00                                            ; сложность игры "легко"
DIFFICULTY_NORMAL           EQU 0x01                                            ; сложность игры "нормально"
DIFFICULTY_NIGHTMARE        EQU 0x02                                            ; сложность игры "кошмарно"
DIFFICULTY_HARDCORE         EQU 0x03                                            ; сложность игры "ужасно"
DIFFICULTY_MASK             EQU %00000011

CLIMATE_TEMPERATE           EQU 0x00                                            ; климат "умеренный"
CLIMATE_HARSH               EQU 0x01                                            ; климат "суровый"
CLIMATE_MASK                EQU %00000001

MAP_SIZE_SMALL              EQU 0x00                                            ; размер карты "маленький"
MAP_SIZE_AVERAGE            EQU 0x01                                            ; размер карты "средний"
MAP_SIZE_BIG                EQU 0x02                                            ; размер карты "большой"
MAP_SIZE_MASK               EQU %00000011

                endif ; ~_CONST_GENERATE_WORLD_
