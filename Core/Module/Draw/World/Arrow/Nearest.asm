                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
                define _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
; -----------------------------------------
; поиск ближайшего врага
; In:
; Out:
;   DE - дельта расстояния знаковое (D - y, E - x)
;   если флаг переполнения установлен, найден ближайши враг
; Corrupt:
; Note:
; -----------------------------------------
Nearest:        LD IX, PLAYER_ADR
                LD IY, PLAYER_ADR + OBJECT_SIZE

                ; -----------------------------------------
                ;   IX - адрес объекта A FObject
                ;   IY - адрес объекта B FObject
                ; Out:
                ;   DE - дельта расстояния знаковое (D - y, E - x)
                ;   HL, DE, BC, AF
                ; Note:
                ;   важно, 1 бит сдвиг влево меньше 
                ; -----------------------------------------
                CALL Object.DeltaPosition

                SCF
                RET

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
