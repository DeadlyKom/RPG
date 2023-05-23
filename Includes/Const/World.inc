
                ifndef _CONST_WORLD_FLAGS_
                define _CONST_WORLD_FLAGS_
WORLD_NEED_TO_GENERATE_BIT  EQU 0x00                                            ; необходимость генерации данных пустоши
WORLD_LEFT_BIT              EQU 0x04                                            ; бит скрола влево
WORLD_RIGHT_BIT             EQU 0x05                                            ; бит скрола вправо
WORLD_UP_BIT                EQU 0x06                                            ; бит скрола вверх
WORLD_DOWN_BIT              EQU 0x07                                            ; бит скрола вниз

WORLD_MOVE                  EQU 1 << WORLD_LEFT_BIT | 1 << WORLD_RIGHT_BIT | 1 << WORLD_UP_BIT | 1 << WORLD_DOWN_BIT

                endif ; ~_CONST_WORLD_FLAGS_
