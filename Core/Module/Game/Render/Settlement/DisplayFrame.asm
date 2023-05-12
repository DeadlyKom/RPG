
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_FRAME_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_FRAME_
COLUMN_FRAME    EQU 0
ROW_FRAME       EQU 16
; -----------------------------------------
; отображение рамки
; In:
;   IX - указывает на структуру FSettlement
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayFrame:   SET_PAGE_GRAPHICS_1                                             ; включить страницу графики

                ; распаковка текста
                LD HL, Graphics.UI.Settlement.Frame
                LD DE, Adr.SortBuffer
                CALL Decompressor.Forward
                
                SET_SCREEN_BASE                                                 ; включение страницы основного экрана

                ; -----------------------------------------
                ; отрисовка спрайта с атрибутами
                ; In:
                ;   HL - адрес спрайта
                ;   DE - координаты в знакоместах (D - y, E - x)
                ;   BC - размер (B - y, C - x)
                ; Out:
                ; Corrupt:
                ; Note:
                ;   данные о спрайте находятся в самом спрайте
                ; -----------------------------------------
                LD HL, Adr.SortBuffer
                LD DE, (ROW_FRAME << 8) | COLUMN_FRAME
                LD BC, #0606
                JP Draw.AttrSprOne

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_FRAME_
