
                ifndef _CORE_MODULE_GAME_INTERRUPT_WASTELAND_
                define _CORE_MODULE_GAME_INTERRUPT_WASTELAND_
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
                CALL Packs.OpenWorld.Wasteland.Horizontal
                CALL Packs.OpenWorld.Wasteland.Vertical

.Tick           ; ************* TICK *************
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                CALL Packs.OpenWorld.Object.Tick
                CALL Packs.OpenWorld.Object.Collision.Handler

.RenderProcess  ; процесс отрисовки не завершён

.Input          ; ************ Scan Input ************
                CALL Input.Scan

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET
    
                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_WASTELAND_
