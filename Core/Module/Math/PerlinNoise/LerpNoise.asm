
                ifndef _MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
                define _MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
; -----------------------------------------
; линейная интерполяция шума между соседними значениями шума
; In :
;   LocationX.Int  - 32-битное смещение по оси X
;   LocationX.Byte - 8-битная дробная часть по оси X (альфа)
;   LocationY.Int  - 32-битное смещение по оси Y
;   LocationX.Byte - 8-битная дробная часть по оси Y (альфа)
; Out :
;   HL - линейная интерполяция шума в пределах [-128 .. 127]
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
LerpNoise:      ; v1 = (x, y)
                LD HL, (LocationX + FPNMultiply40.Int.Low)
                LD (IntNoiseData + FLocation32.X.Low), HL
                LD HL, (LocationX + FPNMultiply40.Int.High)
                LD (IntNoiseData + FLocation32.X.High), HL

                LD HL, (LocationY + FPNMultiply40.Int.Low)
                LD (IntNoiseData + FLocation32.Y.Low), HL
                LD HL, (LocationY + FPNMultiply40.Int.High)
                LD (IntNoiseData + FLocation32.Y.High), HL

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v2 = (x + 1, y)
                LD HL, IntNoiseData + FLocation32.X.Low
                INC (HL)
                JR NZ, $+12
                INC HL
                INC (HL)
                JR NZ, $+8
                INC HL
                INC (HL)
                JR NZ, $+4
                INC HL
                INC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v4 = (x + 1, y + 1)
                LD HL, IntNoiseData + FLocation32.Y.Low
                INC (HL)
                JR NZ, $+12
                INC HL
                INC (HL)
                JR NZ, $+8
                INC HL
                INC (HL)
                JR NZ, $+4
                INC HL
                INC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v3 = (x, y + 1)
                LD HL, IntNoiseData + FLocation32.X.Low
                DEC (HL)
                JR NZ, $+12
                INC HL
                DEC (HL)
                JR NZ, $+8
                INC HL
                DEC (HL)
                JR NZ, $+4
                INC HL
                DEC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; i2 = Lerp(v3, v4, FractionalX)
                LD A, (LocationX + FPNMultiply40.Byte)  ; FractionalX
                POP BC              ; A = v3
                POP HL              ; B = v4
                CALL Math.Lerp
                LD (.Int2), HL

                ; i1 = Lerp(v1, v2, FractionalX)
                LD A, (LocationX + FPNMultiply40.Byte)  ; FractionalX
                POP HL              ; B = v2
                POP BC              ; A = v1
                CALL Math.Lerp

                ; HL = Lerp(i1, i2, FractionalY)
                LD A, (LocationY + FPNMultiply40.Byte)  ; FractionalY
                LD B, H
                LD C, L             ; A = i1
.Int2           EQU $+1
                LD HL, #0000        ; B = i2
                JP Math.Lerp

                endif ; ~_MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
