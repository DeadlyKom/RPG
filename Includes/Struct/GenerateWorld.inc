
                ifndef _STRUCTURE_GENERATE_WORLD_
                define _STRUCTURE_GENERATE_WORLD_

                struct FGenerateWorld
TextSeed        TEXT 16, {"None", 0}                                            ; текстовое представление seed генерации мира
                                                                                ; из текста формируется seed и частота шума перлина
Difficulty      DB #00                                                          ; сложность
Climate         DB #00                                                          ; климат
MapSize         DB #00                                                          ; размер карты
Center          FLocation32                                                     ; центр генерируемого мира
TotalNumObject  DB #00                                                          ; общее количество объектов на карте
RadioactiveNum  DB #00                                                          ; количество радиоактивных зон              (позиция + радиус)
HabitatsNum     DB #00                                                          ; места обитания существ                    (позиция + радиус)
AbandonedNum    DB #00                                                          ; количество заброшенных/покинутых мест     (позиция)
SettlementNum   DB #00                                                          ; количество поселений                      (позиция)
DungeonNum      DB #00                                                          ; количество подземелий                     (позиция)
                ends

                endif ; ~_STRUCTURE_GENERATE_WORLD_
