
                ifndef _CONST_MEMORY_MAP_PACK_7_
                define _CONST_MEMORY_MAP_PACK_7_

                module Size
WorldSpr        EQU WORLD_SPRITE_SIZE_ALIGNED                                   ; размер спрайтов карты мира (тайлопары)
WorldSprTable   EQU #0400                                                       ; размер таблицы спрайтов карты мира
WorldTilepair   EQU #0100                                                       ; размер таблицы поиска тайлопар
MinimapSpr      EQU #0080                                                       ; размер спрайта миникарты
                endmodule

                module Adr

MapBuffer       EQU MemBank_03_                                                 ; адрес буфера карты мира (после свёртывания диаграммы Ворогого)

                ; -----------------------------------------
WorldSprTable   EQU #FC00                                                       ; адрес таблицы спрайтов карты мира (тайлопары)
WorldTilepair   EQU Adr.WorldSprTable - Size.WorldTilepair                      ; адрес таблицы поиска тайлопар
WorldSpr        EQU Adr.WorldTilepair - Size.WorldSpr                           ; адрес спрайтов карты мира (тайлопары)
MinimapSpr      EQU RenderBuffer + Size.MinimapSpr                              ; адрес спрайта миникарты (необходим для генерации тайлопар)
                endmodule

                endif ; ~_CONST_MEMORY_MAP_PACK_7_
