
                ifndef _MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
                define _MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
; -----------------------------------------
; расчёт дельт значений между двумя объектами
; In:
;   IX - адрес объекта A FObject
;   IY - адрес объекта B FObject
; Out:
;   DE - дельта значений знаковое число (D - y, E - x)
; Corrupt:
;   HL, DE, BC, F
; Note:
; ----------------------------------------
DeltaPosition:  LD HL, (IY + FObject.Position.X)
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

                RET

                endif ; ~_MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
