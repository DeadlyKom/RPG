
                ifndef _MODULE_GAME_RENDER_SORT_OBJECTS_
                define _MODULE_GAME_RENDER_SORT_OBJECTS_
; -----------------------------------------
; сортировка объектов отображения
; In:
; Out:
; Corrupt:
; Note:
;  не устойчив к прерыванию
; -----------------------------------------
Object:         ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                JR Z, .Set                                                      ; переход, если массив пуст
                EX AF, AF'
                 
                ; инициализация
                LD (.ContainerSP), SP

                CALL Prepare
                ; CALL Quicksort

.ContainerSP    EQU $+1
                LD SP, #0000

                LD A, C
.Set            LD (Game.Render.Object.Draw.Num), A
                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_OBJECTS_
