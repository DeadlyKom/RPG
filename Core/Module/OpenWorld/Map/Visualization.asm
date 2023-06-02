
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
                CALL VoronoiPass                                                ; проход диаграмма Вороного
                RET

                display "\t- Visualization:\t\t\t\t", /A, Visualization, " = busy [ ", /D, $ - Visualization, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_VISUALIZATION_
