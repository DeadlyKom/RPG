

                ifndef _MATH_PERLIN_NOISE_INCLUDE_
                define _MATH_PERLIN_NOISE_INCLUDE_

                module Math

                struct FPNInt32
.Low            DW #0000
.High           DW #0000
                ends

                struct FPNLocation
.X              FPNInt32 0x0000, 0x0000
.Y              FPNInt32 0x0000, 0x0000
                ends

                struct FPNMultiply40
.Byte           DB #00
.Int            FPNInt32
                ends

                struct FNoise2D
.Frequency      DB #00
.Location       FPNLocation 0x0000, 0x0000
                ends

PerlinNoise     EQU $

                include "IntNoise.asm"
                include "LerpNoise.asm"
                include "PerlinNoise.asm"

                ; внутренние переменные
Noise2D:        FNoise2D 0x18
LocationX:      FPNMultiply40
LocationY:      FPNMultiply40
IntNoiseData:   FPNLocation

                display " - PerlinNoise: \t\t\t\t\t", /A, PerlinNoise, " = busy [ ", /D, $ - PerlinNoise, " bytes  ]"

                endmodule

                endif ; ~_MATH_PERLIN_NOISE_INCLUDE_
