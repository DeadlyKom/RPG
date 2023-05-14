
                ifndef _CORE_MODULE_GAME_ENTRY_POINT_
                define _CORE_MODULE_GAME_ENTRY_POINT_
; -----------------------------------------
; точка входа запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EntryPoint:     ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                EI
                HALT
                CALL Execute.Core                                               ; инициализация ядра
                CALL Execute.Player                                             ; инициализация игрока

                ifdef ENABLE_MAIN_MENU
                CALL Execute.MainMenu                                           ; инициализация и запуск главного меню
                else
                CALL Execute.Wasteland
                endif

                CALL Execute.Input                                              ; инициализация управления

                display "\t- Game 'EntryPoint':\t\t\t\t", /A, EntryPoint, " = busy [ ", /D, $ - EntryPoint, " bytes  ]"

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
