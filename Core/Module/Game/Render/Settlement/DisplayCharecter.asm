
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_CHARECTER_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_CHARECTER_
COLUMN_CHAR     EQU 1
ROW_CHAR        EQU 17
; -----------------------------------------
; отображение рамки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayChar:    SET_PAGE_GRAPHICS_1                                             ; включить страницу графики

                ; распаковка текста
                LD HL, Graphics.UI.Charecter._4
                LD DE, Adr.SortBuffer
                CALL Decompressor.Forward
                
                SET_SCREEN_BASE                                                 ; включение страницы основного экрана

                ; хлопанье глазами
                LD A, (GameState.CharacterState)
                RLCA
                RLCA
                AND CHAR_FRAME_MASK
                LD HL, Adr.SortBuffer - (4 * 4 * 9)
                LD DE, 4 * 4 * 9
                INC A
                LD B, A
.Loop           ADD HL, DE
                DJNZ .Loop

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
                LD DE, (ROW_CHAR << 8) | COLUMN_CHAR
                LD BC, #0404
                JP Draw.AttrSprOne

.OldTime        DB #00

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_CHARECTER_
