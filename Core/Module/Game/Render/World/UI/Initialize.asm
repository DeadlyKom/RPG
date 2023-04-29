
                ifndef _MODULE_GAME_RENDER_UI_INITIALIZE_
                define _MODULE_GAME_RENDER_UI_INITIALIZE_
; -----------------------------------------
; отображение UI карты мира (инициализация)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawInit:       CALL BackBar
                CALL SetBars

                CALL BackFrame
                XOR A
                CALL Heart
                CALL Gas
                XOR A
                CALL Turbo

                LD A, (PlayerState.Slot)
                CALL Slot
                RET

                endif ; ~_MODULE_GAME_RENDER_UI_INITIALIZE_
