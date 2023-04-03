
                ifndef _CONST_GAME_WORLD_SPRITE_
                define _CONST_GAME_WORLD_SPRITE_
WORLD_TILE_NUM      EQU 79                                                      ; количество тайлов карты мира
WORLD_TILE_SIZE     EQU 2 * 16                                                  ; размер спрайта тайла
WORLD_TILEPAIR_SIZE EQU 4 * WORLD_TILE_SIZE                                     ; размер тайлопары (оригинал + 3 смещения)

; размер спрайтов карты мира (тайлопары). удаление повторений спрайтов тайлопар: 16 * 32 + 67 * 96 = 6944 байт
WORLD_SPRITE_SIZE   EQU 16 * WORLD_TILE_SIZE + WORLD_TILE_NUM * (WORLD_TILEPAIR_SIZE - WORLD_TILE_SIZE) 
; выровненый адрес 256 байт
WORLD_SPRITE_SIZE_ALIGNED   EQU (((WORLD_SPRITE_SIZE % 256 > 0) & 0x01) + (WORLD_SPRITE_SIZE >> 8)) << 8

                endif ; ~_CONST_GAME_WORLD_SPRITE_
