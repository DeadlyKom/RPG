
                ifndef _MODULE_GAME_OBJECT_PLAYER_INPUT_
                define _MODULE_GAME_OBJECT_PLAYER_INPUT_
; -----------------------------------------
; применение инпута
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Input:          CHECK_PLAYER_FLAG ROTATE_LEFT_BIT
                CALL NZ, Game.Input.Gameplay.RotateLeft
                CHECK_PLAYER_FLAG ROTATE_RIGHT_BIT
                CALL NZ, Game.Input.Gameplay.RotateRight
                CHECK_PLAYER_FLAG INCREASE_SPEED_BIT
                CALL NZ, Game.Input.Gameplay.IncreaseSpeed
                CHECK_PLAYER_FLAG DECREASE_SPEED_BIT
                CALL NZ, Game.Input.Gameplay.DecreaseSpeed

                RET

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_INPUT_
