
                ifndef _MODULE_GAME_WORLD_GENERATE_TILEPAIR_
                define _MODULE_GAME_WORLD_GENERATE_TILEPAIR_
; -----------------------------------------
; генерация тайлопары
; In:
;   A - ID тайла
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Tilepair:       PUSH HL
                PUSH AF
                PUSH DE
                PUSH BC
                CALL Math.PerlinNoise2D
                POP BC
                POP DE
                POP AF

                LD A, L
                CP #40
                LD A, #0C
                JR NC, $+4
                LD A, #10
               
                POP HL

                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_TILEPAIR_
