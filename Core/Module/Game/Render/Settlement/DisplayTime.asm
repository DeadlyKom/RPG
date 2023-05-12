
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
ROW_TIME        EQU 22
WIDTH_TIME      EQU 6
COLUMN_TIME     EQU WIDTH_TIME >> 1
; -----------------------------------------
; отображение текущего времени
; In:
;   IX - указывает на структуру FSettlement
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayTime:    ; SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода

                LD DE, (ROW_TIME * 8) << 8
                LD HL, .ClearText
                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.String

                LD IY, PlayerState.GameTime
                LD HL, Adr.RenderBuffer + 0x80
                PUSH HL

                ; часы
                LD C, (IY + FTime.Hour)
                LD A, C
                AND #F0
                JR Z, .SkipFirst
                RRCA
                RRCA
                RRCA
                RRCA
                ADD A, '0'
                LD (HL), A
                INC L

.SkipFirst      LD A, C
                AND #0F
                ADD A, '0'
                LD (HL), A
                INC L

                ; секунды
                LD A, (IY + FTime.Interrupt)
                CP 25
                LD (HL), #BF
                JR C, $+4
                LD (HL), ':'
                INC L

                ; минуты
                LD C, (IY + FTime.Minutes)
                LD A, C
                AND #F0
                RRCA
                RRCA
                RRCA
                RRCA
                ADD A, '0'
                LD (HL), A
                INC L

                LD A, C
                AND #0F
                ADD A, '0'
                LD (HL), A
                INC L
                LD (HL), #00

                SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода

                ; выравнивание строки
                POP DE
                CALL Utils.GetWidth                                             ; длина полученной строки
                EX AF, AF
                SRL A
                LD C, A
                LD A, COLUMN_TIME * 8
                SUB C
                LD E, A
                LD D, ROW_TIME * 8

                LD HL, Adr.RenderBuffer + 0x80

                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                JP Draw.String
.ClearText      BYTE "^^^^^^\0"

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
