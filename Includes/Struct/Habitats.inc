
                ifndef _STRUCTURE_HABITATS_
                define _STRUCTURE_HABITATS_

                struct FHabitats                                                ; структура описывающая обитания существ на карте
RegionID        DB #00                                                          ; индекс структуры региона поселения    [1 байт]
Type            DB #00                                                          ; тип сущеста обитающий в данной зоне   [1 байт]
                ends

                endif ; ~_STRUCTURE_HABITATS_
