
                ifndef _MODULE_GAME_RENDER_MAP_UI_MARKER_
                define _MODULE_GAME_RENDER_MAP_UI_MARKER_
; -----------------------------------------
; отображение UI маркера поселения
; In:
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Settle:         LD HL, SpriteInfo.Markers.Settle
                JP Draw.AnimZero
; -----------------------------------------
; отображение UI маркера игрока
; In:
;   A  - номер анимации
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Player:         LD HL, SpriteInfo.Markers.Player
                JP Draw
; -----------------------------------------
; отображение UI маркера флага
; In:
;   A  - номер анимации
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Flag:           LD HL, SpriteInfo.Markers.Flag
                JP Draw
; -----------------------------------------
; отображение UI маркера точки интереса
; In:
;   A  - номер анимации
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InterestPoint:  LD HL, SpriteInfo.Markers.InterestPoint
                ; JP Draw
; -----------------------------------------
; отображение UI маркера
; In:
;   A  - номер анимации
;   HL - адрес структуры спрайта FSprite
;   DE - координаты в пикселях (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; расчёт адреса анимации спрайта
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                
.AnimZero       ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта
                
                ; -----------------------------------------
                ; установка позиции маркера
                ; -----------------------------------------

                PUSH HL

                ; инициализация
                XOR A

                ; установка позиции маркера
                LD H, A
                LD L, E
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x16
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали

                LD H, A
                LD L, D
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x16
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали

                POP HL

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                CALL Utils.SpriteParse

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------
                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

.RET            ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                include "Core/Module/Graphics/UI/MapMarkers/Info.inc"

                endif ; ~_MODULE_GAME_RENDER_MAP_UI_MARKER_
