
                            ifndef _CONST_OBJECT_TYPE_
                            define _CONST_OBJECT_TYPE_
OBJECT_EMPTY_ELEMENT        EQU #FF                                             ; свобдный элемент массива

; сдвиг необходим для быстрого получить адрес из таблице по типу юнита (GetAdrInTable)
OBJECT_PLAYER               EQU 0x00 << 1                                       ; игрок
OBJECT_DECAL                EQU 0x01 << 1                                       ; декаль
OBJECT_COLLISION            EQU 0x02 << 1                                       ; физичный объект

FACTION_TYPE_BIT            EQU 0x07                                            ; тип фракции (0 - нейтральная, 1 - враждебная)
FACTION_SUBTYPE_BIT         EQU 0x06
VISIBLE_OBJECT_BIT          EQU 0x00                                            ; видимость объекта

PLAYER_FACTION              EQU 0x00 << FACTION_SUBTYPE_BIT                     ; фракция игрока
NEUTRAL_FACTION             EQU 0x01 << FACTION_SUBTYPE_BIT                     ; нейтральная фракция
ENEMY_FACTION_A             EQU 0x02 << FACTION_SUBTYPE_BIT                     ; враждебная фракция А
ENEMY_FACTION_B             EQU 0x03 << FACTION_SUBTYPE_BIT                     ; враждебная фракция Б

FACTION_TYPE                EQU 1 << FACTION_TYPE_BIT
FACTION_SUBTYPE             EQU 1 << FACTION_SUBTYPE_BIT
FACTION_MASK                EQU %11000000
IDX_OBJECT_TYPE             EQU %00111110

                            endif ; ~_CONST_OBJECT_TYPE_
