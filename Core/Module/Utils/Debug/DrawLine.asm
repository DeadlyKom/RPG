
                ifndef _DRAW_LINE_
                define _DRAW_LINE_
; -----------------------------------------
; рисование линии
; In:
;   HL  - начальная точка   (H - y, L - x)
;   DE  - конечна точка     (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; -----------------------------------------
DrawLine:       ; инициализация
                LD BC, #141C                                                    ; #14 - INC D | #1C - INC E

                ; вычисляем dY = (Sy - Ey)
                LD A, H
                SUB D
                JR NC, .Line1

                INC B
                CPL
                INC A

.Line1          LD H, A                                                         ; H = dY
                
                ; вычисляем Dx = (Sx - Ex)
                LD A, L
                SUB E
                JR NC, .Line2

                INC C
                CPL
                INC A
                
.Line2          CP H                                                            ; dX < dY ?
                LD L, A                                                         ; L = dX
                JR C, .Line3                                                    ; если меньше то считаем основной координатой dY

                ; swap dX (L), dY (H)
                LD L, H
                LD H, A

                ; swap INC D/DEC D, INC E/DEC E
                LD A, B
                LD B, C
                LD C, A
                
.Line3          LD A, B                                                         ; обозначаем как менять координаты
                LD (.Line5), A
                LD A, C
                LD (.Line6), A
                LD B, H
                LD A, H
                INC L
                INC B

.Line4          ; BIT 1, B
                ; JR Z, .Line5

                PUSH DE
                EXX
                EX AF, AF'
                POP DE
                LD H, HIGH Adr.ScrAdrTable
                LD L, D
                LD A, (HL)
                INC H
                LD D, (HL)
                INC H
                LD L, E
                OR (HL)
                LD E, A
                INC H
                LD A, (DE)
                OR (HL)
                LD (DE), A
                EX AF, AF'
                EXX

.Line5          NOP                                                             ; INC/DEC D
                SUB L
                JR NC, .Line7

.Line6          NOP                                                             ; INC/DEC E
                ADD A, H
                
.Line7          DJNZ .Line4

                RET

                display " - DrawLine:\t\t\t[DEBUG]\t\t\t", /A, DrawLine, " = busy [ ", /D, $ - DrawLine, " bytes  ]"

                endif ; ~_DRAW_LINE_
