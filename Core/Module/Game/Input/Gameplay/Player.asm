
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
                define _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
; -----------------------------------------
; поворот игрока по часовой стрелке
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateLeft:     ; LD A, (PlayerState.Speed)
                ; ADD A, A
                ; JR C, RotateRight.DEC
                
.INC            LD HL, PlayerState.RotationAngle
                INC (HL)

                LD A, (PlayerState.Speed)
                CP #10
                CALL C, IncreaseSpeed
                RET
; -----------------------------------------
; поворот игрока против часовой стрелки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateRight:    ; LD A, (PlayerState.Speed)
                ; ADD A, A
                ; JR C, RotateLeft.INC

.DEC            LD HL, PlayerState.RotationAngle
                DEC (HL)

                LD A, (PlayerState.Speed)
                CP #10
                CALL C, IncreaseSpeed
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
