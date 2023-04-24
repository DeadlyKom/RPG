
                ifndef _MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
                define _MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
; -----------------------------------------
; расчёт дельты расстояния между двумя объектами
; In:
;   IX - адрес объекта A FObject
;   IY - адрес объекта B FObject
; Out:
;   DE -  дельта расстояния знаковое (D - y, E - x)
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   важно, 1 бит сдвиг влево меньше 
; ----------------------------------------
DeltaPosition:  LD HL, (IY + FObject.Position.X)
                LD BC, (IX + FObject.Position.X)
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ; ADD HL, HL

                LD E, H

                LD HL, (IX + FObject.Position.Y)
                LD BC, (IY + FObject.Position.Y)
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ; ADD HL, HL

                LD D, H

                RET

                endif ; ~_MODULE_GAME_OBJECT_UTILS_DELTA_POSITION_
