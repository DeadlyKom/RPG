
                ifndef _CORE_MODULE_DRAW_OBJECT_PAWN_SPRITE_INFO_
                define _CORE_MODULE_DRAW_OBJECT_PAWN_SPRITE_INFO_
; -----------------------------------------
; отображение машины
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
;   HL - адрес информации о спрайте FSprite
; Corrupt:
; Note:
; -----------------------------------------
GetSpriteInfo:  ; -----------------------------------------
                ;
                ; в аккумуляторе
                ;
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | F1 | F0 | D  | T3 | T2 | T1 | T0 | V  |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   F1,F0   [7,6]   - тип фракции
                ;                       00 - игрок
                ;                       01 - нейтральные/союзники
                ;                       10 - враг 1
                ;                       11 - враг 2
                ;   D       [5]     - динамичность объекта
                ;   Т4-T0   [4..1]  - тип объекта
                ;   V       [0]     - видимость объекта
                ; -----------------------------------------
                AND FACTION_MASK
                LD L, A
                LD H, #00
                ADD HL, HL
                LD DE, SpriteInfo
                ADD HL, DE
                LD A, C
                AND OBJECT_DIRECTION_MASK
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                RET
SpriteInfo      ; PLAYER_FACTION
                include "Core/Module/Graphics/Car/A/Sprite/Info.inc"
                ; NEUTRAL_FACTION
                DS 128, 0
                ; ENEMY_FACTION_A
                include "Core/Module/Graphics/Car/B/Sprite/Info.inc"
                ; ENEMY_FACTION_B
                DS 128, 0

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_PAWN_SPRITE_INFO_
