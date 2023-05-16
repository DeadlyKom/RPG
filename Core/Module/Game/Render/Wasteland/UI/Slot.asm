
                ifndef _MODULE_GAME_RENDER_UI_SLOT_
                define _MODULE_GAME_RENDER_UI_SLOT_
; -----------------------------------------
; отображение иконки в слоте
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Slot:           LD A, (PlayerState.Slot)

                ; расчёт адрес спрайта
                ADD A, A    ; x2
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ; чтение адреса
                LD E, (HL)
                INC HL
                LD D, (HL)
                PUSH DE
                
                ; установить страницу графики
                LD A, Page.Graphics.Pack1
                CALL SetPage

                ; распаковк графики  в буфер общего назначения
                POP HL
                LD DE, SharedBuffer
                CALL Decompressor.Forward

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; -----------------------------------------
                ; отрисовка спрайта с атрибутами
                ; In:
                ;   HL - адрес спрайта
                ;   DE - координаты в знакоместах (D - y, E - x)
                ;   BC - размер (B - y, C - x)
                ; Out:
                ; Corrupt:
                ; Note:
                ; -----------------------------------------
                LD HL, SharedBuffer
                LD DE, #1100
                LD BC, #0505
                JP Draw.AttrSprOne

.Table          DW Graphics.UI.None
                DW Graphics.UI.MachineGun
                DW Graphics.UI.Mine
                DW Graphics.UI.Rocket
                DW Graphics.UI.RepairKit

                endif ; ~_MODULE_GAME_RENDER_UI_SLOT_
