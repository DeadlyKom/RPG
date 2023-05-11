
                ifndef _CORE_MODULE_GAME_UI_CHARECTER_TICK_
                define _CORE_MODULE_GAME_UI_CHARECTER_TICK_
; -----------------------------------------
; тик анимации персонажа
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Tick:           LD A, (GameState.CharacterState)
                AND CHAR_STATE_MASK
                CP CHAR_STATE_NONE
                JR Z, StateNone
                CP CHAR_STATE_IDLE
                JR Z, StateIdle
                CP CHAR_STATE_TOLK
                JR Z, StateTolk

                RET

                endif ; ~_CORE_MODULE_GAME_UI_CHARECTER_TICK_
