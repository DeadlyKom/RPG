
                ifndef _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
                define _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
; -----------------------------------------
; отображение маркеров карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayMarker:  CALL UI.DrawSettle
                CALL UI.DrawPlayer
                RET
                
                endif ; ~_MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
