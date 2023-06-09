
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_OR_XOR_SAVE_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_OR_XOR_SAVE_

                module OR_XOR_Save
Begin_NoShift:  EQU $
; -----------------------------------------
;
; In:
;   SP  - адрес спрайта
;   HL  - адрес экрана вывода (копия)
;   DE  - адрес экрана вывода
;   B   - количество строк в знакоместе
;   C   - количество отображаемых строк
;   H'  - старший байт адреса таблицы сдвига
;   DE' - адрес буфера
; Out:
; Corrupt:
; Note:
; -----------------------------------------

NoShiftLR:
; ._OX_XXX_X      POP AF
; ._OX_XX_X       POP AF
._OX_X_X        POP AF
                JP NoShift._OX_X
; ._OX_XX_XX      POP AF
; ._OX_X_XX       POP AF
;                 JP NoShift._OX_XX
; ._OX_X_XXX      POP AF
;                 JP NoShift._OX_XXX
NoShift:
; ._OX_XXXX       LD A, (DE)
;                 EXX
;                 POP BC
;                 OR C
;                 XOR B
;                 EXX
;                 LD (DE), A
;                 INC E
; ._OX_XXX        LD A, (DE)
;                 EXX
;                 POP BC
;                 OR C
;                 XOR B
;                 EXX
;                 LD (DE), A
;                 INC E

._OX_XX         LD A, (DE)

                EXX
                LD (DE), A                                                      ; сохранение фона
                INC DE
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E

._OX_X          LD A, (DE)

                EXX
                LD (DE), A                                                      ; сохранение фона
                INC DE
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
; NextRow:        ; новая строка
                DEC C
                JP Z, Kernel.Function.Exit
                INC D
                DJNZ .NextRow

                LD B, #08
                LD A, L
                ADD A, #20
                LD L, A
                JR C, .NextBoundary
                LD D, H                                                         ; восстановление адреса экрана
                LD E, L
                JP (IY)

.NextBoundary   LD H, D                                                         ; сохранение старший байт адреса экрана
.NextRow        LD E, L                                                         ; восстановление младший байт адреса экрана
                JP (IY)

TableNoShift:
.OX_8           DW NoShift._OX_X,       NoShift._OX_X                           ;  1.0

                DW NoShiftLR._OX_X_X,   NoShiftLR._OX_X_X                       ; -1.0
.OX_16          DW NoShift._OX_XX,      NoShift._OX_XX                          ;  2.0
                DW NoShift._OX_X,       NoShiftLR._OX_X_X                       ; +1.0

                display " - Draw function 'No Shift OR & XOR - Save':\t\t", /A, Begin_NoShift, " = busy [ ", /D, $ - Begin_NoShift, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_OR_XOR_SAVE_
