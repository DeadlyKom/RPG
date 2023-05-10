
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
                define _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
; -----------------------------------------
; установить ключ генерации для поселения
; In:
;   IX - указывает на структуру FSettlement
; Out:

; Corrupt:
; Note:
; -----------------------------------------
SetGenKey:      LD BC, (IX + FSettlement.Seed)
                LD HL, (IX + FSettlement.Location.X.Low)
                LD DE, (IX + FSettlement.Location.X.High)
                EXX
                LD HL, (IX + FSettlement.Location.Y.Low)
                LD DE, (IX + FSettlement.Location.Y.High)
                EXX
                JP Math.SetSeed80
; -----------------------------------------
; установить ключ генерации для поселения
; In:
;   IX - указывает на структуру FSettlement
; Out:

; Corrupt:
; Note:
; -----------------------------------------
SetGenKeyTime:  ; ToDo разбавить позицию текущим временем
                LD BC, (IX + FSettlement.Seed)
                LD HL, (IX + FSettlement.Location.X.Low)
                LD DE, (IX + FSettlement.Location.X.High)
                EXX
                LD HL, (IX + FSettlement.Location.Y.Low)
                LD DE, (IX + FSettlement.Location.Y.High)
                EXX
                JP Math.SetSeed80

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
