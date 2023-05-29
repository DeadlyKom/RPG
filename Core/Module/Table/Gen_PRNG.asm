                ifndef _CORE_MODULE_TABLE_GENERATOR_PRNG_
                define _CORE_MODULE_TABLE_GENERATOR_PRNG_

                module Tables
; -----------------------------------------
; генерация PRNG карты мира
; In:
; Out:
; Corrupt:
; Note:
;   должен быть установлен seed генерации
; -----------------------------------------
Gen_PRNG:       ; инициализация генерации
                LD HL, Adr.PRNG

.Loop           ; генерация таблицы PRNG
                EXX
                CALL Math.Rand8
                EXX
                LD (HL), A
                INC L
                JR NZ, .Loop

                RET

                display "\t- PRNG generator:\t\t\t\t", /A, Gen_PRNG, " = busy [ ", /D, $ - Gen_PRNG, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATOR_PRNG_
