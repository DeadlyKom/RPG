
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_
                define _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_
; -----------------------------------------
; получение адреса поселения по ID
; In:
;   A  - ID поселения
; Out:
;   IX - указывает на структуру FSettlement
; Corrupt:
; Note:
; -----------------------------------------
GetSettlement:  ; SETTLEMENT_SIZE = 16
                ADD A, A    ; x2
                LD IXL, A
                LD IXH, #00
                ADD IX, IX  ; x4
                ADD IX, IX  ; x8
                ADD IX, IX  ; x16

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_
