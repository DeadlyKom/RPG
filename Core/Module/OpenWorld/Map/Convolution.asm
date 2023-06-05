
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_CONVOLUTION_
                define _CORE_MODULE_OPEN_WORLD_MAP_CONVOLUTION_
; -----------------------------------------
; свёртывание диаграммы Вороного в визуальный вид
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Convolution:    ; инициализация
                LD IX, MemBank_03                                               ; адрес массива диаграммы Вороного
                LD HL, MemBank_03                                               ; адрес массива свёрнутой диаграммы Вороного
                PUSH HL
                CALL GetMapSize
                LD B, C                                                         ; B - x, C - y
                LD A, C

                ; расчёт смещения до новой строки
                LD D, #00
                CP MAP_SIZE_SMALL_SQUARED
                LD E, (MAP_SIZE_BIG_SQUARED - MAP_SIZE_SMALL_SQUARED) * FVoronoiDiagram
                JR Z, .SetOffset
                CP MAP_SIZE_AVERAGE_SQUARED
                LD E, (MAP_SIZE_BIG_SQUARED - MAP_SIZE_AVERAGE_SQUARED) * FVoronoiDiagram
                JR Z, .SetOffset
                LD E, D
.SetOffset      LD (.OffsetNewRow), DE

.LoopY          EX AF, AF'
.LoopX          LD A, (IX + FVoronoiDiagram.Data)
                AND VORONOI_DIAGRAM_FRACTION
                CP REGION_TYPE_RADIOACTIVE << 4
                LD E, REGION_TYPE_RADIOACTIVE_COLOR
                JR Z, .SetElement
                CP REGION_TYPE_SETTLEMENT_BEGIN << 4
                LD E, REGION_TYPE_SETTLEMENT_BEGIN_COLOR
                JR Z, .SetElement
                CP REGION_TYPE_SETTLEMENT_NEUTRAL << 4
                LD E, REGION_TYPE_SETTLEMENT_NEUTRAL_COLOR
                JR Z, .SetElement
                CP REGION_TYPE_SETTLEMENT_FRIENDLY << 4
                LD E, REGION_TYPE_SETTLEMENT_FRIENDLY_COLOR
                JR Z, .SetElement
                CP REGION_TYPE_SETTLEMENT_HOSTILE << 4
                LD E, REGION_TYPE_SETTLEMENT_HOSTILE_COLOR
                JR Z, .SetElement
                LD E, REGION_TYPE_EMPTY
.SetElement     LD (HL), E
                INC HL

.NextElement    ; следующий элемент диаграммы Вороного
                LD DE, FVoronoiDiagram
                ADD IX, DE

                DJNZ .LoopX

                ; смещение до новой строки
                ; т.к. расчёты в пределах квадрата 72х72
.OffsetNewRow   EQU $+1
                LD DE, #0000
                ADD IX, DE

                LD B, C                                                         ; установка нового значения по горизонтали
                EX AF, AF'
                DEC A
                JR NZ, .LoopY

                ; расчёт размера массива
                POP DE
                SBC HL, DE
                LD B, H
                LD C, L

                ; копирование в буффер готового представления
                EX DE, HL
                LD DE, Adr.MapBuffer
                JP Memcpy.FastLDIR

                display "\t- Convolution:\t\t\t\t\t", /A, Convolution, " = busy [ ", /D, $ - Convolution, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_CONVOLUTION_
