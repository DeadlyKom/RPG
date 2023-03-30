

                ifndef _MATH_PERLIN_NOISE_INCLUDE_
                define _MATH_PERLIN_NOISE_INCLUDE_

                module Math
PerlinNoise     EQU $

                include "IntNoise.asm"
                include "LerpNoise.asm"
                include "PerlinNoise.asm"

                ; внутренние переменные
Noise2D:        FNoise2D
LocationX:      FPNInt40
LocationY:      FPNInt40
IntNoiseData:   FLocation32

                if (Noise2D >> 8) - ($ >> 8)
                error "whole table must be within single 256 byte block"
                endif

                display " - PerlinNoise: \t\t\t\t\t", /A, PerlinNoise, " = busy [ ", /D, $ - PerlinNoise, " bytes  ]"

                endmodule

                endif ; ~_MATH_PERLIN_NOISE_INCLUDE_
