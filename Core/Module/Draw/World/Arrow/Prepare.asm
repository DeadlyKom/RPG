                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
                define _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
; -----------------------------------------
; подготовка отрисовка стрелки (направление ближайшего врага)
; In:
;   DE - дельта расстояния знаковое (D - y, E - x)
; Out:
;   HL - позиция по горизонтали (12.4)
;   DE - позиция по вертикали (12.4)
;   A' - номер фрейма [0..15]
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        ; -----------------------------------------
                ; In:
                ;   DE - дельта значений знаковое число (D - y, E - x)
                ; Out :
                ;   A  - номер сектора [0..15] << 3
                ; -----------------------------------------
                CALL Math.Atan
                EX AF, AF'

                LD HL, #0800
                LD DE, #0600

                RET

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
