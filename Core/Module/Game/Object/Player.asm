
                ifndef _MODULE_GAME_OBJECT_UPDATE_PLAYER_
                define _MODULE_GAME_OBJECT_UPDATE_PLAYER_
; -----------------------------------------
; обновление игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
PlayerObject:   ;
                LD A, (PlayerState.RotationAngle)
                LD B, A
                AND %01111000
                LD (IX + FObject.Direction), A

                ; скорость
                LD A, (PlayerState.Speed)
                LD E, A
                ADD A, A
                SBC A, A
                LD D, A

                ; cos (andle)
                LD A, B
                RRA
                RRA
                LD B, A
                CALL .CalcRotation

                ; отладка
                ifdef _DEBUG
                LD A, L
                LD (PlayerState.Debug), A
                endif

                LD A, B                                                         ; освобождение регистра B
                LD BC, (IX + FObject.Position.X)
                ADD HL, BC
                LD (IX + FObject.Position.X), HL

                ; sin (andle)
                ADD A, 8                                                        ; -sin α = cos(π * 0.5 + α)
                CALL .CalcRotation

                LD BC, (IX + FObject.Position.Y)
                ADD HL, BC
                LD (IX + FObject.Position.Y), HL

                ; -----------------------------------------
                CALL Game.World.Camera

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

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
