
                ifndef _MODULE_GAME_INITIALIZE_MAP_EXECUTE_
                define _MODULE_GAME_INITIALIZE_MAP_EXECUTE_
; -----------------------------------------
; запуск карты
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Map:            SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                LD HL, Adr.Block6.Map
                LD DE, Adr.Module.Game.Shared
                LD BC, Packs.Map.Size
                PUSH DE
                JP Memcpy.FastLDIR

                display " - Game execute 'Map':\t\t\t\t", /A, Map, " = busy [ ", /D, $ - Map, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_MAP_EXECUTE_
