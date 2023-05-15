
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_TICK_ANIMATION_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_TICK_ANIMATION_
; -----------------------------------------
; обработка анимации прогресс бара
; In:
;   HL - адрес значения delay
;   D  - значение delay по умолчанию
;   E  - ID прогресс бара
; -----------------------------------------
Bar_Animation   ; проверка убнуление счётчика задержки
                LD A, (HL)
                DEC (HL)
                OR A
                RET NZ
                LD (HL), D                                                      ; установка значения по умолчанию

                ; проверка необходимости приращения
                DEC L
                LD A, (HL)
                OR A
                RET Z                                                           ; выход, если приращение отсутствует

                ; инициализация
                LD B, H
                LD C, L
                LD L, A                                                         ; сохранение значения приращения

                ; применение функции ease-out
                rept 3
                SRA A
                JP M, $+5
                ADC A, #00
                endr

                ; вычесть значение из приращения
                LD D, A
                NEG
                LD H, A
                ADD A, L
                LD (BC), A

                ; подготовка визуализации приращения
                DEC C
                DEC C

                ; -----------------------------------------
                ; повышение/понижение уровня прогресс бара
                ; In:
                ;   D    - величина инкремента (+/-)
                ;   E    - номер бара
                ;   BC   - адрес фактического значения
                ; -----------------------------------------
                LD A, L
                OR A
                JP P, Packs.Wasteland.Render.UI.IncBar

                LD D, H
                DEC D
                JP Packs.Wasteland.Render.UI.DecBar

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_TICK_ANIMATION_
