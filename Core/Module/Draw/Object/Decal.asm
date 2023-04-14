
                ifndef _CORE_MODULE_DRAW_OBJECT_DECAL_
                define _CORE_MODULE_DRAW_OBJECT_DECAL_

Remove          ; ToDo удалить объект
                LD (IX + FObjectDecal.Type), OBJECT_EMPTY_ELEMENT
                LD HL, GameState.Objects
                DEC (HL)
                JP DrawDecal.RET

; -----------------------------------------
; отображение дроид-пехотинца
; In:
;   IX - указывает на структуру FObjectDecal
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawDecal:      ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; -----------------------------------------
                ; расчёт дельт позиции декали
                ; -----------------------------------------

                LD BC, (PlayerState.CameraPosX + 1)
                LD HL, (IX + FObjectDecal.Location.X.Low)
                OR A
                SBC HL, BC
                LD A, L
                EX AF, AF'
                LD BC, ((SCR_MINIMAP_SIZE_X - (SCR_WORLD_SIZE_X << 1)) >> 1) + 2
                ADD HL, BC

                EX AF, AF'
                JP P, $+5
                NEG
                CP (SCR_MINIMAP_SIZE_X >> 1) + 1
                JR NC, Remove
                
;                 LD A, L
;                 JR NC, .PositiveX
;                 CP -SCR_MINIMAP_SIZE_X
;                 JR C, Remove                                                    ; переход, если объект дальше -32
;                 JR .PositiveX_
; .PositiveX      CP -SCR_MINIMAP_SIZE_X
;                 JR NC, Remove                                                   ; переход, если объект дальше +32
; .PositiveX_

                ; -----------------------------------------
                ;   значение фиксированной точки 12.4 (знаковое)    [от -2^11 до +2^11 в пикселях]
                ;   2 байта на каждую ось X,Y
                ;
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | I11| I10| I9 | I8 | I7 | I6 | I5 | I4 |   | I3 | I2 | I1 | I0 | F0 | F1 | F2 | F3 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;
                ;   I11-I0  [15..4] - целая часть фиксированной точки 12.4
                ;   F0-F3   [3..0]  - дробная часть фиксированной точки 12.4
                ; -----------------------------------------
                LD H, L
                LD A, (World.Shift_X)
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                LD L, A
                LD A, #E0
                SUB L
                LD L, A
                LD (IX + FObjectDecal.Position.X), HL                           ; сохранение позиции юнита по горизонтали
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции юнита по горизонтали

                LD BC, (PlayerState.CameraPosY + 1)
                LD HL, (IX + FObjectDecal.Location.Y.Low)
                OR A
                SBC HL, BC
                LD A, L
                EX AF, AF'
                LD BC, ((SCR_MINIMAP_SIZE_Y - ((SCR_WORLD_SIZE_Y + 1) << 1)) >> 1) + 0
                ADD HL, BC

                EX AF, AF'
                JP P, $+5
                NEG
                CP (SCR_MINIMAP_SIZE_Y >> 1) + 1
                JR NC, Remove


;                 LD A, L
;                 JR NC, .PositiveY
;                 CP -SCR_MINIMAP_SIZE_Y
;                 JR C, Remove                                                    ; переход, если объект дальше -32
;                 JR .PositiveY_
; .PositiveY      CP -SCR_MINIMAP_SIZE_Y
;                 JR NC, Remove                                                   ; переход, если объект дальше +32
; .PositiveY_

                ; -----------------------------------------
                ;   значение фиксированной точки 12.4 (знаковое)    [от -2^11 до +2^11 в пикселях]
                ;   2 байта на каждую ось X,Y
                ;
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | I11| I10| I9 | I8 | I7 | I6 | I5 | I4 |   | I3 | I2 | I1 | I0 | F0 | F1 | F2 | F3 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;
                ;   I11-I0  [15..4] - целая часть фиксированной точки 12.4
                ;   F0-F3   [3..0]  - дробная часть фиксированной точки 12.4
                ; -----------------------------------------
                LD H, L
                LD A, (World.Shift_Y)
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                LD L, A
                LD (IX + FObjectDecal.Position.Y), HL                           ; сохранение позиции юнита по вертикали
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции юнита по вертикали

                ; ; подготовка позиции вывода объекта
                ; LD HL, (IX + FObjectDecal.Position.X)
                ; LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции юнита по горизонтали
                ; LD HL, (IX + FObjectDecal.Position.Y)
                ; LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции юнита по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                
                LD A, (IX + FObjectDecal.Subtype)
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, LOW SpriteInfo.Decals
                LD L, A
                ADC A, HIGH SpriteInfo.Decals
                SUB L
                LD H, A

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD E, (HL)                                                      ; FSprite.Info.Height
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetY
                LD (Draw.Prepare.SOy), A
                INC HL
                LD D, (HL)                                                      ; FSprite.Info.Width
                LD (Draw.Prepare.Size), DE
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetX
                LD (Draw.Prepare.SOx), A
                INC HL
                LD A, (HL)                                                      ; FSprite.Offset
                INC HL
                LD (GameConfig.SpriteOffsetRef), A
                LD A, (HL)                                                      ; FSprite.Page
                INC HL
                LD E, CSIF_OR_XOR << 1
                ADD A, A
                RR E
                RRA
                CALL SetPage
                LD A, E
                LD (GameConfig.SpriteFlagRef), A
                LD E, (HL)                                                      ; FSprite.Data.Low
                INC HL
                LD D, (HL)                                                      ; FSprite.Data.High
                EX DE, HL

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                include "Core/Module/Graphics/Tile/World/Sprite/Original/Decal/Info.inc"

                display " - Draw object 'DECAL':\t\t\t\t", /A, DrawDecal, " = busy [ ", /D, $ - DrawDecal, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_DECAL_
