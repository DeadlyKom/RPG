
                ifndef _CORE_MODULE_DRAW_STRING_
                define _CORE_MODULE_DRAW_STRING_
; -----------------------------------------
; отображение символа на экране
; In:
;   A  - ID символа (символ - 32)
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
DrawChar:       PUSH AF
                ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                POP AF
                CALL Packs.DrawChar

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage
; -----------------------------------------
; отображение строки на экране
; In:
;   HL - адрес строки
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, AF, AF'
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
DrawString:     ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта
                
                SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
.CharLoop       ; проверка конца строки
                LD A, (HL)
                OR A
                JR Z, .RET

                SUB #20                                                         ; привести к виду хранения симыолов в памяти

                ; следующий символ
                INC HL
                PUSH HL
                PUSH DE

                CALL Packs.DrawChar

                ; смещение на ширину символа
                POP DE
                EX AF, AF'
                ADD A, E
                LD E, A

                POP HL
                JR .CharLoop

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display " - Draw string: \t\t\t\t\t", /A, DrawString, " = busy [ ", /D, $ - DrawString, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_STRING_
