
                ifndef _CORE_MODULE_OPEN_WORLD_PACKING_
                define _CORE_MODULE_OPEN_WORLD_PACKING_
; -----------------------------------------
; попытка упаковать
; In:
;   A' - ID региона                 (добавляемый)
;   IX - адрес структуры FRegion    (добавляемый)
;   IY - указатель на заполненую структуру FGenerateWorld
; Out:
;   если флаг переполнения сброшен, упаковка прошла успешно
; Corrupt:
; Note:
; -----------------------------------------
TryPacking:     ; генерация случайного положения на карте мира,
                ; если регион не влияет на проверку пересечений
                LD A, (IX + FRegion.Type)
                AND IDX_REGION_TYPE
                CP REGION_TYPE_HABITATS
                JP Z, Packs.OpenWorld.Generate.RandLocation                     ; переход, если тип региона не учавствует в проверке
                CP REGION_TYPE_DUNGEON
                JP Z, Packs.OpenWorld.Generate.RandLocation                     ; переход, если тип региона не учавствует в проверке
                CP REGION_TYPE_SETTLEMENT_ABANDONED
                JP Z, Packs.OpenWorld.Generate.RandLocation                     ; переход, если тип региона не учавствует в проверке

                ; инициализация
                LD C, #20                                                       ; количество попыток
                PUSH IY
                PUSH BC

.TryLoop        POP BC
                
                ; проверка окончания попыток
                DEC C
                SCF                                                             ; установка ошибки
                JP Z, .Exit                                                     ; переход, если количество попыток равно нулю
                
                POP IY
                PUSH BC

                ; генерация случайного положения на карте мира
                CALL Packs.OpenWorld.Generate.RandLocation

                POP BC
                PUSH IY

                ; инициализация
                LD IY, REGION_ADR                                               ; адрес массива регионов
                LD A, (GameState.Region)                                        ; количество регионов
                DEC A                                                           ; -1 (последний регион в массиве, это сравниваемый)
                LD B, A 

.Loop           PUSH BC

                ; пропуск регионов не влияющие на проверку пересечений
                LD A, (IY + FRegion.Type)
                AND IDX_REGION_TYPE
                CP REGION_TYPE_HABITATS
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует в проверке
                CP REGION_TYPE_DUNGEON
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует в проверке
                CP REGION_TYPE_SETTLEMENT_ABANDONED
                JR Z, .NextElement                                              ; переход, если тип региона не учавствует в проверке

                CALL .Check
                JP C, .TryLoop                                                  ; переход, если растояние между двумя регионами меньше
                                                                                ; суммы их радиуса влияния (радиусы пересекаются)

.NextElement    ; следующий элемент региона
                LD BC, FRegion
                ADD IY, BC
                
                POP BC
                DJNZ .Loop

                OR A                                                            ; успешный выход
.Exit           POP IY
                RET

.Check          ; -----------------------------------------
                ; расчёт квадрат расстояния суммы двух радиусов влияния регионов
                ; -----------------------------------------

                ; (RegionA.radius + RegionB.radius) * (RegionA.radius + RegionB.radius)
                LD A, (IX + FRegion.InfluenceRadius)
                ADD A, (IY + FRegion.InfluenceRadius)
                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                LD D, #00
                LD E, A
                CALL Math.Mul16x8_16                                            ; квадрат расстояния суммы радиусов
                PUSH HL

                ; -----------------------------------------
                ; расчёт квадрат расстояния между регионами
                ; -----------------------------------------

                ; RegionA.x - RegionB.x

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                LD HL, (IX + FRegion.Location.X.Low)
                LD DE, (IY + FRegion.Location.X.Low)
                EXX
                LD HL, (IX + FRegion.Location.X.High)
                LD DE, (IY + FRegion.Location.X.High)
                CALL Math.Sub32_32

                ; X = abc (RegionA.x - RegionB.x)
                ; X = abc (RegionA.y - RegionB.y)
                LD A, D
                OR A
                JP P, $+9

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

                ; X * X
                LD A, H
                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                LD D, #00
                LD E, H
                CALL Math.Mul16x8_16
                PUSH HL

                ; RegionA.y - RegionB.y

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                LD HL, (IX + FRegion.Location.Y.Low)
                LD DE, (IY + FRegion.Location.Y.Low)
                EXX
                LD HL, (IX + FRegion.Location.Y.High)
                LD DE, (IY + FRegion.Location.Y.High)
                CALL Math.Sub32_32

                ; X = abc (RegionA.y - RegionB.y)
                LD A, D
                OR A
                JP P, $+9

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

                ; Y * Y
                LD A, H
                ; -----------------------------------------
                ; integer multiplies DE by A
                ; In :
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; -----------------------------------------
                LD D, #00
                LD E, H
                CALL Math.Mul16x8_16
                POP  DE
                ADD HL, DE                                                      ; квадрат расстояния между регионами
               
                ; -----------------------------------------
                ; проверка квадраты расстояний
                ; -----------------------------------------
                POP DE
                OR A
                SBC HL, DE

                RET

                display "\t- Packing:\t\t\t\t\t", /A, TryPacking, " = busy [ ", /D, $ - TryPacking, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_PACKING_
