
                ifndef _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_RIGHT_
                define _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_RIGHT_
; -----------------------------------------
; вывод правой части тайла
; In:
;   HL' - не используется
;   DE' - адрес буфера отображения (RenderBuffer)
;   B'  - счётчик тайлов отрисовки по вертикали
;   C'  - не используется
;   HL  - адрес экрана вывода
;   DE  - адрес возврата
;   BC  - первый два байта спрайта
;   SP  - адрес спрайта +2
;   IX  - адрес функции Up
;   IY  - адрес функции Down
; Out:
; Corrupt:
; Note:
; -----------------------------------------
NoShiftRight    ; +1.0 байт
.x8             ; прямой проход
                LD (HL), C

                ; обратный проход
                INC H
                POP BC
                LD (HL), B
                INC H
                POP BC

.x6             ; прямой проход
                LD (HL), C

                ; обратный проход
                INC H
                POP BC
                LD (HL), B
                INC H
                POP BC

.x4             ; прямой проход
                LD (HL), C

                ; обратный проход
                INC H
                POP BC
                LD (HL), B
                INC H
                POP BC

.x2             ; прямой проход
                LD (HL), C

                ; обратный проход
                INC H
                POP BC
                LD (HL), B

.x0             EX DE, HL
                JP (HL)

                display " - Draw function 'No Shift Right': \t\t\t", /A, NoShiftRight, " = busy [ ", /D, $ - NoShiftRight, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_RIGHT_
