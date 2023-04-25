
                ifndef _MODULE_GAME_RENDER_UI_ICONS_
                define _MODULE_GAME_RENDER_UI_ICONS_
; -----------------------------------------
; отображение иконки сердца
; In:
;   A - номер спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Heart:          ; стартовый адрес спрайта
                OR A
                LD HL, Graphics.UI.Heart._0
                JR Z, $+5
                LD HL, Graphics.UI.Heart._1 
                ; установить страницу графики
                LD A, Page.Graphics.Pack1
                CALL SetPage
                
                ; копирование спрайта в буфер общего назначения
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Heart.Size
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
                LD DE, #0801
                LD BC, #0101
                JP Draw.AttrSprTwo
; -----------------------------------------
; отображение иконци бензина
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gas:            ; установить страницу графики
                LD A, Page.Graphics.Pack1
                CALL SetPage
                
                ; копирование спрайта в буфер общего назначения
                LD HL, Graphics.UI.Gas
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Gas.Size
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
                LD DE, #0802
                LD BC, #0101
                JP Draw.AttrSprTwo
; -----------------------------------------
; отображение иконки турбонаддува
; In:
;   A - номер спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Turbo:          ; стартовый адрес спрайта
                OR A
                LD HL, Graphics.UI.Turbo._0
                JR Z, $+5
                LD HL, Graphics.UI.Turbo._1 
                ; установить страницу графики
                LD A, Page.Graphics.Pack1
                CALL SetPage
                
                ; копирование спрайта в буфер общего назначения
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Turbo.Size
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
                LD DE, #0803
                LD BC, #0101
                JP Draw.AttrSprTwo

                endif ; ~_MODULE_GAME_RENDER_UI_ICONS_
