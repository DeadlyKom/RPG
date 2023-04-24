                ifndef _CORE_MODULE_DRAW_WORLD_DRAW_ARROW__
                define _CORE_MODULE_DRAW_WORLD_DRAW_ARROW__
; -----------------------------------------
; отрисовка стрелки (направление ближайшего врага)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, #0800
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции юнита по горизонтали
                LD HL, #0600
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции юнита по вертикали

                ; FSprite { { 14, 7, 14, 7 }, 0, { Page.Graphics.Pack1, Graphics.Arrow.Anim_0 } }
                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD A, -7
                LD (Draw.Prepare.SOx), A
                LD (Draw.Prepare.SOy), A
                LD DE, #0E0E
                LD (Draw.Prepare.Size), DE
                XOR A
                LD (GameConfig.SpriteOffsetRef), A
                LD A, Page.Graphics.Pack1
                LD E, CSIF_OR_XOR << 1
                ADD A, A
                RR E
                RRA
                CALL SetPage
                LD A, E
                LD (GameConfig.SpriteFlagRef), A
                LD HL, Graphics.Arrow.Anim_0

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                endif ; ~ _CORE_MODULE_DRAW_WORLD_DRAW_ARROW__
