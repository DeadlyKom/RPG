
                ifndef _MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
                define _MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
; -----------------------------------------
; получение AABB декали
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
;   BC - размер AABB (B - y, C - x)
; Corrupt:
; Note:
; -----------------------------------------
DecalAABB:      LD BC, #0101
                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
