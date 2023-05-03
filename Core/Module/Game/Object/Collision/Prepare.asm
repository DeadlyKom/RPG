
                ifndef _MODULE_GAME_OBJECT_COLLISION_PREPARE_
                define _MODULE_GAME_OBJECT_COLLISION_PREPARE_
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
                CALL DrawAABB 
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

                ifdef SHOW_COLLISION_AABB
; -----------------------------------------
; отобразить AABB коллизии
; In:
;   HL  - начальная точка   (H - y, L - x)
;   DE  - конечна точка     (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DrawAABB        PUSH HL
                PUSH DE
                PUSH BC

                LD IXL, E
                LD IXH, D

                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                CP OBJECT_EMPTY_ELEMENT
                RET Z                                                           ; выход, если объект помечен удалённым
                LD C, (IX + FObject.Direction)
                CALL AABB.GetObject
                ; -----------------------------------------
                ;   DE - смещение AABB (D - y, E - x)
                ;   BC - размер AABB (B - y, C - x)
                ; -----------------------------------------
                LD HL, (IX + FObject.Position.X)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, E
                LD E, A

                ADD A, C
                ADD A, C
                LD C, A

                LD HL, (IX + FObject.Position.Y)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, D
                LD D, A

                ADD A, B
                ADD A, B
                LD B, A

                EX DE, HL

                LD D, B
                LD E, C

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL DrawRectangle
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                POP BC
                POP DE
                POP HL
                RET
; -----------------------------------------
; нарисовать прямоугольник
; In:
;   HL  - начальная точка   (H - y, L - x)
;   DE  - конечна точка     (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DrawRectangle:  LD (.Start), HL
                LD (.End), DE

                ; LD HL, (.Start)
                LD D, H
                LD A, (.End)
                LD E, A
                PUSH DE
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP DE
                LD HL, (.End)
                PUSH HL
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP HL
                LD D, H
                LD A, (.Start)
                LD E, A
                PUSH DE
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP DE
                LD HL, (.Start)
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                JP Draw.Line

.Start          DW #0000                                                        ; High - y, Low - x
.End            DW #0000                                                        ; High - y, Low - x
                endif

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_PREPARE_
