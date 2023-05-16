
                ifndef _MODULE_GAME_RENDER_UI_UPDATE_
                define _MODULE_GAME_RENDER_UI_UPDATE_
; -----------------------------------------
; отображение/обновление UI элементов в режиме пустошь
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Update:         ; проверка неободимости отрисовки UI значка "сердце"
                LD HL, PlayerState.Wasteland_RF
                BIT RENDER_HEALTH_BIT, (HL)
                CALL NZ, Heart

                ; проверка неободимости отрисовки UI значка "канистра"
                LD HL, PlayerState.Wasteland_RF
                BIT RENDER_GAS_BIT, (HL)
                CALL NZ, Gas

                ; проверка неободимости отрисовки UI значка "нагнетатель"
                LD HL, PlayerState.Wasteland_RF
                BIT RENDER_TURBO_BIT, (HL)
                CALL NZ, Turbo

                ; проверка неободимости отрисовки UI значка "слот"
                LD HL, PlayerState.Wasteland_RF
                BIT RENDER_SLOT_BIT, (HL)
                CALL NZ, Slot

                ; сдвиг флагов отображения
                LD HL, PlayerState.Wasteland_RF
                LD A, (HL)
                ADD A, A
                AND RENDER_SHIFT_MASK
                LD (HL), A
                RET

                endif ; ~_MODULE_GAME_RENDER_UI_UPDATE_
