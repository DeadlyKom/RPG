
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_DETECTION_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_DETECTION_
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

                PUSH HL
                PUSH DE
                PUSH BC

                EXX

                ; AABB объектов берутся из данных спрайта или константы объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .Skip                                                     ; переход, если объект в процессе обработки помечен удалённым

                ; возможна ситуация, когда объект удалился и на его месте появился другой
                ; проверим что возможный новый объект имеет коллизию
                BIT FLAG_COLLISION_BIT, (IX + FObjectParticle.Flags)
                JR Z, .Skip                                                     ; переход, если объект в процессе обработки не имеет коллизию

                LD C, (IX + FObject.Direction)                                  ; Subtype для декали
                CALL AABB.GetObject
                ; -----------------------------------------
                ;   DE - смещение AABB (D - y, E - x)
                ;   BC - размер AABB (B - y, C - x)
                ; -----------------------------------------

                LD A, (IY + FObject.Type)                                       ; получим тип объекта
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .Skip                                                     ; переход, если объект в процессе обработки помечен удалённым
                ; возможна ситуация, когда объект удалился и на его месте появился другой
                ; проверим что возможный новый объект имеет коллизию
                BIT FLAG_COLLISION_BIT, (IY + FObjectParticle.Flags)
                JR Z, .Skip                                                     ; переход, если объект в процессе обработки не имеет коллизию

                PUSH DE
                PUSH BC
                LD C, (IY + FObject.Direction)                                  ; Subtype для декали
                CALL AABB.GetObject
                ; -----------------------------------------
                ;   DE - смещение AABB (D - y, E - x)
                ;   BC - размер AABB (B - y, C - x)
                ; -----------------------------------------
                EX DE, HL
                EX (SP), HL
                PUSH HL
                PUSH BC

                ; -----------------------------------------
                ; проверка пересечения AABB с AABB
                ; In :
                ;   SP + 6 - смещение первого AABB  (High - y, Low - x)
                ;   SP + 4 - смещение второго AABB  (High - y, Low - x)
                ;   SP + 2 - размер первого AABB    (High - y, Low - x)
                ;   SP + 0 - размер второго AABB    (High - y, Low - x)
                ;   IX - адрес первого объекта FObject (взятие позиций)
                ;   IY - адрес второго объекта FObject (взятие позиций)
                ; Out :
                ;   BC - дельта расстояния знаковое (B - y, C - x)
                ;   флаг переполнения сброшен, если пересекаются
                ; -----------------------------------------
                CALL Math.IntersectAABB
                CALL NC, Types.Collision
.Skip           EXX

                POP BC
                POP DE
                POP HL

                DJNZ .SecondObject

                DEC C
                JR NZ, .FirstObject

                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_DETECTION_
