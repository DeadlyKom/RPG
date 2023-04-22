
                ifndef _MODULE_GAME_OBJECT_COLLISION_DETECTION_
                define _MODULE_GAME_OBJECT_COLLISION_DETECTION_
; -----------------------------------------
; проверка коллизии объектов
; In:
;   BC  - количествой элементов в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Detection:      ; проверка наличия объектов в массиве > 1
                LD A, C
                CP #02
                RET C

                LD DE, SortBuffer
                DEC C

.FirstObject    EX DE, HL
                ;
                LD A, (HL)
                LD IXL, A
                INC L
                LD A, (HL)
                LD IXH, A
                INC L

                LD D, H
                LD E, L

                LD B, C
                EX DE, HL

.SecondObject   ;
                LD A, (HL)
                LD IYL, A
                INC L
                LD A, (HL)
                LD IYH, A
                INC L

                EXX

                ; AABB объектов берутся из данных спрайта или константы объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                LD C, (IX + FObject.Direction)
                CALL AABB.GetObject
                PUSH BC

                LD A, (IY + FObject.Type)                                       ; получим тип объекта
                LD C, (IY + FObject.Direction)
                CALL AABB.GetObject
                POP DE

                ; -----------------------------------------
                ; проверка пересечения AABB с AABB
                ; In :
                ;   DE - размер первого AABB (D - y, E - x)
                ;   BC - размер второго AABB (B - y, C - x)
                ;   IX - адрес первого объекта FObject (взятие позиций)
                ;   IY - адрес второго объекта FObject (взятие позиций)
                ; Out :
                ;   BC - дельта значений знаковое число (B - y, C - x)
                ;   флаг переполнения сброшен, если пересекаются
                ; -----------------------------------------
                CALL Math.IntersectAABB
                CALL NC, .Collision
                EXX

                DJNZ .SecondObject

                DEC C
                JR NZ, .FirstObject

                RET

.Collision      ;   BC - дельта значений знаковое число (B - y, C - x)
                LD E, B

                LD A, C
                ADD A, A
                LD C, A
                SBC A, A
                LD B, A
                SLA C
                SLA C
                SLA C
                LD HL, (IX + FObject.Velocity.X)
                OR A
                SBC HL, BC
                LD (IX + FObject.Velocity.X), HL

                LD HL, (IY + FObject.Velocity.X)
                ADD HL, BC
                LD (IY + FObject.Velocity.X), HL

                LD A, E
                ADD A, A
                LD E, A
                SBC A, A
                LD D, A
                SLA E
                SLA E
                SLA E
                LD HL, (IX + FObject.Velocity.Y)
                ADD HL, DE
                LD (IX + FObject.Velocity.Y), HL

                LD HL, (IY + FObject.Velocity.Y)
                OR A
                SBC HL, DE
                LD (IY + FObject.Velocity.Y), HL

                XOR A
                LD (IX + FObject.EnginePower), A
                LD (IY + FObject.EnginePower), A

                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_DETECTION_
