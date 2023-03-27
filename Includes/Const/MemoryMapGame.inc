
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
WorldSpr        EQU #2000                                                       ; размер спрайтов карты мира (тайлопары)
MinimapSpr      EQU #80                                                         ; размер спрайта миникарты 

                module Module
                endmodule
                endmodule

                module Adr
EntryPoint      EQU Adr.PRNG + Size.PRNG
WorldSpr        EQU #F000                                                       ; адрес спрайтов карты мира (тайлопары)                         [выровненый по границе 4096 байт]
MinimapSpr      EQU #EF80                                                       ; адрес спрайта миникарты (необходим для генерации тайлопар)
GameConfig      EQU Adr.GameVar_A                                               ; 32 байта переменных конфигурации игры
GameState       EQU Adr.GameVar_B                                               ; 32 байта переменных состояние игры
                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GAME_
