
                ifndef _STRUCTURE_GENERATE_WORLD_
                define _STRUCTURE_GENERATE_WORLD_

                struct FGenerateWorld
TextSeed        TEXT 16, {"None", 0}                                            ; текстовое представление seed генерации мира
                                                                                ; из текста формируется seed и частота шума перлина
Difficulty      DB #00                                                          ; сложность
                                                                                ; влияет на стартовые значения
                                                                                ; количество агрессивно настроеных поселений/фракций
Climate         DB #00                                                          ; климат                                    (рантайм параметр)
                                                                                ; влияет на игру
                                                                                ; повышает частоту и силу климатических событий
MapSize         DB #00                                                          ; размер карты
                                                                                ; влияет на стартовые значения
                                                                                ; влияет на растояния между поселениями при генерации
Center          FLocation32                                                     ; центр генерируемого мира
TotalNumObject  DB #00                                                          ; общее количество объектов на карте
RadioactiveNum  DB #00                                                          ; количество радиоактивных зон              (позиция + радиус)
HabitatsNum     DB #00                                                          ; места обитания существ                    (позиция + радиус)
AbandonedNum    DB #00                                                          ; количество заброшенных/покинутых мест     (позиция + радиус равный 0)
SettlementNum_N DB #00                                                          ; количество поселений "нейтральный"        (позиция + радиус)
SettlementNum_F DB #00                                                          ; количество поселений "дружественный"      (позиция + радиус)
SettlementNum_H DB #00                                                          ; количество поселений "враждебный"         (позиция + радиус)
DungeonNum      DB #00                                                          ; количество подземелий                     (позиция)
                ends

                endif ; ~_STRUCTURE_GENERATE_WORLD_
