
                ifndef _CORE_MODULE_GAME_UI_CHARECTER_TICK_STATE_NONE_
                define _CORE_MODULE_GAME_UI_CHARECTER_TICK_STATE_NONE_
; -----------------------------------------
; тик анимации персонажа "отсутствует"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
StateNone:      LD HL, .Delay
                DEC (HL)
                RET NZ

                LD (HL), #03

                LD A, (GameState.CharacterState)
                LD C, A
                ADD A, %01000000
                AND CHAR_FRAME_MASK << 6
                XOR C
                AND CHAR_FRAME_MASK << 6
                XOR C
                LD (GameState.CharacterState), A

                RET

.Delay          DB #03

                endif ; ~_CORE_MODULE_GAME_UI_CHARECTER_TICK_STATE_NONE_
