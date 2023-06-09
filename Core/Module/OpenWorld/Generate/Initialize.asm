
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

                ; очистка массива метаданных
                LD HL, Adr.Metadata + Size.Metadata
                LD DE, (METADATA_EMPTY_ELEMENT << 8) | METADATA_EMPTY_ELEMENT
                CALL SafeFill.b256

                ; очистка тумана войны
                LD HL, Adr.FOW + Size.FOW
                LD DE, #FFFF
                CALL SafeFill.b1024

                display "\t- Initialize:\t\t\t\t\t", /A, Initialize, " = busy [ ", /D, $ - Initialize, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_INITIALIZE_
