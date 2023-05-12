
                ifndef _CORE_MODULE_DIALOG_CURSOR_DRAW_
                define _CORE_MODULE_DIALOG_CURSOR_DRAW_
HEIGHT_ROW      EQU 9                                                           ; высота строки (в пикселях)
; -----------------------------------------
; отображение курсора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           LD HL, GameState.Cursor
                LD A, (HL)
                INC L
                INC A
                JR Z, .Draw
                DEC A

                CP (HL)
                RET Z                                                           ; позиция не изменилась

                PUSH AF
                PUSH HL
.Clear          LD A, (HL)
                LD C, '^' - 32
                CALL .DrawCursor
                POP HL
                POP AF

.Draw           ; обновить старую позицию (отк повторной отрисовки)
                LD (HL), A
                LD C, '>' - 32

.DrawCursor     ; положение курсора
                INC L
                INC L
                LD E, (HL)
                INC L
                LD D, (HL)
                
                ; расчёт положение курсора
                INC A
                LD B, A
                LD A, -9

.Mult           ADD A, HEIGHT_ROW
                DJNZ .Mult

                ADD A, D
                LD D, A
                LD A, C

                ; -----------------------------------------
                ; отображение символа на экране
                ; In:
                ;   A  - ID символа (символ - 32)
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                JP Draw.Char

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_DRAW_
