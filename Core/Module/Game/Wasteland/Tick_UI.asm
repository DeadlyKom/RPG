
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
Tick_UI:        ;
                LD IX, PLAYER_ADR
                LD A, (IX + FObject.Character.Health)
                LD HL, PlayerState.Health
                SUB (HL)
                JP P, $+5
                LD A, #7F
                INC L
                INC L
                LD (HL), A

                LD IX, PLAYER_ADR
                LD A, (IX + FObject.Character.Gas)
                LD HL, PlayerState.Gas
                SUB (HL)
                JP P, $+5
                LD A, #7F
                INC L
                INC L
                LD (HL), A

                LD IX, PLAYER_ADR
                LD A, (IX + FObject.Character.Turbo)
                LD HL, PlayerState.Turbo
                SUB (HL)
                JP P, $+5
                LD A, #7F
                INC L
                INC L
                LD (HL), A
                
                ; анимационный тик прогресс баров
                LD HL, PlayerState.Health + 3
                LD DE, (0x01 << 8) | HEALTH_BAR
                CALL Packs.OpenWorld.UI.Bar_Animation

                LD HL, PlayerState.Gas + 3
                LD DE, (0x02 << 8) | GAS_BAR
                CALL Packs.OpenWorld.UI.Bar_Animation

                LD HL, PlayerState.Turbo + 3
                LD DE, (0x00 << 8) | TURBO_BAR
                JP Packs.OpenWorld.UI.Bar_Animation

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_UI_BAR_TICK_
