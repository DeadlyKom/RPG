
                ifndef _MODULE_GAME_RENDER_WASTELAND_UI_INITIALIZE_
                define _MODULE_GAME_RENDER_WASTELAND_UI_INITIALIZE_
; -----------------------------------------
; отображение UI карты мира (инициализация)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; инициализация UI значка "сердце", "канистра", "нагнетатель", "слот"
                LD HL, PlayerState.Wasteland_RF
                LD A, (HL)
                OR RENDER_HEALTH_FORCE | RENDER_GAS_FORCE | RENDER_TURBO_FORCE | RENDER_SLOT_FORCE
                LD (HL), A
               
                LD HL, PlayerState.Wasteland_SF
                LD (HL), VISIBLE_HEALTH | VISIBLE_GAS | VISIBLE_TURBO | VISIBLE_SLOT
                
                CALL BackBar
                JP BackFrame

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_UI_INITIALIZE_
