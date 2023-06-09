
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_VISUALIZATION_
                define _CORE_MODULE_OPEN_WORLD_MAP_VISUALIZATION_
; -----------------------------------------
; визуализация карты мира
; In:
;   A' - количество элементов в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Visualization:  ifdef _DEBUG
                ; проверка наличия объектов
                EX AF, AF'
                RET Z                                                           ; выход, если в массиве 0 элементов
                EX AF, AF'
                endif

                CALL Initialize                                                 ; инициализация карты мира

                ; сохранение количества элементов в массиве
                EX AF, AF'
                PUSH AF
                EX AF, AF'

                ; -----------------------------------------
                ; проход диаграмма Вороного (радиоактивный)
                ; -----------------------------------------
                CALL RadiactivePass
                LD B, REGION_TYPE_RADIOACTIVE_RADIUS + VORONOI_DIAGRAM_RADIUS_MIN + 1
.RLoop          PUSH BC
                CALL VoronoiPass
                POP BC
                DJNZ .RLoop

                ; восстановление количества элементов в массиве
                POP AF
                EX AF, AF'

                ; -----------------------------------------
                ; проход диаграмма Вороного (базовый)
                ; -----------------------------------------
                CALL BasicPass
                LD B, VORONOI_DIAGRAM_RADIUS + VORONOI_DIAGRAM_RADIUS_MIN + 1
.Loop           PUSH BC
                CALL VoronoiPass
                POP BC
                DJNZ .Loop

                ; свёртывание диаграмма Вороного в визуальный вид
                CALL Convolution

                JP Func.ShadowScrcpy                                            ; копирования в теневой экран

                display "\t- Visualization:\t\t\t\t", /A, Visualization, " = busy [ ", /D, $ - Visualization, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_VISUALIZATION_
