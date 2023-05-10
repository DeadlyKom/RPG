
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
ROW_TIME        EQU 22
WIDTH_TIME      EQU 6
COLUMN_TIME     EQU WIDTH_TIME >> 1
; -----------------------------------------
; отображение текущего времени
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayTime:    LD DE, (ROW_TIME * 8) << 8
                LD HL, .ClearText
                CALL Packs.DrawString

                LD IX, PlayerState.GameTime
                LD HL, Adr.RenderBuffer + 0x80
                PUSH HL

                ; часы
                LD C, (IX + FTime.Hour)
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
                LD A, (IX + FTime.Interrupt)
                CP 25
                LD (HL), #BF
                JR C, $+4
                LD (HL), ':'
                INC L

                ; минуты
                LD C, (IX + FTime.Minutes)
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
                CALL Packs.DrawString

                RET
.ClearText      BYTE "^^^^^^\0"

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_TIME_
