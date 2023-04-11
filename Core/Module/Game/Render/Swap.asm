
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

                CALL Screen.Swap
                CALL Object.Sort
                RES_RENDER_FLAG FINISHED_BIT                                    ; обнуление флага FINISHED_BIT
                RET
 
                endif ; ~_MODULE_GAME_RENDER_SWAP_SCREEN_
