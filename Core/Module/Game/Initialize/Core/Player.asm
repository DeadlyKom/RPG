
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

                ; установка время
                LD A, #10
                LD (PlayerState.GameTime + 2), A                                ; Minutes
                LD A, #15
                LD (PlayerState.GameTime + 3), A                                ; Hour
                LD A, #20
                LD (PlayerState.GameTime + 4), A                                ; Day
                LD A, #08
                LD (PlayerState.GameTime + 5), A                                ; Month
                LD HL, 2345
                LD (PlayerState.GameTime + 6), HL                               ; Years

                ;
                LD A, #FF
                LD (PlayerState.Health), A
                LD (PlayerState.Gas), A
                LD (PlayerState.Turbo), A

                LD A, SLOT_MINE
                LD (PlayerState.Slot), A

                LD A, #04
                LD (PlayerState.CharacterID), A

                LD HL, #0000
                LD (PlayerState.CameraPosX + 1), HL
                LD HL, #0000
                LD (PlayerState.CameraPosY + 1), HL
                LD HL, #1000
                LD (PlayerState.CameraPosX + 3), HL
                LD (PlayerState.CameraPosY + 3), HL

                RET

                endif ; ~_MODULE_GAME_INITIALIZE_PLAYER_
