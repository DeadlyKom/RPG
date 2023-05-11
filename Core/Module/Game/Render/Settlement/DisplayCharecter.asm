
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

                ; расчёт адреса отображаемого персонажа
                LD A, (GameState.CharacterID)
                ADD A, A    ; x2
                ADD A, LOW .CharacterTable
                LD L, A
                ADC A, HIGH .CharacterTable
                SUB L
                LD H, A

                ; чтение адреса расположения спрайта
                LD E, (HL)
                INC HL
                LD D, (HL)

                ; распаковка текста
                LD HL, Adr.SortBuffer
                EX DE, HL
                CALL Decompressor.Forward
                
                SET_SCREEN_BASE                                                 ; включение страницы основного экрана

                ; проверка наличие персонажа
                LD A, (GameState.CharacterState)
                AND CHAR_STATE_MASK
                CP CHAR_STATE_NONE
                JR Z, StateNone

                ; расчёт адрес фрейма
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
.CharacterTable DW Graphics.UI.Charecter._0
                DW Graphics.UI.Charecter._1
                DW Graphics.UI.Charecter._2
                DW Graphics.UI.Charecter._3
                DW Graphics.UI.Charecter._4

StateNone:      LD A, (GameState.CharacterState)
                RLCA
                RLCA
                AND CHAR_FRAME_MASK
                LD HL, #2513 - (4 * 4 * 8)
                LD DE, 4 * 4 * 8
                INC A
                LD B, A
.Loop           ADD HL, DE
                DJNZ .Loop

                LD DE, (ROW_CHAR << 8) | COLUMN_CHAR
                LD BC, #0404
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
                CALL Convert.CharToScreen
    
.Box_0          PUSH DE
                PUSH BC
                LD B, C

.Box_1          PUSH DE

                CALL Draw.CharOne

                INC HL
                POP DE
                INC E
                DJNZ .Box_1
                POP BC
                POP DE

                ; DOWN DE
                LD A, E
                ADD A, #20
                LD E, A
                JR NC, .Box_2
                LD A, D
                ADD A, #08
                LD D, A

.Box_2          DJNZ .Box_0
                RET

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_CHARECTER_
