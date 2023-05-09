
                ifndef _MODULE_GAME_INITIALIZE_PLAY_GAME_EXECUTE_
                define _MODULE_GAME_INITIALIZE_PLAY_GAME_EXECUTE_
; -----------------------------------------
; запуск "начало игры"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PlayGame:       SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                LD HL, Adr.Block6.PlayGame
                LD DE, Adr.Module.Game.Shared
                LD BC, Packs.PlayGame.Size
                PUSH DE
                JP Memcpy.FastLDIR

                display " - Game execute 'Play Game':\t\t\t\t", /A, PlayGame, " = busy [ ", /D, $ - PlayGame, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_PLAY_GAME_EXECUTE_
