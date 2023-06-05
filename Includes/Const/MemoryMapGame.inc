
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
ScrAdrTable     EQU #0400                                                       ; размер таблицы адресов экрана
PRNG            EQU #0100                                                       ; размер таблицы генерации карты мира
ShiftTable      EQU #0E00                                                       ; размер таблицы сдвигов
MultiplySprite  EQU #0080                                                       ; размер таблицы умножения для расчёта размера спрайта  (без учёта маски)
GameConfig      EQU 0x020                                                       ; размер переменных конфигурации игры
GameState       EQU #0020                                                       ; размер переменных состояния игры
PlayerState     EQU #0080                                                       ; размер переменных состояния игрока
EntryPoint      EQU #0100                                                       ; размер базового блока кода
SharedPoint     EQU #1000 - Size.EntryPoint                                     ; размер общего блока кода
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
SharedPoint     EQU Adr.EntryPoint + Size.EntryPoint                            ; адрес общей точки входа (код переносится из страниц для запуска)

                module Module
Game:
.Main           EQU Adr.EntryPoint                                              ; адрес модуля "основной блок"
.Shared         EQU Adr.SharedPoint                                             ; адрес модуля "общего блока"
                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GAME_
