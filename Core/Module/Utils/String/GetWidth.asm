
                ifndef _CORE_MODULE_UTILS_GET_WIDTH_STRING_
                define _CORE_MODULE_UTILS_GET_WIDTH_STRING_
; -----------------------------------------
; ширина строки в пикселях
; In:
;   DE - адрес строки
; Out:
;   A' - ширина строки
; Corrupt:
; Note:
;   необходимо включить страницу с графиуой шрифтов
; -----------------------------------------
GetWidth:       XOR A
                EX AF, AF'

.CharLoop       ; проверка конца строки
                LD A, (DE)
                OR A
                RET Z

                ; следующий символ
                INC DE

                ; расчёт адреса символа
                SUB #20                                                         ; привести к виду хранения симыолов в памяти
                LD C, A
                LD B, #00
                LD L, A
                LD H, B
                ADD HL, HL  ; x2
                ADD HL, BC  ; x3
                LD A, H
                OR HIGH Adr.Font
                LD H, A

                ; чтение данных о символе
                LD A, (HL)                                                      ; FFont.Size - размер спрайта (высота/ширина)
                AND #0F
                INC A
                LD C, A
                EX AF, AF'
                ADD A, C
                EX AF, AF'

                JR .CharLoop

                endif ; ~_CORE_MODULE_UTILS_GET_WIDTH_STRING_
