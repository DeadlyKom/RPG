
                ifndef _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
                define _CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
; -----------------------------------------
; балансировщик регионов
; In:
;   IY - адрес структуры FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Balancer:       ; общее количество объектов влияющие на регионы
                LD A, (IY + FGenerateWorld.RadioactiveNum)                      ; количество радиоактивных зон
                ADD A, (IY + FGenerateWorld.HabitatsNum)                        ; количество мест обитания существ
                ADD A, (IY + FGenerateWorld.AbandonedNum)                       ; количество заброшенных/покинутых мест
                ADD A, (IY + FGenerateWorld.SettlementNum_N)                    ; количество поселений "нейтральный"
                ADD A, (IY + FGenerateWorld.SettlementNum_F)                    ; количество поселений "дружественный"
                ADD A, (IY + FGenerateWorld.SettlementNum_H)                    ; количество поселений "враждебный"
                ADD A, (IY + FGenerateWorld.DungeonNum)                         ; количество подземелий
                LD (IX + FGenerateWorld.TotalNumObject), A                      ; ??
                LD B, A

.Loop           PUSH BC
                LD D, #00                                                       ; сброс суммы коэффициентов
                CALL .Select                                                    ; выбор
                POP BC
                DJNZ .Loop

                RET

.Select         ; рандом веса выбора региона
                EXX
                CALL Math.Rand8
                EXX
                EX AF, AF'                                                      ; сохранение рандомного веса
                LD C, B                                                         ; сохранение суммы генерируемых регионов

                ; -----------------------------------------
                ; коэффицент "радиоактивный"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.RadioactiveNum)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JR C, .Radioactive
                EX AF, AF'

                ; -----------------------------------------
                ; коэффицент "обитания существ"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.HabitatsNum)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JP C, .Habitats
                EX AF, AF'

                ; -----------------------------------------
                ; коэффицент "заброшенных/покинутых мест"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.AbandonedNum)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JP C, .Abandoned
                EX AF, AF'

                ; -----------------------------------------
                ; коэффицент "нейтральный"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.SettlementNum_N)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JP C, .Settlement_N
                EX AF, AF'

                ; -----------------------------------------
                ; коэффицент "дружественный"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.SettlementNum_F)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JP C, .Settlement_F
                EX AF, AF'

                ; -----------------------------------------
                ; коэффицент "враждебный"
                ; -----------------------------------------

                LD H, (IY + FGenerateWorld.SettlementNum_H)
                LD L, #00
                LD E, C
                ; -----------------------------------------
                ; деление HL на E
                ; In :
                ;   HL - делимое
                ;   E  - делитель
                ; Out :
                ;   L  - результат деления
                ;   H  - остаток
                ; Corrupt :
                ;   HL, B, AF
                ; -----------------------------------------
                CALL Math.Div16x8_16

                ; добавить вес коэффицента
                LD A, D
                ADD A, L
                SBC A, B
                LD D, A

                ; проверка выборки по рандомному весу
                EX AF, AF'
                CP D
                JP C, .Settlement_H

.Dungeon        ; -----------------------------------------
                ; "зона подземелий"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_DUNGEON                     ; тип региона "подземелье"

                ; рандомизация радиуса зона подземелий
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_DUNGEON_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.DungeonNum)                            ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация зона подземелий
                JP Packs.OpenWorld.Generate.Metadata.RandDungeon

.Radioactive    ; -----------------------------------------
                ; "радиоактивная зона"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                LD (IX + FRegion.Type), REGION_TYPE_RADIOACTIVE                 ; тип региона "радиоактивный"

                ; рандомизация радиуса радиоактивной зоны
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_RADIOACTIVE_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка проша неудачно
                DEC (IY + FGenerateWorld.RadioactiveNum)                        ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                RET

.Habitats       ; -----------------------------------------
                ; "зона обитания существ"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_HABITATS                    ; тип региона "обитания существ"

                ; рандомизация радиуса обитания существ
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_HABITATS_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.HabitatsNum)                           ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация существ обитающих в зоне
                JP Packs.OpenWorld.Generate.Metadata.RandHabitats

.Abandoned      ; -----------------------------------------
                ; "заброшенное/покинутое"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT_ABANDONED        ; тип региона "заброшенный/покинутый"

                ; рандомизация радиуса заброшенной/покинутой зоны
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_ABANDONED_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.AbandonedNum)                          ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация заброшенных/покинутых поселений в зоне
                JP Packs.OpenWorld.Generate.Metadata.RandAbandoned

.Settlement_N   ; -----------------------------------------
                ; "нейтральное"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT_NEUTRAL          ; тип региона "нейтральный"

                ; рандомизация радиуса влияния поселений
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_NEUTRAL_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.SettlementNum_N)                       ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация нейтральных поселений в зоне
                JP Packs.OpenWorld.Generate.Metadata.RandSettlement

.Settlement_F   ; -----------------------------------------
                ; "дружественное"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT_FRIENDLY         ; тип региона "дружественный"

                ; рандомизация радиуса влияния поселений
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_FRIENDLY_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.SettlementNum_F)                       ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация нейтральных поселений в зоне
                JP Packs.OpenWorld.Generate.Metadata.RandSettlement

.Settlement_H   ; -----------------------------------------
                ; "враждебное"
                ; -----------------------------------------

                ; -----------------------------------------
                ; резервирование ячейки региона
                ; -----------------------------------------
                ; добавить/зарезервировать ячейку в массиве
                ; Out:
                ;   A  - ID элемента в массиве
                ;   IX - адрес найденого свободного элемента структуры FRegion
                ;   флаг переполнения Carry сброшен, если поиск свободного элемента успешен
                ; -----------------------------------------
                CALL Add
                DEBUG_BREAK_POINT_C                                             ; ошибка резервирования ячейки
                EX AF, AF'                                                      ; сохранение ID региона
                LD (IX + FRegion.Type), REGION_TYPE_SETTLEMENT_HOSTILE          ; тип региона "враждебный"

                ; рандомизация радиуса влияния поселений
                CALL Math.Rand8
                ; -----------------------------------------
                ; integer 8-bit divides D by E
                ; In :
                ;   D - dividend
                ;   E - divider
                ; Out :
                ;   D - division result
                ;   A - remainder
                ; Corrupt :
                ;   D, AF
                ; -----------------------------------------
                LD D, A
                LD E, REGION_TYPE_HOSTILE_RADIUS
                CALL Math.Div8x8                                                ; A = Rand % MaxRadius
                LD (IX + FRegion.InfluenceRadius), A

                ; попытка упаковать
                CALL Packs.OpenWorld.Generate.TryPacking
                RET C                                                           ; выход, если упаковка прошла неудачно
                DEC (IY + FGenerateWorld.SettlementNum_H)                       ; уменьшение счтёчик (влияет на вес)

                ; -----------------------------------------
                ; инициализация региона
                ; -----------------------------------------

                ; рандомизация нейтральных поселений в зоне
                JP Packs.OpenWorld.Generate.Metadata.RandSettlement

                display "\t- Balancer region:\t\t\t\t", /A, Add, " = busy [ ", /D, $ - Add, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_GENERATE_REGION_BALANCER_
