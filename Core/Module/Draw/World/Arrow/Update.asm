                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_UPDATE_
                define _CORE_MODULE_DRAW_WORLD_ARROW_UPDATE_
; -----------------------------------------
; обновление стрелки (направление ближайшего врага)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Update:         CALL Nearest
                RET NC
                CALL Prepare
                JP Draw

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_UPDATE_
