
                ifndef _CONST_GAME_SCREEN_WORLD_
                define _CONST_GAME_SCREEN_WORLD_
WORLD_TILE_PIX_SIZE     EQU 16
SCR_WASTELAND_POS_X     EQU 5                                                   ; положение пустоши на экране по горизонтали в знакоместах
SCR_WASTELAND_POS_Y     EQU 2                                                   ; положение пустоши на экране по вертикали в знакоместах
SCR_WASTELAND_POS_PIX_X EQU SCR_WASTELAND_POS_X * 8                             ; положение пустоши на экране по горизонтали в пикселях
SCR_WASTELAND_POS_PIX_Y EQU SCR_WASTELAND_POS_Y * 8                             ; положение пустоши на экране по вертикали в пикселях
SCR_WASTELAND_SIZE_X    EQU 11                                                  ; количество тайлов пустоши на экране по горизонтали
SCR_WASTELAND_SIZE_Y    EQU 10                                                  ; количество тайлов пустоши на экране по вертикали

SCR_MINIMAP_POS_X       EQU 27                                                  ; положение мини карты на экране по горизонтали в знакоместах
SCR_MINIMAP_POS_Y       EQU 2                                                   ; положение мини карты на экране по вертикали в знакоместах
SCR_MINIMAP_POS_PIX_Y   EQU SCR_MINIMAP_POS_Y * 8                               ; положение мини карты на экране по вертикали в пикселях
SCR_MINIMAP_SIZE_X      EQU 32                                                  ; размер мини карты по горизонтали в пикселях
SCR_MINIMAP_SIZE_Y      EQU 32                                                  ; размер мини карты по вертикали в пикселях

                endif ; ~_CONST_GAME_SCREEN_WORLD_
