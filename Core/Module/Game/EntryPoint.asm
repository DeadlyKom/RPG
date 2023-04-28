
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
                CALL Initialize.Core                                            ; инициализация ядра
                CALL Initialize.World                                           ; инициализация загруженного уровня
                CALL Initialize.Input                                           ; инициализация управления 

                endif ; ~_CORE_MODULE_GAME_ENTRY_POINT_
