
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_NAME_
                define _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_NAME_
; -----------------------------------------
; получение имя поселения
; In:
;   IX - указывает на структуру FSettlement
; Out:
;   HL - адрес имени
; Corrupt:
; Note:
; -----------------------------------------
GetSettleName:  ; установка ключа для генерации
                CALL SetGenKey


                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_
