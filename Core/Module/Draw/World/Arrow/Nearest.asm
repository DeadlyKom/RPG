                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
                define _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
; -----------------------------------------
; поиск ближайшего врага
; In:
; Out:
;   DE - дельта расстояния знаковое (D - y, E - x)
;   если флаг переполнения установлен, найден ближайши враг
; Corrupt:
; Note:
; -----------------------------------------
Nearest:        ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                RET Z                                                           ; выход, если массив пуст
                LD (.ObjectCounter), A
                
                ; инициализация
                LD HL, #FFFF
                LD (.MinDistance), HL
                LD IX, PLAYER_ADR

                ; стартовый адрес обрабатываемого объекта
                LD IY, PLAYER_ADR + OBJECT_SIZE

.ObjectLoop     ; проверка валидности элемента
                LD A, (IY + FObject.Type)
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .SkipObject

                ; отсечение всех нейтральных и не NPC объектов
                ADD A, A                                                        ; BIT FACTION_TYPE_BIT, A
                JR NC, .NextObject                                              ; переход, если это нейтральный объект
                AND IDX_OBJECT_TYPE << 1
                CP OBJECT_NPC << 1
                JR NZ, .NextObject

                ; расчитать дистанцию
                CALL .CalcDistance

.NextObject     ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IY, DE

                ; уменьшение счётчика элементов
                LD HL, .ObjectCounter
                DEC (HL)
                JR NZ, .ObjectLoop


.NearestObject  EQU $+2
                LD IY, PLAYER_ADR + OBJECT_SIZE

.Distance       LD HL, (IY + FObject.Position.X)
                LD BC, #0800
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD E, H

                LD HL, #0600
                LD BC, (IY + FObject.Position.Y)
                OR A
                SBC HL, BC

                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD D, H

                SCF
                RET

.SkipObject     ; следующий элемент
                LD DE, OBJECT_SIZE
                ADD IY, DE
                JR .ObjectLoop

.CalcDistance   ; -----------------------------------------
                ;   IX - адрес объекта A FObject
                ;   IY - адрес объекта B FObject
                ; Out:
                ;   DE - дельта расстояния знаковое (D - y, E - x)
                ;   HL, DE, BC, AF
                ; Note:
                ;   важно, 1 бит сдвиг влево меньше 
                ; -----------------------------------------
                CALL Object.DeltaPosition

                ; abs(dx)
                LD A, E
                OR A
                JP P, $+5
                NEG
                LD E, A

                ; abs(dy)
                LD A, D
                OR A
                JP P, $+5
                NEG
                LD D, A

                LD B, D
                LD C, #00
                
                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                LD A, E
                LD D, C
                CALL Math.Mul16x8_16
                PUSH HL

                LD A, B
                LD E, B
                LD D, C
                CALL Math.Mul16x8_16
                POP DE
                ADD HL, DE
                EX DE, HL

.MinDistance    EQU $+1
                LD HL, #FFFF
                OR A
                SBC HL, DE
                RET C
                LD (.MinDistance), DE
                LD (.NearestObject), IY

                RET

.ObjectCounter  DB #00

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_NEAREST_
