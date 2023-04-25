
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
                LD A, #00
                CALL Heart
                CALL Gas
                LD A, #01
                CALL Turbo
                RET

                endif ; ~_MODULE_GAME_RENDER_UI_INITIALIZE_
