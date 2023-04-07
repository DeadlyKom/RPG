
                ifndef _MODULE_GAME_OBJECT_TICK_
                define _MODULE_GAME_OBJECT_TICK_
; -----------------------------------------
; обработчик тика
; In:
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Tick:           ; инициализация
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                RET Z                                                           ; выход, если массив пуст
                LD (.ObjectCounter), A
                
                ; стартовый адрес обрабатываемого объекта
                LD IX, Adr.Object

.ObjectLoop     ; проверка валидности элемента
                LD A, (IX + 0)
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .NextObject

                ; обновление объекта
                CALL Update

                ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IX, DE

                ; уменьшение счётчика элементов
                LD HL, .ObjectCounter
                DEC (HL)
                JR NZ, .ObjectLoop

                RET

.NextObject     ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IX, DE
                JR .ObjectLoop

.ObjectCounter  DB #00

                endif ; ~_MODULE_GAME_OBJECT_TICK_
