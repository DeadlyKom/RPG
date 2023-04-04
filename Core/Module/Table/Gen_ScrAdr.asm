                ifndef _CORE_MODULE_TABLE_GENERATION_SCREEN_ADDRESS_
                define _CORE_MODULE_TABLE_GENERATION_SCREEN_ADDRESS_

                module Tables
; -----------------------------------------
; генерация адресов экрана (строк)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_ScrAdr:     LD HL, Adr.ScrAdrTable
                LD DE, #38C0                                                    ; константы
                LD B, E

.Loop           ; расчёт младший байт
                LD A, L
                AND D
                ADD A, A
                ADD A, A
                LD (HL), A

                INC H

                ; расчёт старший байт
                LD A, L
                AND E
                RRA
                RRA
                RRA
                XOR L
                AND D
                XOR L
                OR E
                LD (HL), A
                
                DEC H
                INC L
                DJNZ .Loop

                RET

                display " - Screen address table generation:\t\t\t", /A, Gen_ScrAdr, " = busy [ ", /D, $ - Gen_ScrAdr, " bytes  ]"
                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATION_SCREEN_ADDRESS_
