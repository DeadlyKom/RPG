
                ifndef _CONST_GAME_WORLD_SPRITE_
                define _CONST_GAME_WORLD_SPRITE_
; WORLD_TILE_SIZE         EQU (2 + (2 * 16))                                      ; 2 первых байта буферная зона порчи стека
; WORLD_TILE_SHIFT_SIZE   EQU (2 + (3 * 16))                                      ; 2 первых байта буферная зона порчи стека
; WORLD_TILE_TOTAL_SIZE   EQU (WORLD_TILE_SIZE + WORLD_TILE_SHIFT_SIZE * 3)       ; размер тайла карты мира (с заранее смещёнными спрайтами) 

                endif ; ~_CONST_GAME_WORLD_SPRITE_
