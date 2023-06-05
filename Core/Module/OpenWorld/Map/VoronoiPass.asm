
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
                BIT VORONOI_DIAGRAM_LOCK_BIT, (IX + FVoronoiDiagram.Y)
                JR Z, .NextElement                                              ; переход, если флаг сброшен (ячейка завершила обработку)

                ; проверка наличия фракции
                LD A, (IX + FVoronoiDiagram.Data)
                AND VORONOI_DIAGRAM_FRACTION
                CP VORONOI_DIAGRAM_FRACTION
                JR Z, .NextElement                                              ; переход, если фракция не установлена

                ; -----------------------------------------
                ; подготовка расчёта квадрат расстояния (радиуса)
                ; -----------------------------------------
                LD A, (IX + FVoronoiDiagram.Data)
                AND VORONOI_DIAGRAM_RADIUS
                LD E, A
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A

                ; умножение
                rept 4
                ADD A, A
                ADD A, E
                endr
                LD H, #00
                LD L, A                                                         ; квадрат расстояния (радиуса)
                PUSH HL

                ; -----------------------------------------
                ; квадрат расстояния между центром региона и позицией прохода
                ; -----------------------------------------

                LD D, #00

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

                EX AF, AF'
                LD B, A
                EX AF, AF'
                ; B - y, C - размер карты
                LD A, C
                SUB B
                SUB E

                ; abc (y - Region.y)
                JP P, $+5
                NEG

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
                BIT VORONOI_DIAGRAM_COMPLETE_BIT, (IX + FVoronoiDiagram.X)      ; проверка флага
                RES VORONOI_DIAGRAM_COMPLETE_BIT, (IX + FVoronoiDiagram.X)      ; сброс флага
                CALL Z, .FillCross                                             ; переход, если требуется заполнение соседних ячеек

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

.FillCross      ; заполнение соседних ячеек
                
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

                ; B - x, C - y

                ; -----------------------------------------
                ; правый
                ; -----------------------------------------

                INC B

                ; ToDo проверка границ

                ; -----------------------------------------
                ; расчёт адреса элемента
                ; In:
                ;   BC - положение ячейки (B - x, C - y)
                ; Out:
                ;   HL - адрес элемента
                ; Corrupt:
                ;   HL, DE, AF
                ; -----------------------------------------
                CALL CalcAdrElement

                ; установка значения
                LD (HL), B
                SET VORONOI_DIAGRAM_LOCK_BIT, (HL)
                INC HL
                LD (HL), C
                SET VORONOI_DIAGRAM_COMPLETE_BIT, (HL)
                INC HL
                LD A, (IX + FVoronoiDiagram.Data)
                LD (HL), A

                ; -----------------------------------------
                ; нижний
                ; -----------------------------------------

                DEC B
                INC C
                ; ToDo проверка границ

                ; -----------------------------------------
                ; расчёт адреса элемента
                ; In:
                ;   BC - положение ячейки (B - x, C - y)
                ; Out:
                ;   HL - адрес элемента
                ; Corrupt:
                ;   HL, DE, AF
                ; -----------------------------------------
                CALL CalcAdrElement

                ; установка значения
                LD (HL), B
                SET VORONOI_DIAGRAM_LOCK_BIT, (HL)
                INC HL
                LD (HL), C
                SET VORONOI_DIAGRAM_COMPLETE_BIT, (HL)
                INC HL
                LD A, (IX + FVoronoiDiagram.Data)
                LD (HL), A

                ; -----------------------------------------
                ; левый
                ; -----------------------------------------

                DEC C
                DEC B
                ; ToDo проверка границ

                ; -----------------------------------------
                ; расчёт адреса элемента
                ; In:
                ;   BC - положение ячейки (B - x, C - y)
                ; Out:
                ;   HL - адрес элемента
                ; Corrupt:
                ;   HL, DE, AF
                ; -----------------------------------------
                CALL CalcAdrElement

                ; установка значения
                LD (HL), B
                INC HL
                LD (HL), C
                INC HL
                LD A, (IX + FVoronoiDiagram.Data)
                LD (HL), A

                ; -----------------------------------------
                ; вверхний
                ; -----------------------------------------

                INC B
                DEC C
                ; ToDo проверка границ

                ; -----------------------------------------
                ; расчёт адреса элемента
                ; In:
                ;   BC - положение ячейки (B - x, C - y)
                ; Out:
                ;   HL - адрес элемента
                ; Corrupt:
                ;   HL, DE, AF
                ; -----------------------------------------
                CALL CalcAdrElement

                ; установка значения
                LD (HL), B
                INC HL
                LD (HL), C
                INC HL
                LD A, (IX + FVoronoiDiagram.Data)
                LD (HL), A

                RET

                display "\t- Voronoi pass:\t\t\t\t\t", /A, VoronoiPass, " = busy [ ", /D, $ - VoronoiPass, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_PASS_
