
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

                CALL AnimationBars
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
; установка начального уровня прогресс бара
; In:
;   D    - величина инкремента  (-1)
;   E    - номер прогресс бара
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetBar:         ; расчёт адреса прогресс бара
                LD A, E
                DEC A
                LD C, A
                ADD A, A    ; x2
                ADD A, C    ; x3
                ADD A, LOW PlayerState.Health
                LD C, A
                ADC A, HIGH PlayerState.Health
                SUB C
                LD B, A

                ; обнуление значения
                INC C
                XOR A
                LD (BC), A
                INC C
                LD (BC), A
                DEC C
                DEC C

                JP IncBar
; -----------------------------------------
; установка начального уровня прогресс баров
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetBars:        ; обнуление значения жизни
                LD BC, PlayerState.Health + 1
                XOR A
                LD (BC), A
                INC C
                LD (BC), A
                DEC C
                DEC C

                LD A, (BC)
                LD D, A
                LD E, #01
                CALL IncBar.Update

                ; обнуление значения бензина
                LD BC, PlayerState.Gas + 1
                XOR A
                LD (BC), A
                INC C
                LD (BC), A
                DEC C
                DEC C

                LD A, (BC)
                LD D, A
                LD E, #02
                CALL IncBar.Update

                ; обнуление значения турбо
                LD BC, PlayerState.Turbo + 1
                XOR A
                LD (BC), A
                INC C
                LD (BC), A
                DEC C
                DEC C

                LD A, (BC)
                LD D, A
                LD E, #03
                JP IncBar.Update
; -----------------------------------------
; анимация прогресс бара
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimationBars:  LD E, HEALTH_BAR
                LD BC, PlayerState.Health + 2
                CALL .Ainmation

                LD E, GAS_BAR
                LD BC, PlayerState.Gas + 2
                CALL .Ainmation

                LD E, TURBO_BAR
                LD BC, PlayerState.Turbo + 2

.Ainmation      ;
                LD A, (BC)
                OR A
                RET Z
                LD L, A

                rept 3
                SRA A
                JP M, $+5
                ADC A, #00
                endr
                
                LD D, A
                NEG
                LD H, A
                ADD A, L
                LD (BC), A

                DEC C
                DEC C

                LD A, L
                OR A
                JP P, IncBar

                LD D, H
                DEC D
                JP DecBar
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
