
                ifndef _CONST_MEMORY_MAP_GAME_
                define _CONST_MEMORY_MAP_GAME_

                module Page
                module Module
Game            EQU PAGE_5                                                      ; модуль "основной блок"
Kernel          EQU PAGE_2                                                      ; модуль "кернель"

                endmodule
                endmodule

                module Size
Stack           EQU #0100                                                       ; размер стека
ScrAdrTable     EQU #0200                                                       ; размер таблицы адресов экрана
PRNG            EQU #0100                                                       ; размер таблицы генерации карты мира
ShiftTable      EQU #0E00                                                       ; размер таблицы сдвигов
MultiplySprite  EQU #0080                                                       ; размер таблицы умножения для расчёта размера спрайта  (без учёта маски)
WorldSpr        EQU WORLD_SPRITE_SIZE_ALIGNED                                   ; размер спрайтов карты мира (тайлопары)
WorldSprTable   EQU #0400                                                       ; размер таблицы спрайтов карты мира
WorldTilepair   EQU #0100                                                       ; размер таблицы поиска тайлопар
MinimapSpr      EQU #0080                                                       ; размер спрайта миникарты 

                module Module
                endmodule
                endmodule

                module Adr
ScrAdrTable     EQU Adr.StackTop                                                ; адрес таблицы адресов экрана
PRNG            EQU Adr.ScrAdrTable + Size.ScrAdrTable                          ; адрес таблицы генерации карты мира (https://www.random.org/)
GameVar_A       EQU Adr.ScrAdrTable + 0x00C0                                    ; адрес переменных A (32 байта)
GameVar_B       EQU Adr.ScrAdrTable + 0x01C0                                    ; адрес переменных B (32 байта)
ShiftTable      EQU Adr.PRNG + Size.PRNG                                        ; адрес таблицы сдвигов
MultiplySprite  EQU Adr.ShiftTable + Size.ShiftTable                            ; адрес таблицы умножения для расчёта размера спрайта (без учёта маски) (128 свободно)
EntryPoint      EQU Adr.MultiplySprite + Size.MultiplySprite                    ; адрес точки входа
WorldSprTable   EQU #FC00                                                       ; адрес таблицы спрайтов карты мира (тайлопары)
WorldTilepair   EQU Adr.WorldSprTable - Size.WorldTilepair                      ; адрес таблицы поиска тайлопар
WorldSpr        EQU Adr.WorldTilepair - Size.WorldSpr                           ; адрес спрайтов карты мира (тайлопары)
MinimapSpr      EQU RenderBuffer + Size.MinimapSpr                              ; адрес спрайта миникарты (необходим для генерации тайлопар)
GameConfig      EQU Adr.GameVar_A                                               ; 32 байта переменных конфигурации игры
GameState       EQU Adr.GameVar_B                                               ; 32 байта переменных состояние игры
                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GAME_
