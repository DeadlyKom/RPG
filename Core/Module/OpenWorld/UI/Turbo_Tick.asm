
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_
; -----------------------------------------
; обработка тика "топливо"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Turbo_Tick:     ; проверка включенного турбонаддува
                CHECK_PLAYER_INPUT_FLAG TURBOCHARGING_BIT
                JR Z, .Accumulation                                             ; проверка накопления энергии нагнетателя
                
                ; какова мощность двигателя
                LD A, (IX + FObject.EnginePower)
                OR A
                RET Z
                RET M                                                           ; выход, если едет задом

                ; подсчёт пройденого пути
                LD D, #00
                LD E, A
                LD HL, (.Distance)
                ADD HL, DE
                LD (.Distance), HL

                ; пройденое расстояние 
                ifdef _DEBUG
                LD (PlayerState.DebugY), HL
                endif

                RET NC                                                          ; выход, если расчётное расстояние не пройдено

                LD HL, -16                                                      ; расход энергии нагнетателя
                LD (.Distance), HL

                ; сброс времени начала накопления энергии нагнетателя
                LD HL, .Delay
                LD (HL), #50

                ; уменьшить количество энергии нагнетателя
                LD A, (IX + FObject.Character.Turbo)
                DEC A
                RET Z
                LD (IX + FObject.Character.Turbo), A

                RET

.Accumulation   ; отсчёт времени накопления
                LD HL, .Delay
                DEC (HL)
                RET NZ

                ; при нулевой скорости восстановление происходит быстрей
                LD A, (IX + FObject.EnginePower)
                OR A

                LD (HL), #10
                JR Z, $+4
                LD (HL), #30

                ; увеличение энергии нагнетателя
                LD A, (IX + FObject.Character.Turbo)
                INC A
                RET Z
                LD (IX + FObject.Character.Turbo), A

                RET
.Distance       DW -16                                                          ; расход энергии нагнетателя
.Delay          DB #09                                                          ; скорость накопления энергии нагнетателя

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_TURBO_TICK_
