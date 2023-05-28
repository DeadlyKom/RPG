
                ifndef _CORE_MODULE_OPEN_WORLD_INITIALIZE_
                define _CORE_MODULE_OPEN_WORLD_INITIALIZE_
; -----------------------------------------
; инициализация работы с поселениями
; In:
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; генерация PRNG пустоши
                CALL Tables.Gen_PRNG

                ; очистка массива поселений
                LD HL, Adr.Settlement + Size.Settlement
                LD DE, (SETTLEMENT_EMPTY_ELEMENT << 8) | SETTLEMENT_EMPTY_ELEMENT
                CALL SafeFill.b1024

                ; очистка количества элементов в массиве поселений
                LD HL, GameState.Settlement
                LD (HL), #00

                display "\t- Initialize:\t\t\t\t\t", /A, Initialize, " = busy [ ", /D, $ - Initialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_INITIALIZE_
