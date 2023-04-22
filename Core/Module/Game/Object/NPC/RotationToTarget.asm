
                ifndef _MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
                define _MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
; -----------------------------------------
; поворот NPC к цели
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
RotationTo:     LD IY, PLAYER_ADR
                CALL Object.DeltaPosition

                ; In:
                ;   DE - дельта значений знаковое число (D - y, E - x)
                ; Out :
                ;   A  - номер сектора [0..15] << 3
                JP Math.Atan

                endif ; ~_MODULE_GAME_OBJECT_NPC_ROTATION_TO_TARGET_
