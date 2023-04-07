                ifndef _CORE_MODULE_TABLE_GENERATION_PRNG_
                define _CORE_MODULE_TABLE_GENERATION_PRNG_

                module Tables
; -----------------------------------------
; генерация PRNG карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_PRNG:       ; установка seed
                LD BC, (110);(GameConfig.Seed)
                CALL Math.SetSeed16

                CALL Math.Rand8
                INC A
                ADD A, A
                LD A, #54
                LD (Math.PN_Frequency), A
                LD (GameConfig.Frequency), A

                LD HL, #0000
                LD (GameState.PositionX + 1), HL
                LD HL, #0000
                LD (GameState.PositionY + 1), HL
                LD HL, #1000
                LD (GameState.PositionX + 3), HL
                LD (GameState.PositionY + 3), HL

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

                display " - PRNG generation: \t\t\t\t\t", /A, Gen_PRNG, " = busy [ ", /D, $ - Gen_PRNG, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATION_PRNG_