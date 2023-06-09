
                ifndef _STRUCTURE_REGION_
                define _STRUCTURE_REGION_

                struct FRegion                                                  ; структура описывающая регион на карте
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | T3 | T2 | T1 | T0 |
;   +----+----+----+----+----+----+----+----+
;
;   Т4-T0   [3..0]  - тип региона
; -----------------------------------------
Type            DB #00                                                          ; тип региона                       [1 байт]
; -----------------------------------------
;   4 байта на каждую ось X, Y
;
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 31 | 30 | 29 | 28 | 27 | 26 | 25 | 24 |   | 23 | 22 | 21 | 20 | 19 | 18 | 17 | 16 |   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | I31| I30| I29| I28| I27| I26| I25| I24|   | I23| I22| I21| I20| I19| I18| I17| I16|   | I15| I14| I13| I12| I11| I10| I9 | I8 |   | I7 | I6 | I5 | I4 | I3 | I2 | I1 | I0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   I31-I0  [31..0] - целая часть от 0 до 2^32-1 в тайлах
; -----------------------------------------
Location        FLocation32                                                     ; позиция региона на карте мира     [8 байт]
InfluenceRadius DB #00                                                          ; радиус влияния                    [1 байт]
Seed            FValue                                                          ; ключ генератора                   [2 байта]

                ends

                endif ; ~_STRUCTURE_REGION_
