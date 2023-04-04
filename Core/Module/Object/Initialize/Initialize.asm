
                ifndef _CORE_MODULE_OBJECT_INITIALIZE_
                define _CORE_MODULE_OBJECT_INITIALIZE_
; -----------------------------------------
; инициализация работы с объектами
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Object:         ; очистка массива объектов
                LD HL, Adr.Object + Size.Object
                LD DE, (OBJECT_EMPTY_ELEMENT << 8) | OBJECT_EMPTY_ELEMENT
                CALL SafeFill.b1024

                ; очистка количества элементов в массиве объектов
                LD HL, GameState.Objects
                LD (HL), #00

                RET

                display " - Initialize object: \t\t\t\t", /A, Object, " = busy [ ", /D, $ - Object, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_INITIALIZE_
