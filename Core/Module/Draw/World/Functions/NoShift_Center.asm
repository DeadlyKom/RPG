
                ifndef _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_CENTER_
                define _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_CENTER_
; -----------------------------------------
; вывод тайла (полностью)
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
NoShiftCenter   ; 2.0 байт
.x8             ; прямой проход
                LD (HL), C
                INC L
                LD (HL), B

                ; обратный проход
                INC H
                POP BC
                LD (HL), C
                DEC L
                LD (HL), B
                INC H
                POP BC

.x6             ; прямой проход
                LD (HL), C
                INC L
                LD (HL), B

                ; обратный проход
                INC H
                POP BC
                LD (HL), C
                DEC L
                LD (HL), B
                INC H
                POP BC

.x4             ; прямой проход
                LD (HL), C
                INC L
                LD (HL), B

                ; обратный проход
                INC H
                POP BC
                LD (HL), C
                DEC L
                LD (HL), B
                INC H
                POP BC

.x2             ; прямой проход
                LD (HL), C
                INC L
                LD (HL), B

                ; обратный проход
                INC H
                POP BC
                LD (HL), C
                DEC L
                LD (HL), B

.x0             EX DE, HL
                JP (HL)

                display " - Draw function 'No Shift Center': \t\t\t", /A, NoShiftCenter, " = busy [ ", /D, $ - NoShiftCenter, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_WORLD_FUNCTION_NO_SHIFT_CENTER_
