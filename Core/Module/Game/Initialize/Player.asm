
                ifndef _MODULE_GAME_INITIALIZE_PLAYER_
                define _MODULE_GAME_INITIALIZE_PLAYER_
; -----------------------------------------
; инициализация игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Player:         ; очистка буфера
                LD HL, Adr.PlayerState + Size.PlayerState
                LD DE, #0000
                CALL SafeFill.b128

                ;
                LD A, #FF
                LD (PlayerState.Health), A
                LD (PlayerState.Gas), A
                LD (PlayerState.Turbo), A

                LD A, Game.Render.World.UI.SLOT_MINE
                LD (PlayerState.Slot), A

                LD HL, #0000
                LD (PlayerState.CameraPosX + 1), HL
                LD HL, #0000
                LD (PlayerState.CameraPosY + 1), HL
                LD HL, #1000
                LD (PlayerState.CameraPosX + 3), HL
                LD (PlayerState.CameraPosY + 3), HL

                RET

                endif ; ~_MODULE_GAME_INITIALIZE_PLAYER_
