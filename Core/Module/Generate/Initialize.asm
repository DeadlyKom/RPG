
                ifndef _CORE_MODULE_GENERATE_WORLD_INITIALIZE_
                define _CORE_MODULE_GENERATE_WORLD_INITIALIZE_
; -----------------------------------------
; инициализация работы с поселениями
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
                ; очистка массива поселений
                LD HL, Adr.Settlement + Size.Settlement
                LD DE, (SETTLEMENT_EMPTY_ELEMENT << 8) | SETTLEMENT_EMPTY_ELEMENT
                CALL SafeFill.b1024

                ; очистка количества элементов в массиве поселений
                LD HL, GameState.Settlement
                LD (HL), #00

                endif ; ~ _CORE_MODULE_GENERATE_WORLD_INITIALIZE_
