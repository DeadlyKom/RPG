
                ifndef _MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
                define _MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
; -----------------------------------------
; генерация карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveLeft:       LD HL, RenderBuffer + (SCR_WORLD_SIZE_X - 1) * SCR_WORLD_SIZE_Y
                LD DE, RenderBuffer + (SCR_WORLD_SIZE_X + 0) * SCR_WORLD_SIZE_Y
                LD BC, (SCR_WORLD_SIZE_X - 1) * SCR_WORLD_SIZE_Y
                LDDR



                RET

                endif ; ~_MODULE_GAME_WORLD_GENERATE_MOVE_LEFT_
