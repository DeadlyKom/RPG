
                ifndef _CORE_MODULE_GAME_INTERRUPT_
                define _CORE_MODULE_GAME_INTERRUPT_
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

.Camera         ; ************ CAMERA *************
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR
                CALL Game.World.Horizontal
                CALL Game.World.Vertical

.Tick           ; ************* TICK *************
                CALL Game.Object.Tick

.RenderProcess  ; процесс отрисовки не завершён

.Input          ; ************ Scan Input ************
                CALL Game.Input.Gameplay.Scan

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET
    
                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_
