
                ifndef _CORE_MODULE_GAME_INTERRUPT_
                define _CORE_MODULE_GAME_INTERRUPT_
; -----------------------------------------
; обработчик прерывания игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Interrupt:      
.SwapScreens    ; ************ Swap Screens ************
                CHECK_RENDER_FLAG FINISHED_BIT
                CALL NZ, Render.Swap

.Input          ; ************ Scan Input ************
                ; CALL Input.Gameplay.Scan

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET

                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
