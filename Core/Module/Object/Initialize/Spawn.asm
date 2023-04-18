
                ifndef _CORE_MODULE_OBJECT_SPAWN_
                define _CORE_MODULE_OBJECT_SPAWN_
; -----------------------------------------
; спавн объекта в мире
; In:
;   BC - параметры      (B - подтип, C - тип объекта)
; Out:
;   IY - адрес объекта
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
Spawn:          ; поиск свободной ячейки
                EXX

                ; инициализация
                LD HL, Adr.Object
                LD DE, OBJECT_SIZE - 1
                LD BC, OBJECTS_NUM + 1                                          ; количество элементов
                LD A, OBJECT_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Spawn
                ADD HL, DE
                JP PE, .Loop
                RET

.Spawn          ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IY

                ; увеличение количества юнитов в массиве
                LD HL, GameState.Objects
                LD E, (HL)
                LD A, OBJECTS_NUM
                SUB C
                RET C                                                           ; выход если нет место в массиве

                INC (HL)
                EXX

                ; переход в зависимости от типа объекта
                LD A, C                                                         ; получим тип объекта
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; 0
                JP Player
                DB #00                                                          ; dummy
                ; 1
                JP NPC
                DB #00                                                          ; dummy
                ; 2
                JP Decal
                DB #00                                                          ; dummy
                ; 3
                JP Decal
                DB #00                                                          ; dummy
                ; 4
                JP Particle
                DB #00                                                          ; dummy
                ; 5
                JP $
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JP $

                display " - Spawn object in world : \t\t\t\t", /A, Spawn, " = busy [ ", /D, $ - Spawn, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_
