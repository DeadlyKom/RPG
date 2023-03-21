
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
WorldSprTable   EQU WORLD_TILE_NUM * 2                                          ; размер таблицы спрайтов карты мира
PRNG            EQU #0100                                                       ; размер таблицы генерации карты мира

                module Module
                endmodule
                endmodule

                module Adr
EntryPoint      EQU Adr.PRNG + Size.PRNG
WorldSprTable   EQU MemBank_03_                                                 ; адрес таблицы спрайтов карты мира
WorldSpr        EQU 2 + WorldSprTable + Size.WorldSprTable                      ; 2 первых байта буферная зона порчи стека
GameConfig      EQU Adr.GameVar_A                                               ; 32 байта переменных конфигурации игры
GameState       EQU Adr.GameVar_B                                               ; 32 байта переменных состояние игры
                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GAME_
