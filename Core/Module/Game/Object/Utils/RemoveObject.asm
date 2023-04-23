
                ifndef _MODULE_GAME_OBJECT_UTILS_REMOVE_OBJECT_
                define _MODULE_GAME_OBJECT_UTILS_REMOVE_OBJECT_
; -----------------------------------------
; пометить объект как удалённый
; In:
; Out:
;   сброшен флаг переполнения, объект не видим
; Corrupt:
; Note:
; -----------------------------------------
Remove          LD (IX + FObjectDecal.Type), OBJECT_EMPTY_ELEMENT
                LD HL, GameState.Objects
                DEC (HL)
                RET

                endif ; ~_MODULE_GAME_OBJECT_UTILS_REMOVE_OBJECT_
