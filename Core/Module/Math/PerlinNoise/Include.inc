

                ifndef _MATH_PERLIN_NOISE_INCLUDE_
                define _MATH_PERLIN_NOISE_INCLUDE_

                module Math

PerlinNoise     EQU $

                include "IntNoise.asm"
                include "LerpNoise.asm"
                include "PerlinNoise.asm"

                ; внутренние переменные
Noise2D:        FNoise2D 0x18
LocationX:      FPNMultiply40
LocationY:      FPNMultiply40
IntNoiseData:   FLocation32

                display " - PerlinNoise: \t\t\t\t\t", /A, PerlinNoise, " = busy [ ", /D, $ - PerlinNoise, " bytes  ]"

                endmodule

                endif ; ~_MATH_PERLIN_NOISE_INCLUDE_
