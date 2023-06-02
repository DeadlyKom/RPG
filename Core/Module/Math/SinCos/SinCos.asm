
                ifndef _MATH_SIN_COS_
                define _MATH_SIN_COS_

                module Math
; -----------------------------------------
; синус и косинус угла
; In :
;   A - угол 0-255
; Out :
;   DE - cos α
;   BC - sin α
; Corrupt :
;   HL, DE, BC, AF
; Note:
;   старший бит результата отвечает за знак
; -----------------------------------------
SinCos:         LD C, A
                CALL Sin

                LD A, C
                LD B, D
                LD C, E
; -----------------------------------------
; косинус угла
; In :
;   A - угол 0-255
; Out :
;   DE - cos α
; Corrupt :
;   HL, DE, AF
; Note:
;   http://retro.hansotten.nl/6502-sbc/lee-davison-web-site/sin-and-cos-calculator/
;   старший бит результата отвечает за знак
; -----------------------------------------
Cos:            ; cos α = sin(π * 0.5 - α)
                ADD A, #40

; -----------------------------------------
; синус угла
; In :
;   A - угол 0-255
; Out :
;   DE - sin α
; Corrupt :
;   HL, DE, AF
; Note:
;   старший бит результата отвечает за знак
; -----------------------------------------
Sin:            OR A
                JP P, .SinCos                                                   ; переход, если угол 0-π

                AND #7F                                                         ; сброс знака (α % π)
                CALL .SinCos

                SET 7, D                                                        ; установка знака

                RET
.SinCos         CP #41
                JR C, .Quadrant                                                 ; переход, если α > π

                ; α - π
                XOR #7F
                INC A

.Quadrant       ; расчёт адреса в таблице
                ADD A, A                                                        ; x2
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ; чтение из таблицы
                LD E, (HL)
                INC HL
                LD D, (HL)
                RET

.Table          DW #0000, #0324, #0647, #096A, #0C8B, #0FAB, #12C8, #15E2
                DW #18F8, #1C0B, #1F19, #2223, #2528, #2826, #2B1F, #2E11
                DW #30FB, #33DE, #36BE, #398C, #3C56, #3F17, #41CE, #447A
                DW #471C, #49B4, #4C3F, #4EBF, #5133, #539B, #55F5, #5842
                DW #5A82, #5CB4, #5ED7, #60EC, #62F2, #64EB, #66CF, #68A6
                DW #6A6D, #6C24, #6DC4, #6F5F, #70E2, #7255, #73B5, #7504
                DW #7641, #776C, #7884, #798A, #7A7D, #7B5D, #7C2A, #7CE3
                DW #7D8A, #7E1D, #7E9D, #7F09, #7F62, #7FA7, #7FD8, #7FF6
                DW #7FFF

                display " - Sin & Cos: \t\t\t\t\t", /A, Cos, " = busy [ ", /D,  $ - Cos, " bytes  ]"

                endmodule

                endif ; ~_MATH_SIN_COS_
