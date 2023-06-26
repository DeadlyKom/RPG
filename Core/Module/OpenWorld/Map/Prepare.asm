
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
                define _CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
; -----------------------------------------
; подготовка данных для визуализации карты
; In:
; Out:
;   A' - количество элементов в массиве
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        ; количество элементов в массиве
                LD A, (GameState.Region)
                OR A
                RET Z                                                           ; выход, если массив пуст

                ; инициализация
                LD IX, SORT_BUF_ADR                                             ; указывает на временный буфер массива структур FVoronoiDiagram
                LD IY, REGION_ADR                                               ; адрес массива регионов
                LD B, A

                ; количество элементов в массиве
                XOR A
                EX AF, AF'
                
.Loop           PUSH BC

                ; -----------------------------------------
                ; подготовка данных о регионе
                ; -----------------------------------------
                LD A, (IY + FRegion.Type)
                AND IDX_REGION_TYPE
                CP IDX_REGION_TYPE
                JR Z, .NextElement                                              ; переход, если тип региона не валидный
                CP REGION_TYPE_HABITATS
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует
                CP REGION_TYPE_DUNGEON
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует
                CP REGION_TYPE_SETTLEMENT_ABANDONED
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует

                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                LD C, A

                LD A, (IY + FRegion.InfluenceRadius)
                AND VORONOI_DIAGRAM_RADIUS
                OR C

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | F3 | F2 | F1 | F0 | R3 | R2 | R1 | R0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   F3-F0   [7-4]   - фракция поселения
                ;                       1111 - отсутствует
                ;   R3-R0   [3-0]   - радиус влияния поселения
                ;                       0000 - 4 ячейки (минимально)
                ; -----------------------------------------
                LD (IX + FVoronoiDiagram.Data), A

                ; -----------------------------------------
                ; местоположение поселения по горизонтали
                ; -----------------------------------------

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                LD HL, (IY + FRegion.Location.X.Low)
.LeftTop_X_Low  EQU $+1
                LD DE, #0000
                EXX
                LD HL, (IY + FRegion.Location.X.High)
.LeftTop_X_High EQU $+1
                LD DE, #0000
                CALL Math.Sub32_32
                JP M, .NextElement                                              ; переход, если координаты за пределами карты
                
                ; учёт смещения
                ; RL L
                ; CCF
                ; SBC A, A
                ; ADD A, H
                LD A, H
                DEC A   ; ?

                AND VORONOI_DIAGRAM_POS_MASK
                OR VORONOI_DIAGRAM_LOCK
                LD (IX + FVoronoiDiagram.X), A

                ; -----------------------------------------
                ; местоположение поселения по вертикали
                ; -----------------------------------------

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                LD HL, (IY + FRegion.Location.Y.Low)
.LeftTop_Y_Low  EQU $+1
                LD DE, #0000
                EXX
                LD HL, (IY + FRegion.Location.Y.High)
.LeftTop_Y_High EQU $+1
                LD DE, #0000
                CALL Math.Sub32_32
                JP M, .NextElement                                              ; переход, если координаты за пределами карты

                ; учёт смещения
                ; RL L
                ; CCF
                ; SBC A, A
                ; ADD A, H
                LD A, H
                DEC A   ; ?

                AND VORONOI_DIAGRAM_POS_MASK
                ; OR VORONOI_DIAGRAM_COMPLETE
                LD (IX + FVoronoiDiagram.Y), A

                ; следующий элемент диаграммы Вороного
                LD BC, FVoronoiDiagram
                ADD IX, BC

                ; увеличить счётчик элементов в массиве
                EX AF, AF'
                INC A
                EX AF, AF'

.NextElement    ; следующий элемент региона
                LD BC, FRegion
                ADD IY, BC

                POP BC
                DJNZ .Loop

                RET

                display "\t- Prepare:\t\t\t\t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_PREPARE_
