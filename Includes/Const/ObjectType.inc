
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
VISIBLE_OBJECT_BIT          EQU 0x00                                            ; объект является видимым

FLAG_DECAL_BIT              EQU 0x07                                            ; флаг, объект является декалью
FLAG_DYNAMIC_OBJECT_BIT     EQU 0x06                                            ; флаг, объект является динамическим
FLAG_COLLISION_BIT          EQU 0x05                                            ; флаг, объект имеет коллизию

STATE_FIRE_BIT              EQU 0x07                                            ; состояние, объект ведёт огонь по цели

PLAYER_FACTION              EQU 0x00 << FACTION_SUBTYPE_BIT                     ; фракция игрока
NEUTRAL_FACTION             EQU 0x01 << FACTION_SUBTYPE_BIT                     ; нейтральная фракция
ENEMY_FACTION_A             EQU 0x02 << FACTION_SUBTYPE_BIT                     ; враждебная фракция А
ENEMY_FACTION_B             EQU 0x03 << FACTION_SUBTYPE_BIT                     ; враждебная фракция Б

FACTION_TYPE                EQU 1 << FACTION_TYPE_BIT
FACTION_SUBTYPE             EQU 1 << FACTION_SUBTYPE_BIT
FACTION_MASK                EQU %11000000
VISIBLE_OBJECT              EQU 1 << VISIBLE_OBJECT_BIT                         ; видимость объекта

FLAG_DECAL                  EQU 1 << FLAG_DECAL_BIT                             ; флаг, объект является декалью
FLAG_NOT_DECAL              EQU 0 << FLAG_DECAL_BIT                             ; флаг, объект не является декалью
FLAG_DYNAMIC_OBJECT         EQU 1 << FLAG_DYNAMIC_OBJECT_BIT                    ; флаг, объект является динамическим
FLAG_STATIC_OBJECT          EQU 0 << FLAG_DYNAMIC_OBJECT_BIT                    ; флаг, объект является статическим
FLAG_COLLISION_OBJECT       EQU 1 << FLAG_COLLISION_BIT                         ; флаг, объект имеет коллизию
FLAG_NOT_COLLISION_OBJECT   EQU 0 << FLAG_COLLISION_BIT                         ; флаг, объект не имеет коллизию

STATE_FIRE                  EQU 1 << STATE_FIRE_BIT

OBJECT_DIRECTION_MASK       EQU %01111000
IDX_OBJECT_TYPE             EQU %00111110

                            endif ; ~_CONST_OBJECT_TYPE_
