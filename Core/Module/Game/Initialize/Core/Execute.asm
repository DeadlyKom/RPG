
                ifndef _MODULE_GAME_INITIALIZE_CORE_EXECUTE_
                define _MODULE_GAME_INITIALIZE_CORE_EXECUTE_
; -----------------------------------------
; запуск инициализации игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Core:           SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                JP Packs.Initialize.Base
; -----------------------------------------
; запуск инициализации игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Player:         SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                JP Packs.Initialize.Player
; -----------------------------------------
; запуск инициализация управления
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                JP Packs.Initialize.Input

                display " - Game execute 'Base':\t\t\t\t", /A, Core, " = busy [ ", /D, $ - Core, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_CORE_EXECUTE_
