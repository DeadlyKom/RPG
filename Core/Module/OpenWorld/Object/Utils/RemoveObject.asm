
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UTILS_REMOVE_OBJECT_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UTILS_REMOVE_OBJECT_
; -----------------------------------------
; пометить объект как удалённый
; In:
; Out:
;   сброшен флаг переполнения, объект не видим
; Corrupt:
; Note:
; -----------------------------------------
Remove          ;
                LD A, (IX + FObjectDecal.Type)
                AND IDX_OBJECT_TYPE
                ; JP Z, .SpawnPlayer                                              ; OBJECT_PLAYER
                RET Z

                LD (IX + FObjectDecal.Type), OBJECT_EMPTY_ELEMENT
                LD HL, GameState.Objects
                DEC (HL)
                RET

; .SpawnPlayer    CALL Game.Initialize.Player
;                 CALL Game.Render.World.UI.DrawInit                              ; обновление UI (после инициализации всего)
                
;                 SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
;                 LD DE, #8060
;                 LD BC, OBJECT_PLAYER
;                 LD IY, PLAYER_ADR
;                 JP Kernel.Initialize.Player

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UTILS_REMOVE_OBJECT_
