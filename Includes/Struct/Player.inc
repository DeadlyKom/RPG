
                ifndef _STRUCT_PLAYER_
                define _STRUCT_PLAYER_

                struct FPlayerState
CameraPosX      FPNInt40                                                        ; позиция на карте мира по горизонтали          [5 байт]
CameraPosY      FPNInt40                                                        ; позиция на карте мира по вертикали            [5 байт]
Speed           DB #00                                                          ; скорость игрока                               [1 байт]
RotationAngle   DB #00                                                          ; угол поворота игрока                          [1 байт]
DeltaCameraX    DB #00
Debug           DB #00
                ends

                endif ; ~_STRUCT_GAME_
