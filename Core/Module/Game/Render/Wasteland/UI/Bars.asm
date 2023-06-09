
                ifndef _MODULE_GAME_RENDER_WASTELAND_UI_BAR_
                define _MODULE_GAME_RENDER_WASTELAND_UI_BAR_
BarRowNum       EQU  62
; -----------------------------------------
; отображение баров
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
BackBar:        SET_PAGE_GRAPHICS_1                                             ; включить страницу графики
                
                ; копирование спрайта в буфер общего назначения
                LD HL, Graphics.UI.Bar
                LD DE, SharedBuffer
                LD BC, Graphics.UI.Bar.Size
                CALL Memcpy.FastLDIR

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

                ; -----------------------------------------
                ; отрисовка спрайта с атрибутами
                ; In:
                ;   HL - адрес спрайта
                ;   DE - координаты в знакоместах (D - y, E - x)
                ;   BC - размер (B - y, C - x)
                ; Out:
                ; Corrupt:
                ; Note:
                ; -----------------------------------------
                LD HL, SharedBuffer
                LD DE, #0201
                LD BC, #0603
                JP Draw.AttrSprOne
; -----------------------------------------
; повышение уровня прогресс бара
; In:
;   D    - величина инкремента  (-1)
;   E    - номер бара
;   BC   - адрес значения уровня
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
IncBar:         ; инкремент
                LD A, (BC)
                INC A
                RET Z                                                           ; выход, если значение максимальное
                DEC A

                ADD A, D
                JR NC, .NotOverflow
                LD A, #FF
.NotOverflow    LD (BC), A

.Update         ; сохранение смещения по горизонтали
                EX AF, AF'
                LD A, E
                EX AF, AF'

                ; расчёт смещения прогресс бара
                CALL CalcProgress

                ; проверка что уровень выше предыдущего
                INC C
                LD A, (BC)
                SUB H
                RET Z                                                           ; выход, если уровень прогресса не изменился
                LD D, A

                ; восстановление смещения по горизонтали
                EX AF, AF'
                LD E, A

                ; обновить значение
                LD A, (BC)
                INC A
                NEG
                ADD A, BarRowNum

                ; расчёт адреса строки в экранной области
                LD H, HIGH Adr.ScrAdrTable
                LD L, A
                LD A, (HL)
                ADD A, E                                                        ; добавление смещения по горизонтали
                INC H
                LD H, (HL)
                LD L, A

                LD A, D
                NEG
                LD D, A

                LD A, (BC)
                ADD A, D
                LD (BC), A

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

.Loop           ; отображение
                RES 7, H
                LD (HL), %01111110
                SET 7, H
                LD (HL), %01111110

                ; классический метод "UP HL" 25/59
                LD A, H
                DEC H
                AND #07
                JP NZ, $+12
                LD A, L
                ADD A, #E0
                LD L, A
                SBC A, A
                AND #08
                ADD A, H
                LD H, A

                DEC D
                JR NZ, .Loop

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                RET
; -----------------------------------------
; понижение уровня прогресс бара
; In:
;   D    - величина инкремента  (-1)
;   E    - номер бара
;   BC   - адрес значения уровня
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DecBar:         ; декремент
                LD A, (BC)
                OR A
                RET Z                                                           ; выход, если значение минимальное

                DEC A
                SUB D
                JR NC, .NotOverflow
                XOR A
.NotOverflow    LD (BC), A

                ; сохранение смещения по горизонтали
                EX AF, AF'
                LD A, E
                EX AF, AF'

                ; расчёт смещения прогресс бара
                CALL CalcProgress

                ; проверка что уровень ниже предыдущего
                INC C
                LD A, (BC)
                SUB H
                RET Z                                                           ; выход, если уровень прогресса не изменился
                LD D, A

                ; восстановление смещения по горизонтали
                EX AF, AF'
                LD E, A

                ; обновить значение
                LD A, (BC)
                NEG
                ADD A, BarRowNum

                ; расчёт адреса строки в экранной области
                LD H, HIGH Adr.ScrAdrTable
                LD L, A
                LD A, (HL)
                ADD A, E                                                        ; добавление смещения по горизонтали
                INC H
                LD H, (HL)
                LD L, A

                LD A, (BC)
                SUB D
                LD (BC), A

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана

.Loop           ; отображение
                RES 7, H
                LD (HL), %01000010
                SET 7, H
                LD (HL), %01000010

                ; классический метод "DOWN HL" 25/59
                INC H
                LD A, H
                AND #07
                JP NZ, $+12
                LD A, L
                SUB #E0
                LD L, A
                SBC A, A
                AND #F8
                ADD A, H
                LD H, A

                DEC D
                JR NZ, .Loop

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                RET
; -----------------------------------------
; расчёт смещения прогресс бара
; In:
;   A  - прогресс
; Out:
;   H  - смещение прогресса 
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
CalcProgress:   ; расчёт смещения прогресс бара
                LD D, #00
                LD E, A
                INC DE
                LD A, #2C
                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                JP Math.Mul16x8_16

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_UI_BAR_
