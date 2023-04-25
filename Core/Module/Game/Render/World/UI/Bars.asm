
                ifndef _MODULE_GAME_RENDER_UI_BAR_
                define _MODULE_GAME_RENDER_UI_BAR_
; -----------------------------------------
; отображение баров
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
BackBar:        LD A, Page.Graphics.Pack1
                CALL SetPage
                
                ; копирование спрайта в буфер общего назначения
                LD HL, Graphics.UI.Bar
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Bar.Size
                CALL Memcpy.FastLDIR

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
                LD DE, #0201
                LD BC, #0603
                CALL Draw.AttrSprTwo

                RET

                endif ; ~_MODULE_GAME_RENDER_UI_BAR_
