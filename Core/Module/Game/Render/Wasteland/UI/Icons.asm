
                ifndef _MODULE_GAME_RENDER_UI_ICONS_
                define _MODULE_GAME_RENDER_UI_ICONS_
; -----------------------------------------
; отображение UI значка "сердце"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Heart:          ; проверка видимости значка
                LD A, (PlayerState.Wasteland_SF)
                BIT VISIBLE_HEALTH_BIT, A
                SCREEN_ADR_REG DE, #C000, 1 * 8, 8 * 8
                JR Z, ClearIcon

                PUSH DE

                ; стартовый адрес спрайта
                BIT SPRITE_HEALTH_BIT, A
                LD HL, Graphics.UI.Heart._0
                JR Z, $+5
                LD HL, Graphics.UI.Heart._1

                ; установить страницу графики
                SET_PAGE_GRAPHICS_1                                             ; включить страницу графики
                
                ; копирование спрайта в буфер общего назначения
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Heart.Size
                LDIR

                SET_PAGE_SHADOW_SCREEN                                          ; установка страницы невидимого экрана

                LD HL, SharedBuffer
                POP DE
                ; -----------------------------------------
                ; отрисовка знакоместа с атрибутами (в одном экране)
                ; In:
                ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                ; -----------------------------------------
                JP Draw.AttrCharOne
; -----------------------------------------
; отображение иконци бензина
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gas:            ; проверка видимости значка
                LD A, (PlayerState.Wasteland_SF)
                BIT VISIBLE_GAS_BIT, A
                SCREEN_ADR_REG DE, #C000, 2 * 8, 8 * 8
                JR Z, ClearIcon

                PUSH DE

                ; установить страницу графики
                SET_PAGE_GRAPHICS_1                                             ; включить страницу графики
                
                ; копирование спрайта в буфер общего назначения
                LD HL, Graphics.UI.Gas
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Gas.Size
                LDIR

                SET_PAGE_SHADOW_SCREEN                                          ; установка страницы невидимого экрана

                LD HL, SharedBuffer
                POP DE
                ; -----------------------------------------
                ; отрисовка знакоместа с атрибутами (в одном экране)
                ; In:
                ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                ; -----------------------------------------
                JP Draw.AttrCharOne
; -----------------------------------------
; отображение иконки турбонаддува
; In:
;   A - номер спрайта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Turbo:          ; проверка видимости значка
                LD A, (PlayerState.Wasteland_SF)
                BIT VISIBLE_TURBO_BIT, A
                SCREEN_ADR_REG DE, #C000, 3 * 8, 8 * 8
                JR Z, ClearIcon

                PUSH DE

                ; стартовый адрес спрайта
                BIT SPRITE_TURBO_BIT, A
                LD HL, Graphics.UI.Turbo._0
                JR Z, $+5
                LD HL, Graphics.UI.Turbo._1

                ; установить страницу графики
                SET_PAGE_GRAPHICS_1                                             ; включить страницу графики
                
                ; копирование спрайта в буфер общего назначения
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Turbo.Size
                LDIR

                SET_PAGE_SHADOW_SCREEN                                          ; установка страницы невидимого экрана

                LD HL, SharedBuffer
                POP DE
                ; -----------------------------------------
                ; отрисовка знакоместа с атрибутами (в одном экране)
                ; In:
                ;   HL - адрес спрайта
                ;   DE - адрес экрана пикселей
                ; -----------------------------------------
                JP Draw.AttrCharOne
; -----------------------------------------
; очистка UI значка
; In:
;   DE - адрес экрана
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearIcon:      SET_PAGE_SHADOW_SCREEN                                          ; установка страницы невидимого экрана
                XOR A
                dup 7
                LD (DE), A
                INC D
                edup
                LD (DE), A
                RET

                endif ; ~_MODULE_GAME_RENDER_UI_ICONS_
