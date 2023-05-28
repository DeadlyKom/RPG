
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_HEALTH_TICK_ANIMATION_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_HEALTH_TICK_ANIMATION_
; -----------------------------------------
; обработка анимации флаг видимости UI значка "сердце"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Health_Anim     ; отсчёт задержки
                LD HL, .Delay
                DEC (HL)
                RET NZ

                ; смена спрайта
                LD A, (PlayerState.Wasteland_SF)
                XOR SPRITE_HEALTH
                LD (PlayerState.Wasteland_SF), A

                ; установка значения по умолчанию, в зависимости от цикла
                BIT SPRITE_HEALTH_BIT, A
                LD (HL), #20                                                    ; темп сердцебиения
                JR Z, $+4
                LD (HL), #06
                
                ; установить флаг обновления
                LD HL, PlayerState.Wasteland_RF
                LD A, (HL)
                OR RENDER_HEALTH_FORCE
                LD (HL), A

                RET
.Delay          DB #04

                display "\t- Health animation:\t\t\t\t", /A, Health_Anim, " = busy [ ", /D, $ - Health_Anim, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_HEALTH_TICK_ANIMATION_
