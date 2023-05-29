
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
                define _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
; -----------------------------------------
; установить ключ генерации для поселения
; In:
;   IY - указывает на структуру FRegion
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetGenKey:      LD BC, (IY + FRegion.Seed)
                LD HL, (IY + FRegion.Location.X.Low)
                LD DE, (IY + FRegion.Location.X.High)
                EXX
                LD HL, (IY + FRegion.Location.Y.Low)
                LD DE, (IY + FRegion.Location.Y.High)
                EXX
                JP Math.SetSeed80
; -----------------------------------------
; установить ключ генерации для поселения
; In:
;   IY - указывает на структуру FRegion
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetGenKeyTime:  JR$; ToDo разбавить позицию текущим временем
                LD BC, (IY + FRegion.Seed)
                LD HL, (IY + FRegion.Location.X.Low)
                LD DE, (IY + FRegion.Location.X.High)
                EXX
                LD HL, (IY + FRegion.Location.Y.Low)
                LD DE, (IY + FRegion.Location.Y.High)
                EXX
                JP Math.SetSeed80

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
