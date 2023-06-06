
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_PASS_
                define _CORE_MODULE_OPEN_WORLD_MAP_PASS_
; -----------------------------------------
; проход диаграмма Вороного по карте мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
VoronoiPass:    ; инициализация
                LD IX, MemBank_03
                CALL GetMapSize
                LD B, C                                                         ; B - x, C - y
                LD A, C

                ; расчёт смещения до новой строки
                LD H, #00
                CP MAP_SIZE_SMALL_SQUARED
                LD L, (MAP_SIZE_BIG_SQUARED - MAP_SIZE_SMALL_SQUARED) * FVoronoiDiagram
                JR Z, .SetOffset
                CP MAP_SIZE_AVERAGE_SQUARED
                LD L, (MAP_SIZE_BIG_SQUARED - MAP_SIZE_AVERAGE_SQUARED) * FVoronoiDiagram
                JR Z, .SetOffset
                LD L, H
.SetOffset      LD (.OffsetNewRow), HL

.LoopY          EX AF, AF'
.LoopX          PUSH BC

                ; проверка завершённости ячейки
                BIT VORONOI_DIAGRAM_LOCK_BIT, (IX + FVoronoiDiagram.X)
                JR Z, .NextElement                                              ; переход, если флаг сброшен (ячейка завершила обработку)

                ; проверка наличия фракции
                LD E, (IX + FVoronoiDiagram.Data)
                LD A, E
                AND VORONOI_DIAGRAM_FRACTION
                CP VORONOI_DIAGRAM_FRACTION
                JR Z, .NextElement                                              ; переход, если фракция не установлена

                LD D, #00
                ; -----------------------------------------
                ; подготовка расчёта квадрат расстояния (радиуса)
                ; -----------------------------------------
                LD A, E
                AND VORONOI_DIAGRAM_RADIUS
                ADD A, VORONOI_DIAGRAM_RADIUS_MIN
                LD E, A

                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                CALL Math.Mul16x8_16
                PUSH HL                                                         ; квадрат расстояния (радиуса)

                ; -----------------------------------------
                ; квадрат расстояния между центром региона и позицией прохода
                ; -----------------------------------------

                ; чтение позиции региона по горизонтали
                LD A, (IX +  FVoronoiDiagram.X)
                AND VORONOI_DIAGRAM_POS_MASK
                LD E, A

                ; B - x, C - размер карты
                LD A, C
                SUB B
                SUB E

                ; abc (x - Region.x)
                JP P, $+5
                NEG

                LD E, A

                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                CALL Math.Mul16x8_16
                PUSH HL

                ; чтение позиции региона по вертикали
                LD A, (IX +  FVoronoiDiagram.Y)
                AND VORONOI_DIAGRAM_POS_MASK
                LD E, A

                ; B - x, C - размер карты
                EX AF, AF'
                LD L, A
                EX AF, AF'
                LD A, C
                SUB L
                SUB E

                ; abc (y - Region.y)
                JP P, $+5
                NEG

                LD E, A

                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                CALL Math.Mul16x8_16
                POP DE
                ADD HL, DE                                                      ; квадрат расстояния между центром региона и позицией прохода

                ; -----------------------------------------
                ; проверка квадраты расстояний
                ; -----------------------------------------
                POP DE
                SBC HL, DE
                JR NC, .NextElement                                             ; переход, если за пределами радиуса
                                                                                ; квадрат расстояния между центром региона и позицией прохода больше или
                                                                                ; равен квадрат расстояния (радиуса)

                ; опредление завершения или заполнения
                BIT VORONOI_DIAGRAM_COMPLETE_BIT, (IX + FVoronoiDiagram.Y)      ; проверка флага завершения обработка
                RES VORONOI_DIAGRAM_COMPLETE_BIT, (IX + FVoronoiDiagram.Y)      ; сброс флага завершения обработка
                CALL Z, .FillCross                                              ; переход, если требуется заполнение соседних ячеек

.NextElement    ; следующий элемент диаграммы Вороного
                LD DE, FVoronoiDiagram
                ADD IX, DE

                POP BC
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

                RET
; -----------------------------------------
; расчёт адреса элемента
; In:
;   B  - положение ячейки X
;   C  - размер карты
;   A' - положение ячейки Y
; Out:
;   HL - адрес элемента
; Corrupt:
;   HL, DE, AF
; -----------------------------------------
.FillCross      ; заполнение соседних ячеек
                LD E, C
                
                ; положение текущей ячейки по горизонтали
                LD A, C
                SUB B
                LD B, A

                ; положение текущей ячейки по вертикали
                LD A, C
                EX AF, AF'
                LD C, A
                EX AF, AF'
                SUB C
                LD C, A

                ; -----------------------------------------
                ; правый
                ; -----------------------------------------

                INC B
                LD D, %00000011
                CALL .Set

                ; -----------------------------------------
                ; нижний
                ; -----------------------------------------

                DEC B
                INC C
                LD D, %00000011
                CALL .Set

                ; -----------------------------------------
                ; левый
                ; -----------------------------------------

                DEC C
                DEC B
                LD D, %00000001
                CALL .Set

                ; -----------------------------------------
                ; вверхний
                ; -----------------------------------------

                INC B
                DEC C
                LD D, %00000001
                CALL .Set

                ; блокировка изменения ячейки
                RES VORONOI_DIAGRAM_LOCK_BIT, (IX + FVoronoiDiagram.X)

                RET
; -----------------------------------------
; расчёт адреса элемента
; In:
;   D  - биты установки (0 - VORONOI_DIAGRAM_LOCK_BIT, 1 - VORONOI_DIAGRAM_COMPLETE_BIT)
;   E  - размер карты
;   BC - положение ячейки (B - x, C - y)
; Out:
;   HL - адрес элемента
; Corrupt:
;   HL, DE, AF
; -----------------------------------------
.Set            ; проверка координат в пределах границы размера карты
                LD A, B
                OR A
                RET M                                                           ; выход, если отрицательный
                CP E
                RET NC                                                          ; выход, если больше
                LD A, C
                OR A
                RET M                                                           ; выход, если отрицательный
                CP E
                RET NC                                                          ; выход, если больше

                ; -----------------------------------------
                ; расчёт адреса элемента
                ; In:
                ;   BC - положение ячейки (B - x, C - y)
                ; Out:
                ;   HL - адрес элемента
                ; Corrupt:
                ;   HL, DE, AF
                ; -----------------------------------------
                PUSH DE
                CALL CalcAdrElement
                POP DE
                PUSH HL
                POP IY

                ; проверка отсутствия ранее установленной фракции
                LD A, (IY + FVoronoiDiagram.Data)
                AND VORONOI_DIAGRAM_FRACTION
                CP VORONOI_DIAGRAM_FRACTION
                RET NZ

                ; установка значения
                LD A, (IX + FVoronoiDiagram.X)
                ADD A, A
                RR D                                                            ; VORONOI_DIAGRAM_LOCK_BIT
                RRA
                LD (IY + FVoronoiDiagram.X), A

                LD A, (IX + FVoronoiDiagram.Y)
                ADD A, A
                RR D                                                            ; VORONOI_DIAGRAM_COMPLETE_BIT
                RRA
                LD (IY + FVoronoiDiagram.Y), A

                LD A, (IX + FVoronoiDiagram.Data)
                LD (IY + FVoronoiDiagram.Data), A
                RET

                display "\t- Voronoi pass:\t\t\t\t\t", /A, VoronoiPass, " = busy [ ", /D, $ - VoronoiPass, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_PASS_
