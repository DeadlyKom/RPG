
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_
; -----------------------------------------
; получение AABB объекта
; In:
;   A  - тип объекта
;   C  - направление объекта/Subtype для декали
; Out:
;   DE - смещение AABB (D - y, E - x)
;   BC - размер AABB (B - y, C - x)
; Corrupt:
;   C, AF
; Note:
; -----------------------------------------
GetObject:      ; переход в зависимости от типа объекта
                LD B, A
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
                LD A, B
.Jump           EQU $+1
                JR $

                ; OBJECT_PLAYER
                JP PawnAABB                                                     ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_NPC
                JP PawnAABB                                                     ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_DECAL
                JP $                                                            ; объект не имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_COLLISION
                JP DecalAABB                                                    ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_PARTICLE
                JP $                                                            ; объект не имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_MINE
                JP MineAABB
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JP $

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_
