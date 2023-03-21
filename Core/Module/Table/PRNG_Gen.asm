                ifndef _CORE_MODULE_TABLE_PRNG_GENERATION_
                define _CORE_MODULE_TABLE_PRNG_GENERATION_

                module Tables
; -----------------------------------------
; генерация PRNG карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
PRNG_Gen:       ; установка seed
                LD BC, (0);(GameConfig.Seed)
                CALL Math.SetSeed16

                CALL Math.Rand8
                INC A
                ADD A, A
                LD A, #10
                LD (Math.PN_Frequency), A
                LD (GameConfig.Frequency), A

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

                display " - PRNG generation: \t\t\t\t\t", /A, PRNG_Gen, " = busy [ ", /D, $ - PRNG_Gen, " bytes  ]"
                endmodule

                endif ; ~ _CORE_MODULE_TABLE_PRNG_GENERATION_
