
                ifndef _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_LD_
                define _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_LD_

                module LD
Begin_NoShift:  EQU $
; -----------------------------------------
; вывод спрайта со смещением
; In:
;   SP  - адрес спрайта
;   HL  - адрес экрана вывода
;   B   - количество строк в знакоместе
;   C   - копия старшего байта адреса экрана вывода
; Out:
; Corrupt:
;   HL, DE, BC, F, SP
; Note:
; -----------------------------------------
NoShift_LD_Left:
._X_X           ; -1.0 байт
                ; прямой проход
                POP DE
                LD (HL), D

                ; обратный проход
                INC H
                POP DE
                LD (HL), D
                JR NextRow
NoShift_LD_Right:
._X_X           ; +1.0 байт
                ; прямой проход
                POP DE
                LD (HL), E

                ; обратный проход
                INC H
                POP DE
                LD (HL), E
                JR NextRow
NoShift_LD:     ; 2.0 байт
._XX            ; прямой проход
                POP DE
                LD (HL), E
                INC L
                LD (HL), D

                ; обратный проход
                INC H
                POP DE
                LD (HL), D
                DEC L
                LD (HL), E
                JR NextRow
TableNoShift:
                DW NoShift_LD_Left._X_X                                         ; -1.0
.LD_16          DW NoShift_LD._XX                                               ;  2.0
                DW NoShift_LD_Right._X_X                                        ; +1.0

                display " - Draw function 'No Shift LD': \t\t\t", /A, Begin_NoShift, " = busy [ ", /D, $ - Begin_NoShift, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_LD_
