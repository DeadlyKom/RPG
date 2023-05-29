
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
                define _CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
; -----------------------------------------
; подготовка данных для визуализации карты
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        LD IX, SETTLEMENT_ADR                                           ; адрес массива 
                LD IY, SORT_BUF_ADR                                             ; FVoronoiDiagram

                RET

                display "\t- Prepare:\t\t\t\t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
