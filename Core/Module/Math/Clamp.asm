

                ifndef _MATH_CLAMP_
                define _MATH_CLAMP_

                module Math
; -----------------------------------------
; clamp значения
; In :
;   A - значение
;   D - минимальное значение
;   E - максимальное значение
; Out :
;   A - (A < D) ? D : ((A > E) ? E : A)
; Corrupt :
; Note:
; -----------------------------------------
Clamp:          CP D
                JR NC, .Max
                LD A, D
                RET

.Max            DEC A
                CP E
                INC A
                RET C
                LD A, E
                RET

                display " - Clamp:\t\t\t\t\t\t", /A, Clamp, " = busy [ ", /D, $ - Clamp, " bytes  ]"

                endmodule

                endif ; ~_MATH_CLAMP_
