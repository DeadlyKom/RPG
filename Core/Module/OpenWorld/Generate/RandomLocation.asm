
                ifndef _CORE_MODULE_OPEN_WORLD_RANDOM_LOCATION_
                define _CORE_MODULE_OPEN_WORLD_RANDOM_LOCATION_
; -----------------------------------------
; рандомизация положения в мире
; In:
;   IX - адрес структуры FRegion
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RandLocation:   ; угол поворота (спираль)
                CALL Math.Rand8

                ; -----------------------------------------
                ; In :
                ;   A - угол 0-255
                ; Out :
                ;   DE - cos α (старший бит отвечает за знак)
                ;   BC - sin α (старший бит отвечает за знак)
                ; Note:
                ; -----------------------------------------
                CALL Math.SinCos

                ; x = Radius * cos α
                CALL .Mult
                PUSH HL

                ; y = Radius * sin α
                LD D, B
                LD E, C
                CALL .Mult

                ; HLDE = Center.Y + Radius * sin α
                LD A, H
                ADD A, A
                SBC A, A
                LD B, A
                LD C, A
                LD DE, (IY + FGenerateWorld.Center.Y.Low)
                ADD HL, DE
                EX DE, HL
                LD HL, (IY + FGenerateWorld.Center.Y.High)
                ADD HL, BC

                ; сохранение позиции региона по вертикали
                LD (IX + FRegion.Location.Y.Low), DE
                LD (IX + FRegion.Location.Y.High), HL

                ; HLDE = Center.X + Radius * sin α
                POP HL
                LD A, H
                ADD A, A
                SBC A, A
                LD B, A
                LD C, A
                LD DE, (IY + FGenerateWorld.Center.X.Low)
                ADD HL, DE
                EX DE, HL
                LD HL, (IY + FGenerateWorld.Center.X.High)
                ADD HL, BC

                ; сохранение позиции региона по горизонтали
                LD (IX + FRegion.Location.X.Low), DE
                LD (IX + FRegion.Location.X.High), HL

                RET

.Mult           ; избавится от знака
                SLA E
                RL D
                JR NC, .MultRadius                                              ; переход, если знака положительный

                ; знак отрицательный
                CALL .MultRadius

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                RET

.MultRadius     ; умножение на радиус
                LD A, (IX + FRegion.InfluenceRadius)
                AND VORONOI_DIAGRAM_RADIUS
                ADD A, VORONOI_DIAGRAM_RADIUS_MIN
                
                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   AHL - product DE * A
                ; Corrupt :
                ;   HL, AF
                ; -----------------------------------------
                CALL Math.Mul16x8_24
                LD L, H
                LD H, A
                RET

                display "\t- Random location:\t\t\t\t", /A, RandLocation, " = busy [ ", /D, $ - RandLocation, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_W_CORE_MODULE_OPEN_WORLD_RANDOM_LOCATION_ORLD_INITIALIZE_
