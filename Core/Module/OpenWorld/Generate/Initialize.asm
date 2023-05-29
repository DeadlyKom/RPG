
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

                ; очистка массива регионов
                LD HL, Adr.Region + Size.Region
                LD DE, (REGION_EMPTY_ELEMENT << 8) | REGION_EMPTY_ELEMENT
                CALL SafeFill.b768

                ; очистка массива поселений
                LD HL, Adr.Settlement + Size.Settlement
                LD DE, (SETTLEMENT_EMPTY_ELEMENT << 8) | SETTLEMENT_EMPTY_ELEMENT
                CALL SafeFill.b256

                ; очистка количества элементов в массиве регионов
                LD HL, GameState.Region
                LD (HL), #00

                ; очистка количества элементов в массиве поселений
                LD HL, GameState.Settlement
                LD (HL), #00

                display "\t- Initialize:\t\t\t\t\t", /A, Initialize, " = busy [ ", /D, $ - Initialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_INITIALIZE_
