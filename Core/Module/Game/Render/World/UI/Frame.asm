
                ifndef _MODULE_GAME_RENDER_UI_FRAME_
                define _MODULE_GAME_RENDER_UI_FRAME_
; -----------------------------------------
; отображение рамки вокруг миникарты
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
BackFrame:      LD A, Page.Graphics.Pack1
                CALL SetPage
                
                ; копирование спрайта в буфер общего назначения
                LD HL, Graphics.UI.Frame
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Frame.Size
                CALL Memcpy.FastLDIR

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; -----------------------------------------
                ; отрисовка спрайта с атрибутами
                ; In:
                ;   HL - адрес спрайта
                ; Out:
                ; Corrupt:
                ; Note:
                ;   данные о спрайте находятся в самом спрайте
                ; -----------------------------------------
                LD HL, SharedBuffer
                CALL Draw.AttrStencilSpr

                SET_SCREEN_BASE                                                 ; включение страницы основного экрана

                LD HL, SharedBuffer
                JP Draw.AttrStencilSpr

                endif ; ~_MODULE_GAME_RENDER_UI_FRAME_
