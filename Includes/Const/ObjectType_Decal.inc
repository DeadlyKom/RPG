
                ifndef _CONST_OBJECT_TYPE_DECAL_
                define _CONST_OBJECT_TYPE_DECAL_

OBJECT_CACTUS_A EQU 0x00 | NOT_DECAL_FLAG                                       ; кактус A
OBJECT_CACTUS_B EQU 0x01 | NOT_DECAL_FLAG                                       ; кактус B
OBJECT_CACTUS_C EQU 0x02 | NOT_DECAL_FLAG                                       ; кактус C
OBJECT_GRASS    EQU 0x03 | DECAL_FLAG                                           ; трава
OBJECT_SCULL_A  EQU 0x04 | DECAL_FLAG                                           ; череп A
OBJECT_LOG_A    EQU 0x05 | NOT_DECAL_FLAG                                       ; бревно A
OBJECT_STONE_A  EQU 0x06 | NOT_DECAL_FLAG                                       ; камень A
OBJECT_STONE_B  EQU 0x07 | NOT_DECAL_FLAG                                       ; камень B
OBJECT_STONE_C  EQU 0x08 | NOT_DECAL_FLAG                                       ; камень C
OBJECT_LOG_B    EQU 0x09 | NOT_DECAL_FLAG                                       ; бревно B
OBJECT_LOG_C    EQU 0x0A | NOT_DECAL_FLAG                                       ; бревно C
OBJECT_DITCH_A  EQU 0x0B | DECAL_FLAG                                           ; канава A
OBJECT_SCULL_B  EQU 0x0C | DECAL_FLAG                                           ; череп B
OBJECT_DITCH_B  EQU 0x0B | DECAL_FLAG                                           ; канава B

IDX_OBJECT_SUBTYPE  EQU %01111111

                endif ; ~_CONST_OBJECT_TYPE_DECAL_
