
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_DECAL_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_DECAL_
; -----------------------------------------
; получение AABB декали
; In:
;   A  - тип объекта
;   C  - направление объекта/Subtype для декали
; Out:
;   DE - смещение AABB (D - y, E - x)
;   BC - размер AABB (B - y, C - x)
; Corrupt:
; Note:
; -----------------------------------------
DecalAABB:      ; переход в зависимости от типа объекта
                LD A, C
                AND IDX_OBJECT_SUBTYPE
                ADD A, A
                LD (.Jump), A
                LD A, B
.Jump           EQU $+1
                JR $

                ; OBJECT_CACTUS_A
                JR Cactus                                                       ; объект имеет коллизию
                ; OBJECT_CACTUS_B
                JR Cactus                                                       ; объект имеет коллизию
                ; OBJECT_CACTUS_C
                JR Cactus                                                       ; объект имеет коллизию
                ; OBJECT_GRASS
                JR$                                                             ; объект не имеет коллизию
                ; OBJECT_SCULL_A
                JR$                                                             ; объект не имеет коллизию
                ; OBJECT_LOG_A
                JR Stone                                                        ; объект имеет коллизию
                ; OBJECT_STONE_A
                JR Stone                                                        ; объект имеет коллизию
                ; OBJECT_STONE_B
                JR Stone                                                        ; объект имеет коллизию
                ; OBJECT_STONE_C
                JR Stone                                                        ; объект имеет коллизию
                ; OBJECT_LOG_B
                JR $                                                            ; объект не имеет коллизию
                ; OBJECT_LOG_C
                JR Log                                                          ; объект имеет коллизию
                ; OBJECT_DITCH_A
                JR Ditch                                                        ; объект имеет коллизию
                ; OBJECT_SCULL_B
                JR$                                                             ; объект не имеет коллизию
                ; OBJECT_DITCH_B
                JR$                                                             ; объект не имеет коллизию

Cactus:         LD DE, ((10) & 0xFF) << 8 | ((4) & 0xFF)                        ; DE - смещение AABB (D - y, E - x)
                LD BC, #0304                                                    ; BC - размер AABB (B - y, C - x)
                RET
Log:            LD DE, ((9) & 0xFF) << 8 | ((4) & 0xFF)                         ; DE - смещение AABB (D - y, E - x)
                LD BC, #0404                                                    ; BC - размер AABB (B - y, C - x)
                RET
Stone:          LD DE, ((1) & 0xFF) << 8 | ((1) & 0xFF)                         ; DE - смещение AABB (D - y, E - x)
                LD BC, #0606                                                    ; BC - размер AABB (B - y, C - x)
                RET
Ditch:          LD DE, ((2) & 0xFF) << 8 | ((2) & 0xFF)                         ; DE - смещение AABB (D - y, E - x)
                LD BC, #0505                                                    ; BC - размер AABB (B - y, C - x)
                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_DECAL_
