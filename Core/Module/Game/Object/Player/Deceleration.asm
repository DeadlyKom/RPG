
                ifndef _MODULE_GAME_OBJECT_PLAYER_DECELERATION_
                define _MODULE_GAME_OBJECT_PLAYER_DECELERATION_
; -----------------------------------------
; пассивное торможение игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Deceleration:   LD A, (PlayerState.Speed)
                OR A
                RET Z
                LD C, A
                LD A, #01
                JP M, $+5
                NEG
                ADD A, C
                LD (PlayerState.Speed), A

                RET

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_DECELERATION_
