
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_CALC_METADATA_
                define _CORE_MODULE_OPEN_WORLD_UTILS_CALC_METADATA_
; -----------------------------------------
; расчёт адреса метаданных по ID
; In:
;   A  - ID метаданных
; Out:
;   IX - указывает на метаданные (структур FSettlement/FHabitats/FDungeon)
; Corrupt:
; Note:
; -----------------------------------------
CalcMetadata:   ; METADATA_SIZE = 4
                ADD A, A    ; x2
                ADD A, A    ; x4
                LD IXH, HIGH Adr.Metadata
                LD IXL, A
                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_CALC_METADATA_
