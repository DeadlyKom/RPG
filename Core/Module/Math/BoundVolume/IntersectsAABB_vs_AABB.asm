
                ifndef _MATH_INTERSECTS_AABB_VS_AABB_
                define _MATH_INTERSECTS_AABB_VS_AABB_

                module Math
; -----------------------------------------
; проверка пересечения AABB с AABB
; In :
;   DE - размер первого AABB (D - y, E - x)
;   BC - размер второго AABB (B - y, C - x)
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
IntersectAABB:  ; -----------------------------------------
                
                ; a.r.x + b.r.x
                LD A, E
                ADD A, C
                LD E, A

                ; a.r.y + b.r.y
                LD A, D
                ADD A, B
                LD D, A

                PUSH DE

                ; -----------------------------------------
                ;   IX - адрес объекта A FObject
                ;   IY - адрес объекта B FObject
                ; Out:
                ;   DE - дельта расстояния знаковое (D - y, E - x)
                ;   HL, DE, BC, AF
                ; Note:
                ;   важно, 1 бит сдвиг влево меньше 
                ; -----------------------------------------
                CALL Object.DeltaPosition

                LD B, D
                LD C, E
                ; -----------------------------------------

                POP HL

                ; abs(a.c.x - b.c.x)
                LD A, E
                OR A
                JP P, $+6
                NEG
                LD E, A

                ; abs(a.c.x - b.c.x) > (a.r.x + b.r.x)
                LD A, L
                SRL A
                SUB E
                RET C

                ; abs(a.c.y - b.c.y)
                LD A, D
                OR A
                JP P, $+6
                NEG
                LD D, A

                ; abs(a.c.y - b.c.y) > (a.r.y + b.r.y)
                LD A, H
                SRL A
                SUB D
                RET C

                RET

                display " - Intersects AABB vs AABB:\t\t\t\t", /A, IntersectAABB, " = busy [ ", /D, $ - IntersectAABB, " bytes  ]"

                endmodule

                endif ; ~_MATH_INTERSECTS_AABB_VS_AABB_
