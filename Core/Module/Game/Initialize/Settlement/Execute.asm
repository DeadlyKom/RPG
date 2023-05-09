
                ifndef _MODULE_GAME_INITIALIZE_SETTLEMENT_EXECUTE_
                define _MODULE_GAME_INITIALIZE_SETTLEMENT_EXECUTE_
; -----------------------------------------
; запуск меню поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Settlement:     SET_PAGE_SETTLEMENT                                             ; включить страницу работы с поселением
                LD HL, Adr.Settlement
                LD DE, Adr.Module.Game.Shared
                LD BC, Packs.Settlement.Size
                PUSH DE
                JP Memcpy.FastLDIR

                display " - Game execute 'Settlement':\t\t\t\t", /A, Settlement, " = busy [ ", /D, $ - Settlement, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_SETTLEMENT_EXECUTE_
