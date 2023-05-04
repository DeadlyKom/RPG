
                ifndef _MODULE_GAME_INITIALIZE_MAIN_MENU_EXECUTE_
                define _MODULE_GAME_INITIALIZE_MAIN_MENU_EXECUTE_
; -----------------------------------------
; запуск главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Execute:        SET_PAGE_MAIN_MENU                                              ; включить страницу работы с главным меню
                LD HL, Adr.MainMenu
                LD DE, Adr.Module.Game.Shared
                LD BC, Packs.MainMenu.Size
                PUSH DE
                JP Memcpy.FastLDIR

                display " - Game execute 'Main Menu':\t\t\t\t", /A, Execute, " = busy [ ", /D, $ - Execute, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_MAIN_MENU_EXECUTE_
