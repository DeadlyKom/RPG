
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

                LD C, #00
                CALL .rot_left_3

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
                LD C, #00
                CALL .rot_left_5

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
                CALL .rot_left_4
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
                AND #07
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                ADD A, LOW .rot_left_8
                LD L, A
                ADC A, HIGH .rot_left_8
                SUB L
                LD H, A
                LD (.rot_left_x), HL

                LD HL, (.x_l)
                LD DE, (.x_h)
.rot_left_x     EQU $+1
                CALL $

                ; coordx += coordy
                POP BC
                ADD HL, BC
                EX DE, HL
                POP BC
                ADC HL, BC

                RET

.rot_left_8     rept 3
                ADD HL, HL
                EX DE, HL
                ADC HL, HL
                EX DE, HL
                LD A, L
                ADC A, C
                LD L, A
                endr

.rot_left_5     ADD HL, HL
                EX DE, HL
                ADC HL, HL
                EX DE, HL
                LD A, L
                ADC A, C
                LD L, A

.rot_left_4     ADD HL, HL
                EX DE, HL
                ADC HL, HL
                EX DE, HL
                LD A, L
                ADC A, C
                LD L, A

.rot_left_3     rept 3
                ADD HL, HL
                EX DE, HL
                ADC HL, HL
                EX DE, HL
                LD A, L
                ADC A, C
                LD L, A
                endr

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_SHUFFLE_COORDINATES_
