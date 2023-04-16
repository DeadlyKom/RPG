
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
                define _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
; -----------------------------------------
; поворот игрока по часовой стрелке
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateLeft:     LD HL, PlayerState.RotationAngle
                LD A, (HL)
                ADD A, #03
                LD (HL), A

                LD A, (PlayerState.Speed)
                CP #10
                CALL C, IncreaseSpeed
                RET

.Input          SET_PLAYER_FLAG ROTATE_LEFT_BIT
                RET
; -----------------------------------------
; поворот игрока против часовой стрелки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateRight:    LD HL, PlayerState.RotationAngle
                LD A, (HL)
                SUB #03
                LD (HL), A

                LD A, (PlayerState.Speed)
                CP #10
                CALL C, IncreaseSpeed
                RET

.Input          SET_PLAYER_FLAG ROTATE_RIGHT_BIT
                RET
; -----------------------------------------
; увеличить скорость игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IncreaseSpeed:  ;
                CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                LD BC, MAX_TURBOCHARGING_SPEED << 8 | 5
                JR NZ, .Turbocharging
                LD BC, MAX_FORWARD_SPEED << 8 | 2

.Turbocharging  ; турбонаддув активирован
                LD HL, PlayerState.Speed
                LD A, (HL)
                ADD A, C
                CP B
                RET NC
.Set            LD (HL), A
                RET

.Input          SET_PLAYER_FLAG INCREASE_SPEED_BIT
                RET
; -----------------------------------------
; уменьшить скорость игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DecreaseSpeed:  LD HL, PlayerState.Speed
                LD A, (HL)
                DEC A
                CP 256-MAX_REVERSE_SPEED
                RET C
                LD (HL), A
                RET

.Input          SET_PLAYER_FLAG DECREASE_SPEED_BIT
                RET
; -----------------------------------------
; активация турбонаддува
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TurbochargOn:   SET_PLAYER_FLAG TURBOCHARGING_BIT
                RET

; -----------------------------------------
; деактивация турбонаддува
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TurbochargOff:  RES_PLAYER_FLAG TURBOCHARGING_BIT
                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
