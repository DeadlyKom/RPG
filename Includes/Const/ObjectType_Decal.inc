
                ifndef _CONST_OBJECT_TYPE_DECAL_
                define _CONST_OBJECT_TYPE_DECAL_

OBJECT_CACTUS_A EQU 0x00 | FLAG_NOT_DECAL                                       ; кактус A
OBJECT_CACTUS_B EQU 0x01 | FLAG_NOT_DECAL                                       ; кактус B
OBJECT_CACTUS_C EQU 0x02 | FLAG_NOT_DECAL                                       ; кактус C
OBJECT_GRASS    EQU 0x03 | FLAG_DECAL                                           ; трава
OBJECT_SCULL_A  EQU 0x04 | FLAG_DECAL                                           ; череп A
OBJECT_LOG_A    EQU 0x05 | FLAG_NOT_DECAL                                       ; бревно A
OBJECT_STONE_A  EQU 0x06 | FLAG_NOT_DECAL                                       ; камень A
OBJECT_STONE_B  EQU 0x07 | FLAG_NOT_DECAL                                       ; камень B
OBJECT_STONE_C  EQU 0x08 | FLAG_NOT_DECAL                                       ; камень C
OBJECT_LOG_B    EQU 0x09 | FLAG_NOT_DECAL                                       ; бревно B
OBJECT_LOG_C    EQU 0x0A | FLAG_NOT_DECAL                                       ; бревно C
OBJECT_DITCH_A  EQU 0x0B | FLAG_DECAL                                           ; канава A
OBJECT_SCULL_B  EQU 0x0C | FLAG_DECAL                                           ; череп B
OBJECT_DITCH_B  EQU 0x0B | FLAG_DECAL                                           ; канава B

IDX_OBJECT_SUBTYPE  EQU %01111111

                endif ; ~_CONST_OBJECT_TYPE_DECAL_
