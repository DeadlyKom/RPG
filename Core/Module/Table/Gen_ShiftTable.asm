                ifndef _CORE_MODULE_TABLE_GENERATOR_SHIFT_TABLE_
                define _CORE_MODULE_TABLE_GENERATOR_SHIFT_TABLE_

                module Tables
; -----------------------------------------
; генерация таблицы сдвигов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_ShiftTable: ;
                LD DE, Adr.ShiftTable
                LD BC, #0007

.ShiftLoop      LD H, #00
                LD A, B
                NEG
                LD L, A

                LD A, 7
                SUB C
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL

                EX DE, HL
                LD (HL), D
                INC H
                LD (HL), E
                DEC H
                INC L
                EX DE, HL
                
                DJNZ .ShiftLoop
                INC D
                INC D

                DEC C
                JR NZ, .ShiftLoop

                RET

                display " - Shift table generator:\t\t\t\t", /A, Gen_ShiftTable, " = busy [ ", /D, $ - Gen_ShiftTable, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATOR_SHIFT_TABLE_
