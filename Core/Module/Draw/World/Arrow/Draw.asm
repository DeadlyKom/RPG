                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_DRAW_
                define _CORE_MODULE_DRAW_WORLD_ARROW_DRAW_
; -----------------------------------------
; отрисовка стрелки (направление ближайшего врага)
; In:
;   HL - позиция по горизонтали (12.4)
;   DE - позиция по вертикали (12.4)
;   A' - номер фрейма [0..15]
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали
                LD (Draw.Prepare.PosY), DE                                      ; сохранение позиции по вертикали

                EX AF, AF'                                                      ; номер фрейма
                LD D, A

                ; FSprite { { 14, 7, 14, 7 }, 0, { Page.Graphics.Pack1, Graphics.Arrow.Anim_0 } }
                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD A, -7
                LD (Draw.Prepare.SOx), A
                LD (Draw.Prepare.SOy), A
                LD HL, #0E0E
                LD (Draw.Prepare.Size), HL
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

                ; -----------------------------------------
                ; HL = A x 56
                ; -----------------------------------------
                LD H, #00
                LD A, D     ; A = Ax8
                ADD A, A    ; x16
                LD E, A     ; E = x16
                ADD A, A    ; x32
                RL H        ; HL = Ax32
                
                ; HL = Ax32 + Ax16
                ADD A, E
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; HL = Ax32 + Ax16 + Ax8
                LD A, L
                ADD A, D
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; HL = 0 фрейм + A x 56
                LD A, L
                ADD A, LOW Graphics.Arrow.Anim
                LD L, A
                ADC A, H
                ADD A, HIGH Graphics.Arrow.Anim
                SUB L
                LD H, A

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_DRAW_
