
                ifndef _CONST_GAME_SCREEN_WORLD_
                define _CONST_GAME_SCREEN_WORLD_
WORLD_TILE_PIX_SIZE     EQU 16
SCR_WORLD_POS_X         EQU 5                                                   ; положение карты мира на экране по горизонтали в знакоместах
SCR_WORLD_POS_Y         EQU 2                                                   ; положение карты мира на экране по вертикали в знакоместах
SCR_WORLD_POS_PIX_X     EQU SCR_WORLD_POS_X * 8                                 ; положение карты мира на экране по горизонтали в пикселях
SCR_WORLD_POS_PIX_Y     EQU SCR_WORLD_POS_Y * 8                                 ; положение карты мира на экране по вертикали в пикселях
SCR_WORLD_SIZE_X        EQU 11                                                  ; количество тайлов карты мира на экране по горизонтали
SCR_WORLD_SIZE_Y        EQU 10                                                  ; количество тайлов карты мира на экране по вертикали

SCR_MINIMAP_POS_X       EQU 27                                                  ; положение мини карты на экране по горизонтали в знакоместах
SCR_MINIMAP_POS_Y       EQU 2                                                   ; положение мини карты на экране по вертикали в знакоместах
SCR_MINIMAP_POS_PIX_Y   EQU SCR_MINIMAP_POS_Y * 8                               ; положение мини карты на экране по вертикали в пикселях
SCR_MINIMAP_SIZE_X      EQU 32                                                  ; размер мини карты по горизонтали в пикселях
SCR_MINIMAP_SIZE_Y      EQU 32                                                  ; размер мини карты по вертикали в пикселях
SCR_MINIMAP_OFFSET_X    EQU ((SCR_MINIMAP_SIZE_X - (SCR_WORLD_SIZE_X + 1) << 1) >> 1); смещение видимой части мира в мини карте по горизонтали   (центрирование)
SCR_MINIMAP_OFFSET_Y    EQU ((SCR_MINIMAP_SIZE_Y - (SCR_WORLD_SIZE_X + 1) << 1) >> 1); смещение видимой части мира в мини карте по вертикали     (центрирование)

                endif ; ~_CONST_GAME_SCREEN_WORLD_
