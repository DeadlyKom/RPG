
                ifndef _MODULE_GAME_RENDER_SWAP_SCREEN_
                define _MODULE_GAME_RENDER_SWAP_SCREEN_
; -----------------------------------------
; смена экранов 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Swap:           ; отображение счётчика FPS
                ifdef _DEBUG
                CALL FPS_Counter.Render
                endif

; .L1             EQU $+1
;                 LD A, #08
;                 DEC A
;                 JR NZ, .L2
;                 SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
;                 ; ToDo спавн частицы
;                 LD DE, #5080
;                 LD BC, PARTICLE_DUST << 8 | OBJECT_PARTICLE
;                 CALL Func.SpawnObject
;                 LD A, #08
; .L2             LD (.L1), A

                CALL Screen.Swap
                RES_RENDER_FLAG FINISHED_BIT                                    ; обнуление флага FINISHED_BIT
                RET
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
