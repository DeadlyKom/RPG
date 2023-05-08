
                ifndef _CORE_MODULE_DRAW_STRING_
                define _CORE_MODULE_DRAW_STRING_
; -----------------------------------------
; отображение строки на экране
; In:
;   HL - адрес строки
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
DrawString:     
.CharLoop       ; проверка конца строки
                LD A, (HL)
                OR A
                RET Z

                SUB #20                                                         ; привести к виду хранения симыолов в памяти

                ; следующий символ
                INC HL
                PUSH HL
                PUSH DE

                CALL DrawChar

                ; смещение на ширину символа
                POP DE
                EX AF, AF'
                ADD A, E
                LD E, A

                POP HL
                JR .CharLoop

                display " - Draw string: \t\t\t\t\t", /A, DrawString, " = busy [ ", /D, $ - DrawString, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_STRING_
