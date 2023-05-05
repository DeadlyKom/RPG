
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

                ; расчёт адреса символа
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
                LD E, (HL)                                                      ; FFont.Size
                INC HL
                XOR A
                RRD
                LD D, A
                LD B, (HL)                                                      ; FFont.Offset + 0
                RLD
                INC HL
                LD C, (HL)                                                      ; FFont.Offset + 1
                ADD HL, BC

                ; -----------------------------------------
                ; D  - смещение по высоте
                ; E  - размер спрайта (высота/ширина)
                ; HL - адрес спрайта
                ; -----------------------------------------
                
                ; выделим высоту символа
                LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0F
                LD B, A

                ; сохраним ширину символа
                LD A, E
                AND #0F
                INC A
                EX AF, AF'

                ; добавить смещение по высоте
                LD A, D
                POP DE
                PUSH DE
                ADD A, D
                LD D, A

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
