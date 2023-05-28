
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_
; -----------------------------------------
; обработка тика "топливо"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gas_Tick:       LD A, (IX + FObject.EnginePower)
                OR A
                RET Z

                ; поменять знак, если едет задом
                JP P, $+5
                NEG

                ; подсчёт пройденого пути
                LD D, #00
                LD E, A
                LD HL, (.Distance)
                ADD HL, DE
                LD (.Distance), HL

                ; пройденое расстояние 
                ifdef _DEBUG
                LD (PlayerState.DebugX), HL
                endif

                RET NC                                                          ; выход, если расчётное расстояние не пройдено

                LD HL, -32768                                                   ; расход бензака
                LD (.Distance), HL

                ; уменьшить количество бензака
                LD A, (IX + FObject.Character.Gas)
                DEC A
                RET Z
                LD (IX + FObject.Character.Gas), A

                RET

.Distance       DW -32768                                                       ; расход бензака

                display "\t- Gas tick:\t\t\t\t\t", /A, Gas_Tick, " = busy [ ", /D, $ - Gas_Tick, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_GAS_TICK_
