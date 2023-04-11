
                ifndef _CORE_MODULE_DRAW_OBJECT_PLAYER_
                define _CORE_MODULE_DRAW_OBJECT_PLAYER_
; -----------------------------------------
; отображение дроид-пехотинца
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawPlayer:     ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, (IX + FObject.Position.X)
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции юнита по горизонтали
                LD HL, (IX + FObject.Position.Y)
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции юнита по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------

                LD H, HIGH SpriteInfo.Car
                LD A, (IX + FObject.Direction)
                AND %01111000
                ADD A, LOW SpriteInfo.Car
                LD L, A
                ADC A, H
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

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                include "Core/Module/Graphics/Car/A/Sprite/Info.inc"

                display " - Draw object 'PLAYER':\t\t\t\t", /A, DrawPlayer, " = busy [ ", /D, $ - DrawPlayer, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_PLAYER_
