
                ifndef _MODULE_GAME_RENDER_SORT_OBJECTS_
                define _MODULE_GAME_RENDER_SORT_OBJECTS_
; -----------------------------------------
; сортировка объектов отображения
; In:
; Out:
; Corrupt:
; Note:
;  устойчив к прерыванию
; -----------------------------------------
Object:         ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                JR Z, .Set                                                      ; переход, если массив пуст
                EX AF, AF'

                CALL Prepare
                CALL Quicksort

                LD A, C
.Set            LD (Game.Render.Object.Draw.Num), A
                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_OBJECTS_
