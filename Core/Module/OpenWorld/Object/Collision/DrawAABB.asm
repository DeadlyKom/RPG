
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_DRAW_AABB_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_DRAW_AABB_
; -----------------------------------------
; отобразить AABB коллизии
; In:
;   HL  - начальная точка   (H - y, L - x)
;   DE  - конечна точка     (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DrawAABB        PUSH HL
                PUSH DE
                PUSH BC

                LD IXL, E
                LD IXH, D

                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                CP OBJECT_EMPTY_ELEMENT
                RET Z                                                           ; выход, если объект помечен удалённым
                LD C, (IX + FObject.Direction)
                CALL Packs.OpenWorld.Object.Collision.AABB.GetObject
                ; -----------------------------------------
                ;   DE - смещение AABB (D - y, E - x)
                ;   BC - размер AABB (B - y, C - x)
                ; -----------------------------------------
                LD HL, (IX + FObject.Position.X)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, E
                LD E, A

                ADD A, C
                ADD A, C
                LD C, A

                LD HL, (IX + FObject.Position.Y)
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD A, H
                ADD A, D
                LD D, A

                ADD A, B
                ADD A, B
                LD B, A

                EX DE, HL

                LD D, B
                LD E, C

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL DrawRectangle
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                POP BC
                POP DE
                POP HL
                RET
; -----------------------------------------
; нарисовать прямоугольник
; In:
;   HL  - начальная точка   (H - y, L - x)
;   DE  - конечна точка     (D - y, E - x)
; Out:
; Corrupt:
;   HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DrawRectangle:  LD (.Start), HL
                LD (.End), DE

                ; LD HL, (.Start)
                LD D, H
                LD A, (.End)
                LD E, A
                PUSH DE
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP DE
                LD HL, (.End)
                PUSH HL
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP HL
                LD D, H
                LD A, (.Start)
                LD E, A
                PUSH DE
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Line
                POP DE
                LD HL, (.Start)
                ; -----------------------------------------
                ; рисование линии
                ; In:
                ;   HL  - начальная точка   (H - y, L - x)
                ;   DE  - конечна точка     (D - y, E - x)
                ; -----------------------------------------
                JP Draw.Line

.Start          DW #0000                                                        ; High - y, Low - x
.End            DW #0000                                                        ; High - y, Low - x

                display " - DrawAABB:\t\t\t[DEBUG]\t\t\t", /A, DrawAABB, " = busy [ ", /D, $ - DrawAABB, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_PREPARE_DRAW_AABB_
