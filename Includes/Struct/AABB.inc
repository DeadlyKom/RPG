
                ifndef _STRUCTURE_AABB_
                define _STRUCTURE_AABB_

; axis aligned bounding box

                struct FAABB
Center          FVector16                                                       ; позиция центра AABB
Size            FSize                                                           ; размер AABB по двум осям
                ends

                endif ; ~_STRUCTURE_AABB_
