
                ifndef _MODULE_GAME_RENDER_WASTELAND_UI_BAR_TICK_
                define _MODULE_GAME_RENDER_WASTELAND_UI_BAR_TICK_
; -----------------------------------------
; тик прогресс баров
; In:
; Out:
; Corrupt:
; Note:
;   включить страницу работы с объектами
; -----------------------------------------
Tick_UI:        LD IX, PLAYER_ADR

                ; анимационный тик прогресс баров здоровья
                LD A, (IX + FObject.Character.Health)
                LD HL, PlayerState.Health
                LD DE, (0x00 << 8) | HEALTH_BAR
                CALL .Apply
                ; анимационный тик прогресс баров бензака
                LD A, (IX + FObject.Character.Gas)
                LD HL, PlayerState.Gas
                LD DE, (0x02 << 8) | GAS_BAR
                CALL .Apply
                ; анимационный тик прогресс баров турбонаддува
                LD A, (IX + FObject.Character.Turbo)
                LD HL, PlayerState.Turbo
                LD DE, (0x01 << 8) | TURBO_BAR

.Apply          SUB (HL)
                JP P, $+5
                LD A, #7F
                INC L
                INC L
                LD (HL), A
                INC L
                JP Packs.OpenWorld.UI.Bar_Animation

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_UI_BAR_TICK_
