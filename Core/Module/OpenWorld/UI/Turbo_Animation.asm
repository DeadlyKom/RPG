
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_ANIMATION_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_ANIMATION_
; -----------------------------------------
; обработка анимации флаг видимости UI значка "турбо"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Turbo_Anim      ; проверка включенного турбонаддува
                CHECK_PLAYER_INPUT_FLAG TURBOCHARGING_BIT
                RET Z

                ; проверка что не езда задом
                CHECK_FLAG DECREASE_SPEED_BIT
                RET NZ

                ; проверка что количество очков не на нуле
                LD A, (PlayerState.Turbo + 0)
                DEC A
                RET Z
                
                ; отсчёт задержки
                LD HL, .Delay
                DEC (HL)
                RET NZ

                ; смена спрайта
                LD A, (PlayerState.Wasteland_SF)
                XOR SPRITE_TURBO
                LD (PlayerState.Wasteland_SF), A

                ; установка значения по умолчанию
                LD (HL), #02                                                    ; темп вращения
                
                ; установить флаг обновления
                LD HL, PlayerState.Wasteland_RF
                LD A, (HL)
                OR RENDER_TURBO_FORCE
                LD (HL), A

                RET
.Delay          DB #02

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_ANIMATION_
