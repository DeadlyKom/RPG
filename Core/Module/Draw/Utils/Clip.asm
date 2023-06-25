
                ifndef _CORE_MODULE_DRAW_UTILS_CLIPPING_
                define _CORE_MODULE_DRAW_UTILS_CLIPPING_

                module Utils
; -----------------------------------------
; установка отсечения видимой области
; In:
;   D - нижняя граница вывода спрайтов  (в знакоместах)
;   E - верхняя граница вывода спрайтов (в знакоместах)
;   B - правая граница вывода спрайтов  (в знакоместах)
;   C - левая граница вывода спрайтов   (в знакоместах)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetClipRect:    LD HL, GameConfig.UpEdgeChar
                LD (HL), E
                INC L
                LD (HL), D
                INC L
                LD (HL), C
                INC L
                LD (HL), B
                
                RET

; ToDo мб добавить функции для сохранения в стек значений клипа и восстановления их

                display " - Clipping functions: \t\t\t\t", /A, SetClipRect, " = busy [ ", /D, $ - SetClipRect, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_UTILS_CLIPPING_
