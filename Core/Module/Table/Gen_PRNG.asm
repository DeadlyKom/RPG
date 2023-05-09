                ifndef _CORE_MODULE_TABLE_GENERATOR_PRNG_
                define _CORE_MODULE_TABLE_GENERATOR_PRNG_

                module Tables
; -----------------------------------------
; генерация PRNG карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_PRNG:       ; установка seed
                LD BC, (GameConfig.Seed)
                CALL Math.SetSeed16
                CALL Math.Rand8
                
                ; установка frequency
                LD A, (GameConfig.Frequency)
                LD (Math.PN_Frequency), A

                ; инициализация генерации
                LD HL, Adr.PRNG

.Loop           ; генерация таблицы PRNG
                EXX
                CALL Math.Rand8
                EXX
                LD (HL), A
                INC L
                JR NZ, .Loop

                RET

                display " - PRNG generator: \t\t\t\t\t", /A, Gen_PRNG, " = busy [ ", /D, $ - Gen_PRNG, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATOR_PRNG_
