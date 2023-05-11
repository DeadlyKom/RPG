
                ifndef _CORE_MODULE_GAME_INTERRUPT_SETTLEMENT_
                define _CORE_MODULE_GAME_INTERRUPT_SETTLEMENT_
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
                CALL Input.Scan

.UI             ; ************** UI Tick **************
                CALL UI.CharTick
                CALL .Anim

                ifdef _DEBUG
.Debug_FPS      ; ************** Draw FPS **************
                CALL FPS_Counter.Tick
                endif

                RET

.Anim           LD HL, .Delay
                DEC (HL)
                RET NZ

                LD A, (GameState.CharacterState)
                AND CHAR_STATE_MASK
                JR Z, .NextPlayer

.SetChange      LD (HL), #10
                LD A, CHAR_STATE_NONE
                LD (GameState.CharacterState), A
                RET

.NextPlayer     LD A, (GameState.CharacterID)
                DEC A
                JP P, $+5
                LD A, #04
                LD (GameState.CharacterID), A

                LD A, CHAR_STATE_IDLE
                LD (GameState.CharacterState), A
                RET

.Delay          DB #20
    
                endif ; ~ _CORE_MODULE_GAME_INTERRUPT_SETTLEMENT_
