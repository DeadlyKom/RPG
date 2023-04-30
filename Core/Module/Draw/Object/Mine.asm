
                ifndef _CORE_MODULE_DRAW_OBJECT_MINE_
                define _CORE_MODULE_DRAW_OBJECT_MINE_
; -----------------------------------------
; обновление частицы
; In:
;   IX - адрес обрабатываемого объекта FObjectInteraction
; Out:
; Corrupt:
; Note:
; ----------------------------------------
DrawMine:       BIT VISIBLE_OBJECT_BIT, (IX + FObjectInteraction.Type)          ; проверка флаг видимости объекта
                RET Z                                                           ; выход, если объект невидим
                
                ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, (IX + FObjectInteraction.Position.X)
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции юнита по горизонтали
                LD HL, (IX + FObjectInteraction.Position.Y)
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции юнита по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                
                ; расчёт адреса спрайта
                LD A, (IX + FObjectInteraction.Subtype)
                ADD A, A
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ; чтение адреса спрайта
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

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

.Table          ; INTERACTION_MINE                                              ; 0x00
                DW SpriteInfo.Weapon.Mine

                include "Core/Module/Graphics/Weapon/Original/Info.inc"

                display " - Draw object 'MINE':\t\t\t\t", /A, DrawMine, " = busy [ ", /D, $ - DrawMine, " bytes  ]"

                endif ; ~_CORE_MODULE_DRAW_OBJECT_MINE_
