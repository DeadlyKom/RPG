
                ifndef _CORE_MODULE_OBJECT_DAMAGE_APPLY_VEHICLE_
                define _CORE_MODULE_OBJECT_DAMAGE_APPLY_VEHICLE_
; -----------------------------------------
; применить урон транспортному средству игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ApplyVehicle:   LD HL, (IY + FObject.Velocity.X)
                ADD HL, HL
                ADD HL, HL
                LD E, H
                LD HL, (IY + FObject.Velocity.Y)
                ADD HL, HL
                ADD HL, HL
                LD D, H

                ; -----------------------------------------
                ; In :
                ;   DE - дельта расстояния (D - y [-128..127], E - x [-128..127])
                ; Out :
                ;   HL - квадрат расстояния
                ; Corrupt :
                ;   HL, DE, BC, AF
                ; -----------------------------------------
                CALL Math.DistSquared

                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                INC H
                LD A, H
                LD DE, #01C0
                CALL Math.Mul16x8_16

                LD A, H
                NEG
                LD HL, PlayerState.Health + 2
                ADD A, (HL)
                LD (HL), A

                RET

                endif ; ~ _CORE_MODULE_OBJECT_DAMAGE_APPLY_VEHICLE_
