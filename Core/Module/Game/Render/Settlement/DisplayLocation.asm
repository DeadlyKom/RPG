
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_LOCATION_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_LOCATION_
HEADER_INDENT   EQU 6
COLUMN_HEADER   EQU 32 - HEADER_INDENT
ROW_HEADER      EQU 16
; -----------------------------------------
; отображение место нахождения игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayLoc:     SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; получение места нахождения игрока
                LD A, (PlayerState.SettlementLocation)
                LD HL, Packs.BuildText
                CALL Utils.GetStringID

                LD DE, Adr.RenderBuffer + 0x80
                PUSH DE
                CALL Utils.Strcpy
                DEC E
                EX DE, HL
                LD (HL), ':'
                INC L
                LD (HL), ' '
                INC L
            
                ; получение имени поселения
                CALL Packs.OpenWorld.Utils.GetSettleName

                SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода

                ; выравнивание строки
                POP DE
                CALL Utils.GetWidth                                             ; длина полученной строки
                EX AF, AF
                LD C, A
                LD A, COLUMN_HEADER * 8
                SUB C
                SRL A
                ADD A, HEADER_INDENT * 8
                LD E, A
                LD D, ROW_HEADER * 8
                
                LD HL, Adr.RenderBuffer + 0x80
                CALL Packs.DrawString
                
                RET

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_LOCATION_
