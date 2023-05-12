
                ifndef _CORE_MODULE_DRAW_CHAR_
                define _CORE_MODULE_DRAW_CHAR_
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
DrawChar:       PUSH DE

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
                ADD A, D
                LD D, A

; -----------------------------------------
; отображение символа на экране
; In:
;   HL - адрес спрайта символа
;   DE - координаты в пикселях (D - y, E - x)
;   B  - высота символа
;   A' - ширина символа
; Out:
; Corrupt:
;   B, HL', DE', BC', AF'
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
Draw:           PUSH HL
                PUSH DE
                EXX
                POP DE
                POP BC
                
                ; расчёт адреса экрана
                LD H, HIGH Adr.ScrAdrTable
                LD L, D
                LD A, (HL)
                INC H
                LD D, (HL)
                INC H
                LD L, E
                OR (HL)
                LD E, A
                RES 7, D                                                        ; всегда работаем только с основным экраном

                ; расчёт адреса таблицы смещения
                LD A, L
                AND %00000111
                JR Z, NotShift                                                  ; переход, если сдвиг отсутствует

                ; расчёт адреса таблицы, в зависимости от младших 3 бит
                DEC A
                ADD A, A
                ADD A, HIGH Adr.ShiftTable
                LD H, A

                ; флаг переполнения установлен, если символ не влезает
                LD A, L
                CPL
                AND %00000111
                LD L, A
                EX AF, AF'
                CP L
                EX AF, AF'
                ; H  - старший байт адреса таблицы сдвига
                ; DE - адрес экрана
                ; BC - адрес спрайта
                EXX
.DrawLoop       EXX
                
                ; отрисовка 1ой половинки
                LD A, (BC)
                INC BC
                LD L, A
                LD A, (DE)
                OR (HL)
                LD (DE), A

                ; проверка необходимости рисовать 2ю половинку
                EX AF, AF'
                JR C, .NextRow

                INC E

                ; отрисовка 2ой половинки
                EX AF, AF'
                INC H
                LD A, (DE)
                OR (HL)
                LD (DE), A
                DEC H
                EX AF, AF'

                DEC E

.NextRow        EX AF, AF'

                ; классический метод "DOWN DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+12
                LD A, E
                SUB #E0
                LD E, A
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                EXX
                DJNZ .DrawLoop

                RET
; -----------------------------------------
; отображение символа на экране (без сдвига)
; In:
;   DE - адрес экрана
;   BC - адрес спрайта
;   B' - высота символа
;   A' - ширина символа
; Out:
; Corrupt:
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
NotShift:       EXX
.DrawLoop       EXX
                LD A, (BC)
                INC BC
                LD (DE), A

                ; классический метод "DOWN DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+12
                LD A, E
                SUB #E0
                LD E, A
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                EXX
                DJNZ .DrawLoop
                
                RET

                display " - Draw char: \t\t\t\t\t", /A, DrawChar, " = busy [ ", /D, $ - DrawChar, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_CHAR_
