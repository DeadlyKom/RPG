
                ifndef _MATH_SUBTRACTION_INTEGER_32_32_
                define _MATH_SUBTRACTION_INTEGER_32_32_

                module Math
; -----------------------------------------
; вычитание 32-битных чисел
; In :
;   HLHL' - 32-битное уменьшаемое число
;   DEDE' - 32-битное вычитаемое число
; Out :
;   DEHL  -  разность 32-битных чисел
; Corrupt :
;   F
; Note:
; -----------------------------------------
Sub32_32:       EXX
                OR A
                SBC HL, DE
                PUSH HL
                EXX
                SBC HL, DE
                POP DE
                EX DE, HL

                RET

                display " - Subtraction 32: \t\t\t\t\t", /A, Sub32_32, " = busy [ ", /D, $ - Sub32_32, " bytes  ]"

                endmodule

                endif ; ~_MATH_SUBTRACTION_INTEGER_32_32_
