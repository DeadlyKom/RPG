
                ifndef _CONST_GAME_SCREEN_WORLD_
                define _CONST_GAME_SCREEN_WORLD_
WORLD_TILE_PIX_SIZE EQU 16
SCR_WORLD_POS_X     EQU 5                                                       ; положение карты мира на экране по горизонтали в знакоместах
SCR_WORLD_POS_Y     EQU 1                                                       ; положение карты мира на экране по вертикали в знакоместах
SCR_WORLD_POS_PIX_X EQU SCR_WORLD_POS_X * 8                                     ; положение карты мира на экране по горизонтали в пикселях
SCR_WORLD_POS_PIX_Y EQU SCR_WORLD_POS_Y * 8                                     ; положение карты мира на экране по вертикали в пикселях
SCR_WORLD_SIZE_X    EQU 11                                                      ; количество тайлов карты мира на экране по горизонтали
SCR_WORLD_SIZE_Y    EQU 11                                                      ; количество тайлов карты мира на экране по вертикали

                endif ; ~_CONST_GAME_SCREEN_WORLD_
