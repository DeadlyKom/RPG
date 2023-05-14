
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
                CALL Execute.MainMenu                                           ; инициализация и запуск главного меню
                CALL Execute.Input                                              ; инициализация управления
                
                ; CALL Initialize.World                                           ; инициализация загруженного уровня
                ; CALL Game.Render.World.UI.DrawInit                              ; обновление UI (после инициализации всего)

                display "\t- Game 'EntryPoint':\t\t\t\t", /A, EntryPoint, " = busy [ ", /D, $ - EntryPoint, " bytes  ]"

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
