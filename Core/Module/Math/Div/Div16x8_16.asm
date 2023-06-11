
                ifndef _MATH_DIVISION_16_8_16_
                define _MATH_DIVISION_16_8_16_

                module Math
; -----------------------------------------
; деление HL на E
; In :
;   HL - делимое
;   E  - делитель
; Out :
;   L  - результат деления
;   H  - остаток
; Corrupt :
;   HL, B, AF
; Note:
;   https://www.smspower.org/Development/DivMod
; -----------------------------------------
Div16x8_16:     LD B, #08

.Loop           ADD HL, HL
                LD A, H
                JR C, $+5
                CP E
                JR C, $+5
                SUB E
                LD H, A
                INC L
                DJNZ .Loop

                RET

                display " - Divide 16x8 = 8.8:\t\t\t\t\t", /A, Div16x8_16, " = busy [ ", /D, $ - Div16x8_16, " bytes  ]"

                endmodule

                endif ; ~_MATH_DIVISION_16_8_16_
