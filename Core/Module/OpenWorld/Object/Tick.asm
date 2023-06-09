
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_TICK_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_TICK_
; -----------------------------------------
; обработчик тика
; In:
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Tick:           ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                RET Z                                                           ; выход, если массив пуст
                LD (.ObjectCounter), A
                
                ; стартовый адрес обрабатываемого объекта
                LD IX, PLAYER_ADR

.ObjectLoop     ; проверка валидности элемента
                LD A, (IX + FObject.Type)
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .SkipObject

                ; обновление объекта
                CALL Update

                ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IX, DE

.NextObject     ; уменьшение счётчика элементов
                LD HL, .ObjectCounter
                DEC (HL)
                JR NZ, .ObjectLoop

                RET

.SkipObject     ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IX, DE
                JR .ObjectLoop

.ObjectCounter  DB #00

                display "\t- Tick:\t\t\t\t\t\t", /A, Tick, " = busy [ ", /D, $ - Tick, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_OBJECT_TICK_
