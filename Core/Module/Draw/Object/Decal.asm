
                ifndef _CORE_MODULE_DRAW_OBJECT_DECAL_
                define _CORE_MODULE_DRAW_OBJECT_DECAL_
; -----------------------------------------
; отображение дроид-пехотинца
; In:
;   IX - указывает на структуру FObjectDecal
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawDecal:      BIT VISIBLE_OBJECT_BIT, (IX + FObjectDecal.Type)                ; проверка флаг видимости объекта
                RET Z                                                           ; выход, если объект невидим

                ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, (IX + FObjectDecal.Position.X)
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали
                LD HL, (IX + FObjectDecal.Position.Y)
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали

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
                CALL Utils.SpriteParse

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
