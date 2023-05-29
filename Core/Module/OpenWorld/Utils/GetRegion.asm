
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_GET_REGION_
                define _CORE_MODULE_OPEN_WORLD_UTILS_GET_REGION_
; -----------------------------------------
; получение адрес региона
; In:
;   IX - указывает на структуру FSettlement
; Out:
;   IY - указывает на структуру FRegion
; Corrupt:
;   HL, AF, IY
; Note:
; -----------------------------------------
GetRegion:      LD L, (IX + FSettlement.RegionID)

                ; REGION_SIZE = 12 байт
                LD A, L
                ADD A, A    ; x2
                ADD A, L    ; x3
                LD L, A
                LD H, HIGH REGION_ADR >> 2                                      ; выровнен 1024 байт
                ADD HL, HL  ; x6
                ADD HL, HL  ; x12

                PUSH HL
                POP IY

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_GET_REGION_
