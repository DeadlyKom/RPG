
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_PASS_
                define _CORE_MODULE_OPEN_WORLD_MAP_PASS_
; -----------------------------------------
; проход диаграмма Вороного по карте мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
VoronoiPass:    LD HL, MemBank_03
                RET

                display "\t- Voronoi pass:\t\t\t\t\t", /A, VoronoiPass, " = busy [ ", /D, $ - VoronoiPass, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_PASS_
