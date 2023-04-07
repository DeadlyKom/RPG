
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
                AND #3F
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
                
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A

                CALL Math.Mul16x8_16

                ; округление
                ADD HL, HL
                ADD HL, HL
                LD L, H
                LD H, #00

                ; определение знака
                BIT 7, C
                JR Z, .IsPositive_

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
.IsPositive_
                ; округление
                ; отладка
                LD A, L
                LD (PlayerState.Debug), A

                LD DE, (IX + FObject.Position.X)
                ADD HL, DE
                LD (IX + FObject.Position.X), HL


                LD A, (PlayerState.RotationAngle)
                LD B, A
                ; скорость
                LD A, (PlayerState.Speed)
                LD E, A
                ADD A, A
                SBC A, A
                LD D, A

                ; sin (andle)
                LD A, B
                RRA
                ADD A, 16
                AND #3F
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
                
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A

                CALL Math.Mul16x8_16

                ; округление
                ADD HL, HL
                ADD HL, HL
                LD L, H
                LD H, #00

                ; определение знака
                BIT 7, C
                JR Z, .IsPositive

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
.IsPositive
                ; отладка
                LD A, L
                LD (PlayerState.Debug), A

                LD DE, (IX + FObject.Position.Y)
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL
                RET

.RotTable       lua allpass
                for i = 0, 15 do
                    local Angle = math.cos(math.rad(90/15 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 90/15 * i, Angle))
                end
                for i = 0, 15 do
                    local Angle = math.cos(math.rad(90 + 90/15 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 90 + 90/15 * i, Angle))
                end
                for i = 0, 15 do
                    local Angle = math.cos(math.rad(180 + 90/15 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 180 + 90/15 * i, Angle))
                end
                for i = 0, 15 do
                    local Angle = math.cos(math.rad(270 + 90/15 * i)) + 0.001
                    local Value = (math.floor(Angle * 127)) % 256
                    _pc("DB " .. Value)
                    --print (string.format("DB #%.2X - [ cos(%.1f) \t=  %f ]", Value, 270 +  90/15 * i, Angle))
                end

                endlua

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_PLAYER_
