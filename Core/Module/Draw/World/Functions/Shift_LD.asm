DE
                ifndef _CORE_MODULE_DRAW_WORLD_FUNCTION_SHIFT_LD_
                define _CORE_MODULE_DRAW_WORLD_FUNCTION_SHIFT_LD_

                module LD
Begin_Shift:    EQU $
; -----------------------------------------
; вывод спрайта со смещением
; In:
;   SP  - адрес спрайта
;   HL  - адрес экрана вывода
;   B   - количество строк в знакоместе
;   C   - количество отображаемых строк
; Out:
; Corrupt:
;   HL, DE, BC, AF, SP
; Note:
; -----------------------------------------
Shift_LD_Left:
._x_Xx          ; -0.5 байт
                ; прямой проход
                POP DE
                LD (HL), D
                INC L
                POP DE
                LD (HL), E

                ; обратный проход
                INC H
                LD (HL), D
                POP DE
                DEC L
                LD (HL), E
                JP NextRow

._xX_x          ; -1.5 байт
                ; прямой проход
                POP DE
                POP DE
                LD (HL), E
                ; обратный проход
                INC H
                LD (HL), D
                POP DE
                JP NextRow
Shift_LD_Right:
._xX_x          ; +0.5 байт
                ; прямой проход
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD (HL), D
                POP DE

                ; обратный проход
                INC H
                POP DE
                LD (HL), E
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A
                JP NextRow

._x_Xx          ; +1.5 байт
                ; прямой проход
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                POP DE

                ; обратный проход
                INC H
                POP DE
                LD A, (HL)
                OR D
                LD (HL), A
                JP NextRow
Shift_LD:       
._xXx           ; прямой проход
                POP DE
                LD A, (HL)
                OR E
                LD (HL), A
                INC L
                LD (HL), D
                INC L
                POP DE
                LD (HL), E

                ; обратный проход
                INC H
                LD (HL), D
                POP DE
                DEC L
                LD (HL), E
                DEC L
                LD A, (HL)
                OR D
                LD (HL), A
NextRow:        ; новая строка
                INC H
                DJNZ .NextRow
                LD B, #04
                LD A, L
                ADD A, #20
                LD L, A
                JR C, .NextBoundary
.ScreenAddress  EQU $+1
                LD H, #00                                                       ; восстановление старшего байта адреса экрана
                DEC C
                JR Z, Kernel.World.DrawColumn.Finish
                JP (IY)

.NextBoundary   ; сохранение старшего байта адреса экрана
                LD A, H
                LD (.ScreenAddress), A
.NextRow        DEC C
                JR Z, Kernel.World.DrawColumn.Finish
                JP (IY)
TableShift:
                DW Shift_LD_Left._xX_x                                          ; -1.5 байт
                DW Shift_LD_Left._x_Xx                                          ; -0.5 байт
.LD_16          DW Shift_LD._xXx                                                ;  2.0 байт
                DW Shift_LD_Right._xX_x                                         ; +0.5 байт
                DW Shift_LD_Right._x_Xx                                         ; +1.5 байт

                display " - Draw function 'Shift LD': \t\t\t\t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_WORLD_FUNCTION_SHIFT_LD_
