
                ifndef _CORE_MODULE_DRAW_CHAR_
                define _CORE_MODULE_DRAW_CHAR_
; -----------------------------------------
; отображение символа на экране
; In:
;   HL - адрес символа
;   DE - координаты в пикселях (D - y, E - x)
;   B  - высота символа
;   A' - ширина символа
; Out:
; Corrupt:
;   B, HL', DE', BC', AF'
; Note:
;   ширина симвала не более 8 пикселей
; -----------------------------------------
DrawChar:       PUSH HL
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
