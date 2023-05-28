
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_
; -----------------------------------------
; подготовка предпологаемых объектов проверки коллизии
; In:
;   A'  - количество обробаываемых объектов
; Out:
;   SortBuffer - содержит адреса объектов
;   BC         - количествой элементов в массиве
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        LD HL, SortBuffer
                LD DE, PLAYER_ADR                                               ; стартовый адрес обрабатываемого объекта
                EX AF, AF'
                LD B, A                                                         ; B - размер массива
                LD C, A                                                         ; C - количествой элементов в массиве (останется)

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

.CopyObject     ; проверка видимости объекта
                RRA                                                             ; BIT VISIBLE_OBJECT_BIT, A
                JR NC, .NextObject                                              ; переход, если флаг видимости сброшен

                ; обработчик объектов имеющие коллизии
                ADD A, A
                AND IDX_OBJECT_TYPE
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; OBJECT_PLAYER
                JR .Copy                                                        ; объект имеет коллизию
                ; OBJECT_NPC
                JR .Copy                                                        ; объект имеет коллизию
                ; OBJECT_DECAL
                JR .NextObject                                                  ; объект не имеет коллизию
                ; OBJECT_COLLISION
                JR .Copy                                                        ; объект имеет коллизию
                ; OBJECT_PARTICLE
                JR .NextObject                                                  ; объект не имеет коллизию
                ; OBJECT_MINE
                JR .Copy                                                        ; объект имеет коллизию
                ; 6
                JR $
                ; 7
                JR $

.Copy           ; копирование адреса объекта
                LD (HL), E
                INC L
                LD (HL), D
                INC L

                ifdef SHOW_COLLISION_AABB
                CALL DebugDraw.AABB 
                endif

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

                display "\t- Prepare:\t\t\t\t\t", /A, Prepare, " = busy [ ", /D, $ - Prepare, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_
