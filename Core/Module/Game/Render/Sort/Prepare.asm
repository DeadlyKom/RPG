
                ifndef _MODULE_GAME_RENDER_SORT_PREPARE_
                define _MODULE_GAME_RENDER_SORT_PREPARE_
; -----------------------------------------
; подготовка к сортировке объектов для отображения
; In:
;   A'  - количество обробаываемых объектов
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        ; -----------------------------------------
                ; копирование в буфер сортировки
                ; -----------------------------------------
                
                LD HL, SortBuffer
                LD DE, Adr.Object                                               ; стартовый адрес обрабатываемого объекта
                EX AF, AF'
                LD B, A
                LD C, A                                                         ; B - размер массива, C - количествой элементов в массиве

.ObjectLoop     ; проверка валидности элемента
                LD A, (DE)
                CP OBJECT_EMPTY_ELEMENT
                JP NZ, .CopyObject

                ; следующий элемент
                LD A, E
                ADD A, OBJECT_SIZE
                LD E, A
                ADC A, D
                SUB E
                LD D, A
                JR .ObjectLoop

                ; CP OBJECT_DECAL
                ; JR Z, $+5
                ; DEC C
                ; JR .NextObject

.CopyObject     RRA                                                             ; BIT VISIBLE_OBJECT_BIT, A
                JR NC, .NextObject

                ; копирование адреса объекта
                INC E                                                           ; FObjectDecal.Position.Y
                LD (HL), E
                DEC E
                INC L
                LD (HL), D
                INC L

                INC C
.NextObject     DEC C                                                           ; уменьшение счётчика активных объектов на экране
                
                ; следующий элемент
                LD A, E
                ADD A, OBJECT_SIZE
                LD E, A
                ADC A, D
                SUB E
                LD D, A

                DJNZ .ObjectLoop
 
                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_PREPARE_
