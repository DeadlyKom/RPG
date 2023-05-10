
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_NAME_
                define _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_NAME_
; -----------------------------------------
; получение имя поселения
; In:
;   IX - указывает на структуру FSettlement
;   HL - адрес формирования имени поселения
; Out:
;   HL - адрес имени
; Corrupt:
; Note:
; -----------------------------------------
GetSettleName:  LD (.Buffer), HL                                                ; сохранение адреса буфера

                ; распаковка текста
                LD HL, Packs.Text.BeginSettle
                LD DE, Adr.SortBuffer
                CALL Decompressor.Forward

                ; -----------------------------------------
                ; расчёт индексов
                ; -----------------------------------------

                ; установка ключа для генерации
                CALL SetGenKey
                
                ; смешивание координат осей поселения
                CALL ShuffleCoord

                ; index = (cordx >> 16) + (coordx & 0xFFFF)
                ADD HL, DE
                EX DE, HL
                
                ; -----------------------------------------
                ; D - индекс прилагательного
                ; E - индекс существительного
                ; -----------------------------------------

                LD HL, Adr.SortBuffer
                LD A, E
                AND %00011111
                PUSH AF

                LD E, #20

                LD A, D
                AND %00011111
                LD D, A

                NEG
                ADD A, E
                LD E, A

                ; -----------------------------------------
                ; поиск прилагательного
                ; -----------------------------------------
                LD A, D
                CALL Utils.GetStringID
                
                LD B, H
                LD C, L

                ; сохранение адреса прилагательного
                EX (SP), HL
                PUSH HL

                LD H, B
                LD L, C

                ; поиск блока существительных
.WordLoop_1     CPI
                JR NZ, .WordLoop_1

                DEC E
                JR NZ, .WordLoop_1

                ; -----------------------------------------
                ; поиск существительного
                ; -----------------------------------------
                POP AF
                CALL Utils.GetStringID

                ; объединенние
                EX (SP), HL

                ; инициализация
.Buffer         EQU $+1
                LD DE, #0000
                LD B, A
                LD C, A

                ; копирование 1ого слова
                CALL Utils.Strcpy

                DEC DE
                LD A, ' '
                LD (DE), A
                INC DE
                DEC BC

                ; адрес второго слова
                POP HL

                ; копирование 2ого слова
                JP Utils.Strcpy

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_GET_SETTLEMENT_
