
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
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали
                LD HL, (IX + FObjectInteraction.Position.Y)
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали

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
                CALL Utils.SpriteParse
                
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
