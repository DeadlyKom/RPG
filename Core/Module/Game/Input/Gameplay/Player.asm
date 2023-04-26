
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
                define _MODULE_GAME_INPUT_GAMEPLAY_PLAYER_
; -----------------------------------------
; поворот игрока по часовой стрелке
; In:
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
;   включить страницу работы с объектами
; -----------------------------------------
RotateLeft:     LD A, (IX + FObject.EnginePower)
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
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
;   включить страницу работы с объектами
; -----------------------------------------
RotateRight:    
                LD A, (IX + FObject.EnginePower)
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
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
;   включить страницу работы с объектами
; -----------------------------------------
IncreaseSpeed:  ;
                CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                LD BC, MAX_TURBOCHARGING_SPEED << 8 | 5
                JR NZ, .Turbocharging
.L1             LD BC, MAX_FORWARD_SPEED << 8 | 2
                JR .L2

.Turbocharging  LD A, (PlayerState.Turbo + 0)
                OR A
                JR Z, .L1
.L2
                ; турбонаддув активирован
                LD A, (IX + FObject.EnginePower)
                ADD A, C
                CP B
                RET NC
.Set            LD (IX + FObject.EnginePower), A
                ; RET

.Input          SET_PLAYER_FLAG INCREASE_SPEED_BIT
                RET
; -----------------------------------------
; уменьшить скорость игрока
; In:
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
;   включить страницу работы с объектами
; -----------------------------------------
DecreaseSpeed:  CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                JR NZ, .HandBrake
                LD A, (IX + FObject.EnginePower)
                DEC A
                CP 256-MAX_REVERSE_SPEED
                RET C
                LD (IX + FObject.EnginePower), A
                ; RET

.Input          SET_PLAYER_FLAG DECREASE_SPEED_BIT
                RET

.HandBrake      CALL Object.ApplyDecel
                LD A, (IX + FObject.EnginePower)
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

                EX AF, AF'
                LD A, (PlayerState.Turbo + 0)
                OR A
                JR Z, .RET

                LD HL, PlayerState.Turbo + 2
                LD A, (HL)
                ADD A, -1
                LD (HL), A
.RET            EX AF, AF'

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
