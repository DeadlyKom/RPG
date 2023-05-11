
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

                LD A, (GameState.CharacterState)
                AND CHAR_FRAME_MASK << 6
                JR NZ, .NotBlink

                ; рандом хлопанья глазами
                EXX
                CALL Math.Rand8
                EXX
                CP #28                                                          ; чем меньше тем реже
                JR NC, .NotBlink

                LD (HL), #06
                LD A, (GameState.CharacterState)
                AND CHAR_STATE_MASK
                OR %01000000
                LD (GameState.CharacterState), A
                RET

.NotBlink       LD (HL), #20
                LD A, (GameState.CharacterState)
                AND CHAR_STATE_MASK
                LD (GameState.CharacterState), A
                RET

.Delay          DB #08

                endif ; ~_CORE_MODULE_GAME_UI_CHARECTER_TICK_STATE_NONE_
