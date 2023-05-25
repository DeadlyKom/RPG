
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_ANIMATION_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_ANIMATION_
; -----------------------------------------
; обработка анимации флаг видимости UI значка "топливо"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gas_Anim        ; проверка что количество бензака менее 1/4
                LD A, (PlayerState.Gas + 0)
                CP 256 / 4
                JR C, .Less

.More           ; установка видимости спрайта, если необходимо
                LD A, (PlayerState.Wasteland_SF)
                BIT VISIBLE_GAS_BIT, A
                RET NZ
                OR VISIBLE_GAS
                JR .SetVisible

.Less           ; проверка отрисовки предыдущих кадров
                LD HL, PlayerState.Wasteland_SF
                LD A, (HL)
                AND RENDER_GAS_FORCE
                RET NZ

                ; отсчёт задержки
                LD HL, .Delay
                DEC (HL)
                RET NZ

                ; смена видимости спрайта
                LD A, (PlayerState.Wasteland_SF)
                XOR VISIBLE_GAS
.SetVisible     LD (PlayerState.Wasteland_SF), A

                ; установка значения по умолчанию
                LD HL, .Delay
                LD (HL), #09                                                    ; темп мигания
                
                ; установить флаг обновления
                LD HL, PlayerState.Wasteland_RF
                LD A, (HL)
                OR RENDER_GAS_FORCE
                LD (HL), A

                RET
.Delay          DB #09

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_ANIMATION_
