
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
; -----------------------------------------
; балансировщик регионов
; In:
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Balancer:       
                RET

                display "\t- Balancer region:\t\t\t\t", /A, Add, " = busy [ ", /D, $ - Add, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
