
                ifndef _MATH_PERLIN_NOISE_2D_FUNC_
                define _MATH_PERLIN_NOISE_2D_FUNC_
; -----------------------------------------
; noise generation
; In :
;   FNoise2D.Frequency - range [0 .. 255]
;   FNoise2D.Location  - 32-bit values of the offset axes
; Out :
;   HL - noise range [-128 .. 127]
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
PerlinNoise2D:
; .XY             ; AHLDE = Location.X * Frequency
;                 LD DE, (Noise2D + FNoise2D.Location.X.High)
;                 LD HL, (Noise2D + FNoise2D.Location.X.Low)
;                 LD A, (Noise2D + FNoise2D.Frequency)
;                 CALL Math.Mul32x8_40                                            ; AHLDE
                
;                 ; сохранение результата FPNInt40
;                 LD (LocationX + FPNInt40.Int.High - 1), HL
;                 LD (LocationX + FPNInt40.Int.Low  - 1), DE
;                 LD (LocationX + FPNInt40.Int.High + 1), A

.Y              ; AHLDE = Location.Y * Frequency
                LD DE, (Noise2D + FNoise2D.Location.Y.High)
                LD HL, (Noise2D + FNoise2D.Location.Y.Low)
                LD A, (Noise2D + FNoise2D.Frequency)
                CALL Math.Mul32x8_40                                            ; AHLDE

                ; сохранение результата FPNInt40
                LD (LocationY + FPNInt40.Int.High - 1), HL
                LD (LocationY + FPNInt40.Int.Low  - 1), DE
                LD (LocationY + FPNInt40.Int.High + 1), A

                JP LerpNoise

.X              ; AHLDE = Location.X * Frequency
                LD DE, (Noise2D + FNoise2D.Location.X.High)
                LD HL, (Noise2D + FNoise2D.Location.X.Low)
                LD A, (Noise2D + FNoise2D.Frequency)
                CALL Math.Mul32x8_40                                            ; AHLDE
                
                ; сохранение результата FPNInt40
                LD (LocationX + FPNInt40.Int.High - 1), HL
                LD (LocationX + FPNInt40.Int.Low  - 1), DE
                LD (LocationX + FPNInt40.Int.High + 1), A

                JP LerpNoise

.X_             LD A, (Noise2D + FNoise2D.Frequency)
                CALL Math.Mul32x8_40                                            ; AHLDE
                
                ; сохранение результата FPNInt40
                LD (LocationX + FPNInt40.Int.High - 1), HL
                LD (LocationX + FPNInt40.Int.Low  - 1), DE
                LD (LocationX + FPNInt40.Int.High + 1), A
                RET

.Y_             LD A, (Noise2D + FNoise2D.Frequency)
                CALL Math.Mul32x8_40                                            ; AHLDE

                ; сохранение результата FPNInt40
                LD (LocationY + FPNInt40.Int.High - 1), HL
                LD (LocationY + FPNInt40.Int.Low  - 1), DE
                LD (LocationY + FPNInt40.Int.High + 1), A
                RET

                endif ; ~_MATH_PERLIN_NOISE_2D_FUNC_
