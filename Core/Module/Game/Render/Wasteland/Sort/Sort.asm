
                ifndef _MODULE_GAME_RENDER_WASTELAND_SORT_OBJECTS_
                define _MODULE_GAME_RENDER_WASTELAND_SORT_OBJECTS_
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

                ; сброс смещение
                LD HL, Quicksort.Offset
                LD (HL), #00

                CALL Prepare
                CALL Quicksort

                LD A, C
.Set            LD (Packs.Wasteland.Render.OBJ_Draw.Num), A
                RET

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_SORT_OBJECTS_
