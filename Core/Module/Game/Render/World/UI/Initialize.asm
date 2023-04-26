
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
                CALL BackFrame
                XOR A
                CALL Heart
                CALL Gas
                XOR A
                CALL Turbo
                RET

                endif ; ~_MODULE_GAME_RENDER_UI_INITIALIZE_
