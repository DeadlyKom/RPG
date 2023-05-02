
                ifndef _MATH_INTERSECTS_AABB_VS_AABB_
                define _MATH_INTERSECTS_AABB_VS_AABB_

                module Math
; -----------------------------------------
; проверка пересечения AABB с AABB
; In :
;   SP + 8 - смещение первого AABB  (High - y, Low - x)
;   SP + 6 - смещение второго AABB  (High - y, Low - x)
;   SP + 4 - размер первого AABB    (High - y, Low - x)
;   SP + 2 - размер второго AABB    (High - y, Low - x)
;   SP + 0 - адрес возврата
;   IX - адрес первого объекта FObject (взятие позиций)
;   IY - адрес второго объекта FObject (взятие позиций)
; Out :
;   BC - дельта расстояния знаковое (B - y, C - x)
;   флаг переполнения сброшен, если пересекаются
; Corrupt :
;    HL, DE, BC, AF
; Note:
;
; представление AABB как центральную точку c и радиусы rx, ry вдоль каждой оси:
;   AABB = { (x, y) | |c.x-x|<=rx, |c.y-y|<=ry }
;
; struct AABB
; {
;     Point c;
;     float r[2]; 
; };
;
; bool AABBvsAABB(AABB a, AABB b)
; {
;     if (Abs(a.c[0] - b.c[0]) > (a.r[0] + b.r[0])) return false;
;     if (Abs(a.c[1] - b.c[1]) > (a.r[1] + b.r[1])) return false;
;     return true;
; }
; -----------------------------------------
IntersectAABB:  POP HL
                LD (.ReturnAddress), HL

                ; -----------------------------------------

                POP BC                                                          ;   BC - размер второго AABB (B - y, C - x)
                POP DE                                                          ;   DE - размер первого AABB (D - y, E - x)

                ; a.r.x + b.r.x
                LD A, E
                LD (.arx), A
                ADD A, C
                LD L, A
                LD A, C
                LD (.brx), A

                ; a.r.y + b.r.y
                LD A, D
                LD (.ary), A
                ADD A, B
                LD H, A
                LD A, B
                LD (.bry), A

                LD (.L1), HL

                POP DE                                                          ; смещение второго AABB  (D - y, E - x)
                POP BC                                                          ; смещение первого AABB  (B - y, C - x)

                LD HL, (IY + FObject.Position.X)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, E
.brx            EQU $+1
                ADD A, #00
                LD E, A

                LD HL, (IX + FObject.Position.X)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, C
.arx            EQU $+1
                ADD A, #00
                LD L, A

                LD A, E
                SUB L
                LD E, A

                LD HL, (IY + FObject.Position.Y)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, D
.bry            EQU $+1
                ADD A, #00
                LD D, A

                LD HL, (IX + FObject.Position.Y)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, B
.ary            EQU $+1
                ADD A, #00

                LD L, A
                LD A, D
                SUB L
                LD D, A

.L1             EQU $+1
                LD HL, #0000

                ; сохранение дельты расстояния
                LD B, D
                LD C, E
                ; -----------------------------------------

                ; abs(a.c.x - b.c.x)
                LD A, E
                OR A
                JP P, $+6
                NEG
                LD E, A

                ; abs(a.c.x - b.c.x) > (a.r.x + b.r.x)
                LD A, L
                SUB E
                ; RET C
                JR C, .RET

                ; abs(a.c.y - b.c.y)
                LD A, D
                OR A
                JP P, $+6
                NEG
                LD D, A

                ; abs(a.c.y - b.c.y) > (a.r.y + b.r.y)
                LD A, H
                SUB D
                ; RET C
.RET
.ReturnAddress  EQU $+1
                JP #0000

                display " - Intersects AABB vs AABB:\t\t\t\t", /A, IntersectAABB, " = busy [ ", /D, $ - IntersectAABB, " bytes  ]"

                endmodule

                endif ; ~_MATH_INTERSECTS_AABB_VS_AABB_
