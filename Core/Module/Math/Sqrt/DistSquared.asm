
                ifndef _MATH_DISTANCE_SQUARED_
                define _MATH_DISTANCE_SQUARED_

                module Math
; -----------------------------------------
; расчёт квадрата расстояния
; In :
;   DE - дельта расстояния (D - y [-128..127], E - x [-128..127])
; Out :
;   HL - квадрат расстояния
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
DistSquared:    ; abs(dx)
                LD A, E
                OR A
                JP P, $+5
                NEG
                LD E, A

                ; abs(dy)
                LD A, D
                OR A
                JP P, $+5
                NEG
                LD D, A

                LD B, D
                LD C, #00
                
                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                LD A, E
                LD D, C
                CALL Math.Mul16x8_16
                PUSH HL

                LD A, B
                LD E, B
                LD D, C
                CALL Math.Mul16x8_16
                POP DE
                ADD HL, DE

                RET

                display " - Distance squared:\t\t\t\t", /A, DistSquared, " = busy [ ", /D, $ - DistSquared, " bytes  ]"

                endmodule

                endif ; ~_MATH_DISTANCE_SQUARED_
