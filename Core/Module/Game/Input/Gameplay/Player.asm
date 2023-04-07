
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
                INC (HL)
                RET
; -----------------------------------------
; поворот игрока против часовой стрелки
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RotateRight:    LD HL, PlayerState.RotationAngle
                DEC (HL)
                RET
; -----------------------------------------
; увеличить скорость игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IncreaseSpeed:  LD HL, PlayerState.Speed
                INC (HL)
                RET
; -----------------------------------------
; уменьшить скорость игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DecreaseSpeed:  LD HL, PlayerState.Speed
                DEC (HL)
                RET
; -----------------------------------------
; пассивное торможение игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Deceleration:   RET
                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
