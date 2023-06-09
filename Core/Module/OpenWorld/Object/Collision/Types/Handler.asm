
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_HANDLER_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_HANDLER_
; -----------------------------------------
; обработка коллизии
; In:
;   BC - дельта расстояния знаковое (B - y, C - x)
;   IX - адрес первого объекта FObject
;   IY - адрес второго объекта FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Collision       ; проверка какие объекты столкнулись
                LD L, (IX + FObject.Flags)                                      ; флаги первого объекта
                LD H, (IY + FObject.Flags)                                      ; флаги второго объекта
                LD A, H
                XOR L
                BIT FLAG_DYNAMIC_OBJECT_BIT, A
                JP NZ, .StaticDynamic                                           ; переход, если объект статический и динамический

                ; ToDo нужно править
                ; защита от глуюка когда 2 статических объекта
                ; заспавнились в 1 месте
                LD A, H
                OR L
                BIT FLAG_DYNAMIC_OBJECT_BIT, A
                JP Z, Packs.OpenWorld.Object.Utils.Remove

                ; -----------------------------------------
                ; объекты либо динамические, либо статические (чего не мб)
                ; -----------------------------------------
                PUSH BC
                CALL Packs.OpenWorld.Object.Damage.ApplyVehicle
                POP BC
                PUSH BC

                ; сохранение входного значения по вертикали
                LD A, B
                EX AF, AF'
                
                ; -----------------------------------------
                ; меняем вектор скорости по горизонтали 
                ; -----------------------------------------

                LD A, C
                ADD A, A
                SBC A, A
                LD B, A
                SLA C
                SLA C
                SLA C

                LD HL, (IX + FObject.Velocity.X)
                ADD HL, BC
                LD DE, (IY + FObject.Velocity.X)
                EX DE, HL
                OR A
                SBC HL, BC
                EX DE, HL
                LD (IY + FObject.Velocity.X), HL
                LD (IX + FObject.Velocity.X), DE

                ; -----------------------------------------
                ; меняем вектор скорости по вертикали 
                ; -----------------------------------------

                EX AF, AF'
                LD C, A
                ADD A, A
                SBC A, A
                LD B, A
                SLA C
                SLA C
                SLA C

                LD HL, (IX + FObject.Velocity.Y)
                OR A
                SBC HL, BC
                LD DE, (IY + FObject.Velocity.Y)
                EX DE, HL
                ADD HL, BC
                EX DE, HL
                LD (IY + FObject.Velocity.Y), HL
                LD (IX + FObject.Velocity.Y), DE

                ; уменьшить мощность в двое
                SRA (IX + FObject.EnginePower)
                SRA (IY + FObject.EnginePower)
                SRA (IY + FObject.EnginePower)
                SRA (IY + FObject.EnginePower)

                ; -----------------------------------------
                ; поворот игрока при ударе
                ; -----------------------------------------
                POP BC

                LD A, (IX + FObject.Type)
                AND IDX_OBJECT_TYPE
                CP OBJECT_PLAYER
                RET NZ

                ; abs(dx)
                LD A, C
                OR A
                JP P, .PositiveX
                NEG
                LD C, A
.PositiveX
                ; abs(dy)
                LD A, B
                OR A
                JP P, .PositiveY
                NEG
                ; LD B, A
.PositiveY
                ; LD A, B
                SUB C
                SBC A, A
                CCF
                ADC A, #00

                ; ADD A, A

                LD HL, PlayerState.RotationAngle
                ADD A, (HL)
                LD (HL), A

                RET

.StaticDynamic  ; определение динамического объекта
                LD E, (IX + FObject.Type)                                       ; первый тип объекта
                LD D, (IY + FObject.Type)                                       ; второй тип объекта
                BIT FLAG_DYNAMIC_OBJECT_BIT, L                                  ; флаги первого объекта
                LD A, D
                JR NZ, .Dynamic                                                 ; переход, если найден динамический объект

                LD A, E
                LD (.DynamicObject), IY
                LD (.StaticObject), IX
                JR .Handler

.Dynamic        LD (.DynamicObject), IX
                LD (.StaticObject), IY

.Handler        ; обработчик объектов
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; OBJECT_PLAYER
                JP $                                                            ; объект имеет коллизию, не обрабатывается но является динамическим
                DB #00                                                          ; dummy
                ; OBJECT_NPC
                JP $                                                            ; объект имеет коллизию, не обрабатывается но является динамическим
                DB #00                                                          ; dummy
                ; OBJECT_DECAL
                JP $                                                            ; объект не имеет коллизию, не обрабатывается
                DB #00                                                          ; dummy
                ; OBJECT_COLLISION
                JP Decal                                                        ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_PARTICLE
                JP $                                                            ; объект не имеет коллизию, не обрабатывается
                DB #00                                                          ; dummy
                ; OBJECT_MINE
                JP Mine                                                         ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JR $

.DynamicObject  DW #0000                                                        ; адрес динамического объекта
.StaticObject   DW #0000                                                        ; адрес статического объекта

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_HANDLER_
