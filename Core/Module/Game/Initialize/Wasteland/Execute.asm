
                ifndef _MODULE_GAME_INITIALIZE_WASTELAND_EXECUTE_
                define _MODULE_GAME_INITIALIZE_WASTELAND_EXECUTE_
; -----------------------------------------
; запуск пустошь
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Wasteland:      SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                LD HL, Adr.Block6.Wasteland
                LD DE, Adr.Module.Game.Shared
                LD BC, Packs.Wasteland.Size
                PUSH DE
                JP Memcpy.FastLDIR
; -----------------------------------------
; запуск генерации спрайтов пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
WastelandSpr:   SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                LD HL, Packs.Tables.GenWasteland
                LD DE, Adr.SharedBuffer
                LD BC, Packs.Tables.GenWastelandSpr.Size
                PUSH DE
                JP Memcpy.FastLDIR

                display " - Game execute 'Wasteland':\t\t\t\t", /A, Wasteland, " = busy [ ", /D, $ - Wasteland, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_WASTELAND_EXECUTE_
