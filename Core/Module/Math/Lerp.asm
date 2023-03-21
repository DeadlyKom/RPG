

                ifndef _MATH_LERP_
                define _MATH_LERP_

                module Math
; -----------------------------------------
; interpolation between two 8-bit values (A, B) for the parameter (Alpha)
; result in the range [-128 .. 127]
; In :
;   BC - high byte is zero, low byte signed A [-128 .. 127]
;   HL - high byte is zero, low byte signed B [-128 .. 127]
;   A  - alpha values interval from 0 to 1 [0 .. 255]
; Out :
;   HL - product (HL - integer number)
; Corrupt :
;   HL, DE, AF
; Note:
;   A + Alpha * (B - A)
; -----------------------------------------
Lerp:           ; B - A
                OR A
                SBC HL, BC
                
                ; Alpha * (B - A)
                EX DE, HL
                CALL Math.Mul16x8_16

                ; HLA = HL >> 8
                LD L, H
                LD A, H
                ADD A, A
                SBC A, A
                LD H, A

                ; A + Alpha * (B - A)
                ADD HL, BC

                RET

                display " - Lerp : \t\t\t\t\t\t", /A, Lerp, " = busy [ ", /D, $ - Lerp, " bytes  ]"

                endmodule

                endif ; ~_MATH_LERP_
