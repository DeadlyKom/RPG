
                ifndef _CORE_MODULE_GAME_PAUSE_INTERRUPT_
                define _CORE_MODULE_GAME_PAUSE_INTERRUPT_
; -----------------------------------------
; обработчик прерывания игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Interrupt:      ; проверка завершённости процесса отрисовки
                CHECK_RENDER_FLAG FINISHED_BIT
                JR Z, .RenderProcess                                            ; переход, если процесс отрисовки не завершён

.SwapScreens    ; ************ Swap Screens ************
                CALL Game.Render.Swap

.RenderProcess  ; процесс отрисовки не завершён

.Input          ; ************ Scan Input ************
                CALL Game.Input.Pause.Scan

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET
    
                endif ; ~ _CORE_MODULE_GAME_PAUSE_INTERRUPT_
