                ifndef _CORE_MODULE_TABLE_GENERATION_SHIFT_TABLE_
                define _CORE_MODULE_TABLE_GENERATION_SHIFT_TABLE_

                module Tables
; -----------------------------------------
; генерация таблицы сдвигов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_ShiftTable: ;
                

                RET

                display " - Shift table generation:\t\t\t\t", /A, Gen_ShiftTable, " = busy [ ", /D, $ - Gen_ShiftTable, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATION_SHIFT_TABLE_
