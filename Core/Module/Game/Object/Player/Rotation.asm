
                ifndef _MODULE_GAME_OBJECT_PLAYER_ROTATION_
                define _MODULE_GAME_OBJECT_PLAYER_ROTATION_
; -----------------------------------------
; вращение игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Rotation:       ;
                LD A, (PlayerState.RotationAngle)
                LD B, A
                
                ; округление
                BIT 2, A
                JR Z, $+4
                ADD A, #08

                ; установка направления
                LD C, (IX + FObject.Direction)
                XOR C
                AND %01111000
                XOR C
                LD (IX + FObject.Direction), A

                ; отсечение угла поворота
                LD A, B
.ApplySpeed     RRA
                RRA
                LD B, A

                ; скорость
                LD A, (IX + FObject.EnginePower)
                LD E, A
                ADD A, A
                SBC A, A
                LD D, A

                ; RL E
                ; RL D

                ; cos (andle)
                LD A, B
                CALL .CalcRotation
                LD A, B                                                         ; освобождение регистра B
                LD BC, (IX + FObject.Velocity.X)
                ADD HL, BC
                LD (IX + FObject.Velocity.X), HL

                ; sin (andle)
                ADD A, 8                                                        ; -sin α = cos(π * 0.5 + α)
                CALL .CalcRotation
                LD BC, (IX + FObject.Velocity.Y)
                ADD HL, BC
                LD (IX + FObject.Velocity.Y), HL

                RET

; -----------------------------------------
; расчтёт проекции вектора на ось
; In:
;   A  - угол поворота
;   DE - скорость
; Out:
; Corrupt:
; Note:
; ----------------------------------------
.CalcRotation   AND #1F
                LD L, LOW .RotTable
                ADD A, L
                LD L, A
                ADC A, HIGH .RotTable
                SUB L
                LD H, A
                LD A, (HL)

                LD C, A
                BIT 7, C
                JR Z, $+4
                NEG
                
                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                PUSH DE
                LD D, #00
                BIT 7, E
                JR Z, $+8
                EX AF, AF'
                LD A, E
                NEG
                LD E, A
                EX AF, AF'
                CALL Math.Mul16x8_16
                POP DE
                
                ; округление
                ADD HL, HL
                ADD HL, HL
                LD L, H
                LD H, #00

                ; определение знака
                LD A, C
                XOR D
                ADD A, A
                RET NC

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

                RET

.RotTable       lua allpass
                for i = 0, 7 do
                    local Angle = math.cos(math.rad(90/7 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 90/7 * i, Angle))
                end
                for i = 0, 7 do
                    local Angle = math.cos(math.rad(90 + 90/7 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 90 + 90/7 * i, Angle))
                end
                for i = 0, 7 do
                    local Angle = math.cos(math.rad(180 + 90/7 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 180 + 90/7 * i, Angle))
                end
                for i = 0, 7 do
                    local Angle = math.cos(math.rad(270 + 90/7 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 270 +  90/7 * i, Angle))
                end

                endlua

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_ROTATION_
