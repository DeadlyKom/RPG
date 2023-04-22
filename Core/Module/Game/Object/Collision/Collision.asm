
                ifndef _MODULE_GAME_OBJECT_COLLISION_HANDLER_
                define _MODULE_GAME_OBJECT_COLLISION_HANDLER_
; -----------------------------------------
; обработчик коллизии
; In:
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Handler:        ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                RET Z                                                           ; выход, если массив пуст
                EX AF, AF'

                CALL Prepare
                JP Detection

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_HANDLER_
