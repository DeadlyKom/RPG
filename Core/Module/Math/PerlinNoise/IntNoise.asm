

                ifndef _MATH_PERLIN_NOISE_INT_NOISE_FUNC_
                define _MATH_PERLIN_NOISE_INT_NOISE_FUNC_
; -----------------------------------------
; функция целочисленного шума выводит псевдослучайное
; значение при заданном n-мерном входном значении
; In :
;   IntNoiseData.Int - 32-битное смещение по оси X
;   IntNoiseData.Int - 32-битное смещение по оси Y
; Out :
;   HL - PRNG апределах [-128 .. 127]
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
IntegerNoise:   LD B, HIGH Adr.PRNG
                LD HL, IntNoiseData
                LD C, (HL)

                rept 8 
                LD A, (BC)
                INC HL
                ADD A, (HL)
                LD C, A
                endr

                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                
                RET

                endif ; ~_MATH_PERLIN_NOISE_INT_NOISE_FUNC_
