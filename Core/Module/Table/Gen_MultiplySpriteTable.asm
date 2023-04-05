                ifndef _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_
                define _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_

                module Tables
; -----------------------------------------
; генерация таблица умножения для расчёта размера (без учёта маски)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | 0  | W1 | W0 | R4 | R3 | R2 | R1 | R0 |
;   +----+----+----+----+----+----+----+----+
;
;   W1,W0   [6,5]   - ширина спрайта в знакоместах
;   R4-R0   [4..0]  - количество строк
;
;   Width - ширина спрайта      1-4 байта
;   Row   - количество строк    1-32 строки
;
;   размер таблицы 128 байт
; -----------------------------------------
Gen_MulSprTable ;
                LD HL, Adr.MultiplySprite
                LD DE, #0401
.RowLoop        XOR A
                LD B, #20
.WidthLoop      ADD A, E
                LD (HL), A
                INC L
                DJNZ .WidthLoop
                INC E
                DEC D
                JR NZ, .RowLoop

                RET

                display " - Multiply sprite table generation:\t\t\t", /A, Gen_MulSprTable, " = busy [ ", /D, $ - Gen_MulSprTable, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_
