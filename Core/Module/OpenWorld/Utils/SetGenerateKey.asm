
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
                JP Math.SetSeed16

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_SET_GENERATE_KEY_
