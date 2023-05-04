
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
                HALT
                CALL Initialize.Player                                          ; инициализация игрока
                CALL Initialize.Core                                            ; инициализация ядра
                CALL Initialize.World                                           ; инициализация загруженного уровня
                CALL Initialize.Input                                           ; инициализация управления
                
                CALL Game.Render.World.UI.DrawInit                              ; обновление UI (после инициализации всего)

                display " - Game 'EntryPoint':\t\t\t\t\t", /A, EntryPoint, " = busy [ ", /D, $ - EntryPoint, " bytes  ]"

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
