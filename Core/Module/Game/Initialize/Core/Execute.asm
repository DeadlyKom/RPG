
                ifndef _MODULE_GAME_INITIALIZE_CORE_EXECUTE_
                define _MODULE_GAME_INITIALIZE_CORE_EXECUTE_
; -----------------------------------------
; запуск инициализации игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Core:           SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                JP Packs.Initialize.Base
; -----------------------------------------
; запуск инициализации игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Player:         SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                JP Packs.Initialize.Player
; -----------------------------------------
; запуск инициализация управления
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                JP Packs.Initialize.Input
; -----------------------------------------
; запуск генерации мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_World:      SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                JP Packs.OpenWorld.Generate.World

                display " - Game execute 'Base':\t\t\t\t", /A, Core, " = busy [ ", /D, $ - Core, " bytes  ]"

                endif ; ~_MODULE_GAME_INITIALIZE_CORE_EXECUTE_
