
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_ART_FRAME_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_ART_FRAME_
; -----------------------------------------
; отображение рамки для арта
; In:
;   IX - указывает на структуру FSettlement
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayArtFrame ;
                LD HL, Graphics.UI.Settlement.ArtFrame_0
                CALL .Draw
                LD HL, Graphics.UI.Settlement.ArtFrame_1

.Draw           SET_PAGE_GRAPHICS_1                                             ; включить страницу графики

                ; распаковка часть рамки в буфер
                LD DE, Adr.SortBuffer
                CALL Decompressor.Forward

                ; ограничение спрайта
                XOR A
                INC DE
                INC DE
                LD (DE), A
                INC DE
                LD (DE), A

                SET_SCREEN_BASE                                                 ; включение страницы основного экрана

                ; отображение часть рамки в основной экран
                LD HL, Adr.SortBuffer
                JP Draw.AttrStencilSpr

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_ART_FRAME_
