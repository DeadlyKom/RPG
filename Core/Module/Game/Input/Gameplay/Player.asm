
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
                define _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
; -----------------------------------------
; поворот игрока по часовой стрелке
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateLeft:     LD A, (PlayerState.Speed)
                OR A
                RET Z
                
                LD HL, PlayerState.RotationAngle
                LD A, (HL)
                ADD A, #01
                LD (HL), A

                ; LD A, (PlayerState.Speed)
                ; CP #10
                ; CALL C, IncreaseSpeed
                ; RET

.Input          SET_PLAYER_FLAG ROTATE_LEFT_BIT
                RET
; -----------------------------------------
; поворот игрока против часовой стрелки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateRight:    
                LD A, (PlayerState.Speed)
                OR A
                RET Z

                LD HL, PlayerState.RotationAngle
                LD A, (HL)
                SUB #01
                LD (HL), A

                ; LD A, (PlayerState.Speed)
                ; CP #10
                ; CALL C, IncreaseSpeed
                ; RET

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
                ; RET

.Input          SET_PLAYER_FLAG INCREASE_SPEED_BIT
                RET
; -----------------------------------------
; уменьшить скорость игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DecreaseSpeed:  CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                JR NZ, .HandBrake
                LD HL, PlayerState.Speed
                LD A, (HL)
                DEC A
                CP 256-MAX_REVERSE_SPEED
                RET C
                LD (HL), A
                ; RET

.Input          SET_PLAYER_FLAG DECREASE_SPEED_BIT
                RET

.HandBrake      CALL Game.Object.Player.Deceleration.Speed
                LD A, (PlayerState.Speed)
                OR A
                RET Z

                CHECK_PLAYER_FLAG ROTATE_LEFT_BIT
                LD C, #02
                JR NZ, .Right
                LD C, #FE
.Right          LD HL, PlayerState.RotationAngle
                LD A, (HL)
                ADD A, C
                LD (HL), A
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
