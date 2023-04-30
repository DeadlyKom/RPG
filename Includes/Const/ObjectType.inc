
                            ifndef _CONST_OBJECT_TYPE_
                            define _CONST_OBJECT_TYPE_
OBJECT_EMPTY_ELEMENT        EQU #FF                                             ; свобдный элемент массива

; сдвиг необходим для быстрого получить адреса
OBJECT_PLAYER               EQU 0x00 << 1                                       ; игрок
OBJECT_NPC                  EQU 0x01 << 1                                       ; NPC
OBJECT_DECAL                EQU 0x02 << 1                                       ; декаль
OBJECT_COLLISION            EQU 0x03 << 1                                       ; физичный объект
OBJECT_PARTICLE             EQU 0x04 << 1                                       ; частица
OBJECT_MINE                 EQU 0x05 << 1                                       ; мина

FACTION_TYPE_BIT            EQU 0x07                                            ; тип фракции (0 - нейтральная, 1 - враждебная)
FACTION_SUBTYPE_BIT         EQU 0x06
DYNAMIC_OBJECT_BIT          EQU 0x05                                            ; динамичность объекта
VISIBLE_OBJECT_BIT          EQU 0x00                                            ; видимость объекта

DECAL_FLAG_BIT              EQU 0x07                                            ; объект является декалью
FIRE_BIT                    EQU 0x06                                            ; объект ведёт огонь по цели

PLAYER_FACTION              EQU 0x00 << FACTION_SUBTYPE_BIT                     ; фракция игрока
NEUTRAL_FACTION             EQU 0x01 << FACTION_SUBTYPE_BIT                     ; нейтральная фракция
ENEMY_FACTION_A             EQU 0x02 << FACTION_SUBTYPE_BIT                     ; враждебная фракция А
ENEMY_FACTION_B             EQU 0x03 << FACTION_SUBTYPE_BIT                     ; враждебная фракция Б

DECAL_FLAG                  EQU 1 << DECAL_FLAG_BIT                             ; флаг, объект является декалью
NOT_DECAL_FLAG              EQU 0 << DECAL_FLAG_BIT                             ; флаг, объект не является декалью

FACTION_TYPE                EQU 1 << FACTION_TYPE_BIT
FACTION_SUBTYPE             EQU 1 << FACTION_SUBTYPE_BIT
FACTION_MASK                EQU %11000000

DYNAMIC_OBJECT              EQU 1 << DYNAMIC_OBJECT_BIT                         ; динамичный объекта
VISIBLE_OBJECT              EQU 1 << VISIBLE_OBJECT_BIT                         ; видимость объекта

OBJECT_DIRECTION_MASK       EQU %01111000
IDX_OBJECT_TYPE             EQU %00011110

                            endif ; ~_CONST_OBJECT_TYPE_
