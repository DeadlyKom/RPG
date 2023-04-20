
                ifndef _MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
                define _MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
; -----------------------------------------
; поворот NPC к цели
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
RotationTo:     LD IY, PLAYER_ADR

                LD HL, (IY + FObject.Position.X)
                LD BC, (IX + FObject.Position.X)
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL

                LD E, H

                LD HL, (IX + FObject.Position.Y)
                LD BC, (IY + FObject.Position.Y)
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL

                LD D, H

                ; In:
                ;   DE - дельта значений знаковое число (D - y, E - x)
                ; Out :
                ;   A  - номер сектора [0..15] << 3
                CALL Math.Atan
                LD (IX + FObject.Direction), A

                RET

                endif ; ~_MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
