
                ifndef _CORE_MODULE_OPEN_WORLD_PACKING_
                define _CORE_MODULE_OPEN_WORLD_PACKING_
; -----------------------------------------
; попытка упаковать
; In:
;   IX - адрес структуры FRegion
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
;   если флаг переполнения установлен, упаковка прошла успешно
; Corrupt:
; Note:
; -----------------------------------------
TryPacking:     CALL Packs.OpenWorld.Generate.RandLocation                      ; генерация позиции в мире
                SCF
                RET

                display "\t- Packing:\t\t\t\t\t", /A, TryPacking, " = busy [ ", /D, $ - TryPacking, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_PACKING_
