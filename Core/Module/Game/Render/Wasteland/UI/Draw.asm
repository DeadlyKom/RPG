
                ifndef _MODULE_GAME_RENDER_UI_DRAW_
                define _MODULE_GAME_RENDER_UI_DRAW_
; -----------------------------------------
; отображение/обновление UI карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                CALL AnimationTurbo

.T3             EQU $+1
                LD A, 64
                DEC A
                JR NZ, .Set3

                LD HL, PlayerState.Gas + 2
                LD A, (HL)
                SUB 1
                CP #7F
                JR NC, .L13
                LD A, #80
.L13            LD (HL), A    

                LD A, 64
.Set3           LD (.T3), A

                CHECK_PLAYER_FLAG DECREASE_SPEED_BIT
                JR NZ, .LL12

                CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                JR NZ, .Set22
.LL12
.T2             EQU $+1
                LD A, #10
                DEC A
                JR NZ, .Set2

                LD HL, PlayerState.Turbo + 2
                LD A, (HL)
                INC A
                CP #7E
                JR C, .L12
                LD A, #7F
.L12            LD (HL), A

.Set22          LD A, #10
.Set2           LD (.T2), A

                RET
; -----------------------------------------
; анимация турбонаддува
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimationTurbo: CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                RET Z

                CHECK_FLAG DECREASE_SPEED_BIT
                RET NZ

                LD A, (PlayerState.Turbo + 0)
                OR A
                RET Z

.Counter        EQU $+1
                LD A, #01
                DEC A
                JR NZ, .Set

                LD HL, .Animation
                INC (HL)
                LD A, (HL)
                AND #01
                CALL Turbo

                LD A, #01
.Set            LD (.Counter), A

                RET
.Animation      DB #00

                endif ; ~_MODULE_GAME_RENDER_UI_DRAW_
