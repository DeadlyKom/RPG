
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_NPC_ROTATION_TO_TARGET_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_NPC_ROTATION_TO_TARGET_
; -----------------------------------------
; поворот NPC к цели
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
RotationTo:     LD IY, PLAYER_ADR
                ; -----------------------------------------
                ;   IX - адрес объекта A FObject
                ;   IY - адрес объекта B FObject
                ; Out:
                ;   DE - дельта расстояния знаковое (D - y, E - x)
                ;   HL, DE, BC, AF
                ; Note:
                ;   важно, 1 бит сдвиг влево меньше 
                ; -----------------------------------------
                CALL Packs.OpenWorld.Object.Utils.DeltaPosition

                ; In:
                ;   DE - дельта значений знаковое число (D - y, E - x)
                ; Out :
                ;   A  - номер сектора [0..15] << 3
                JP Math.Atan

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_NPC_ROTATION_TO_TARGET_
