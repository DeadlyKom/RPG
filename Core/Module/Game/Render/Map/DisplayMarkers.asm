
                ifndef _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
                define _MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
; -----------------------------------------
; отображение маркеров карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayMarker:  
                LD HL, .Counter
                DEC (HL)
                RET NZ
                LD (HL), #05

                INC HL
                DEC (HL)
                LD A, (HL)
                JR NZ, .Draw
                LD (HL), #01 + 1

.Draw           LD DE, #6080
                CALL UI.Player

                RET
.Counter        DB #01
.Anim           DB #01 + 1

                endif ; ~_MODULE_GAME_RENDER_MAP_DISPLAY_MAP_MARKER_
