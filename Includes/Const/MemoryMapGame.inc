
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
GameConfig      EQU 0x020                                                       ; размер переменных конфигурации игры
GameState       EQU #0020                                                       ; размер переменных состояния игры
PlayerState     EQU #0080                                                       ; размер переменных состояния игрока
                module Module
                endmodule
                endmodule

                module Adr
ScrAdrTable     EQU Adr.StackTop                                                ; адрес таблицы адресов экрана
GameConfig      EQU Adr.ScrAdrTable + 0x00C0                                    ; адрес переменных конфигурации игры
GameState       EQU Adr.ScrAdrTable + 0x01C0                                    ; адрес переменных состояние игры
PRNG            EQU Adr.ScrAdrTable + Size.ScrAdrTable                          ; адрес таблицы генерации карты мира (https://www.random.org/)
ShiftTable      EQU Adr.PRNG + Size.PRNG                                        ; адрес таблицы сдвигов
MultiplySprite  EQU Adr.ShiftTable + Size.ShiftTable                            ; адрес таблицы умножения для расчёта размера спрайта (без учёта маски) (128 свободно)
PlayerState     EQU Adr.MultiplySprite + Size.MultiplySprite                    ; адрес переменных состояния игрока
EntryPoint      EQU Adr.PlayerState + Size.PlayerState                          ; адрес точки входа
WorldSprTable   EQU #FC00                                                       ; адрес таблицы спрайтов карты мира (тайлопары)
WorldTilepair   EQU Adr.WorldSprTable - Size.WorldTilepair                      ; адрес таблицы поиска тайлопар
WorldSpr        EQU Adr.WorldTilepair - Size.WorldSpr                           ; адрес спрайтов карты мира (тайлопары)
MinimapSpr      EQU RenderBuffer + Size.MinimapSpr                              ; адрес спрайта миникарты (необходим для генерации тайлопар)
                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GAME_
