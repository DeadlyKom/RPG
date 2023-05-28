
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_SHUFFLE_COORDINATES_
                define _CORE_MODULE_OPEN_WORLD_UTILS_SHUFFLE_COORDINATES_
; -----------------------------------------
; перемешать координаты
; In:
;   IX   - указывает на структуру FSettlement
; Out:
;   DEHL - перемешанные значение
; Corrupt:
; Note:
; -----------------------------------------
ShuffleCoord:   ; смешивание координат осей поселения

                ; coordy += coordx
                LD HL, (IX + FSettlement.Location.Y.Low)
                LD BC, (IX + FSettlement.Location.X.Low)
                ADD HL, BC
                PUSH HL
                PUSH HL
                LD HL, (IX + FSettlement.Location.Y.High)
                LD BC, (IX + FSettlement.Location.X.High)
                ADC HL, BC
                LD B, H
                LD C, L
                EX (SP), HL
                PUSH HL
                PUSH BC

                ; coordx = _rotl(coordx, 3)
                LD HL, (IX + FSettlement.Location.X.Low)
                LD DE, (IX + FSettlement.Location.X.High)

                LD B, #03
                CALL RotateLeft.Loop

                ; coordx += coordy
                POP BC
                ADD HL, BC
                LD (.x_l), HL
                POP BC
                ADC HL, BC
                LD (.x_h), HL

                ; coordy = _rotl(coordy, 5)
                POP BC
                POP DE
                LD B, #05
                CALL RotateLeft.Loop

                ; coordy += coordx
.x_l            EQU $+1
                LD BC, #0000
                ADD HL, BC
                EX DE, HL
.x_h            EQU $+1
                LD BC, #0000
                ADC HL, BC
                EX DE, HL

                ; coordy = _rotl(coordy, 4)
                LD B, #04
                CALL RotateLeft
                PUSH DE
                PUSH HL

                ; coordx = _rotl(coordx, Sysnum)
                CALL Math.Rand8
                LD C, A
                RRCA
                RRCA
                RRCA
                RRCA
                XOR C
                INC A
                AND #07
                LD B, A

                LD HL, (.x_l)
                LD DE, (.x_h)
                CALL RotateLeft

                ; coordx += coordy
                POP BC
                ADD HL, BC
                EX DE, HL
                POP BC
                ADC HL, BC

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_SHUFFLE_COORDINATES_
