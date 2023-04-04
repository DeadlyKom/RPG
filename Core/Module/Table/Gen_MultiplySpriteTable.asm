                ifndef _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_
                define _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_

                module Tables
; -----------------------------------------
; генерация таблицы умножения для спрайтов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_MulSprTable ;


                RET

                display " - Multiply sprite table generation:\t\t\t", /A, Gen_MulSprTable, " = busy [ ", /D, $ - Gen_MulSprTable, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATION_MULTIPLY_SPRITE_TABLE_
