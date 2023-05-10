
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_CALC_SETTLEMENT_
                define _CORE_MODULE_OPEN_WORLD_UTILS_CALC_SETTLEMENT_
; -----------------------------------------
; расчёт адреса поселения по ID
; In:
;   A  - ID поселения
; Out:
;   IX - указывает на структуру FSettlement
; Corrupt:
; Note:
; -----------------------------------------
CalcSettlement: ; SETTLEMENT_SIZE = 16
                ADD A, A    ; x2
                ADD A, A    ; x4
                LD IX, Adr.Settlement >> 2
                ADD A, IXL
                LD IXL, A
                ADC A, IXH
                SUB IXL
                LD IXH, A
                ADD IX, IX  ; x8
                ADD IX, IX  ; x16

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_CALC_SETTLEMENT_
