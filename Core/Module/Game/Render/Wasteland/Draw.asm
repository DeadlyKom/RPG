
                ifndef _MODULE_GAME_RENDER_WASTELAND_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_DRAW_
; -----------------------------------------
; отображение пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_DRAW_
