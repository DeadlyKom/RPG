
                ifndef _STRUCT_PLAYER_
                define _STRUCT_PLAYER_

                struct FPlayerState
SettlementID    DB #00                                                          ; ID поселения в котором находится игрок        [1 байт]
SettlementLocID DB #00                                                          ; ID места в котором находится игрок            [1 байт]
CharacterID     DB #00                                                          ; ID вид персонажа                              [1 байт]
InputFlags      DB #00                                                          ; флаги управления игроком                      [1 байт]
Health          DW #0000                                                        ; уровень очков здоровья                        [4 байта]
                DW #0000
Gas             DW #0000                                                        ; уровень очков бензина                         [4 байта]
                DW #0000
Turbo           DW #0000                                                        ; уровень очков ускорения                       [4 байта]
                DW #0000
NearestObject   DW #0000                                                        ; адрес ближайшего противника                   [2 байта]
Slot            DB #00                                                          ; номер расходника в слоте                      [1 байт]
CameraPosX      FPNInt40                                                        ; позиция на карте мира по горизонтали          [5 байт]
CameraPosY      FPNInt40                                                        ; позиция на карте мира по вертикали            [5 байт]
RotationAngle   DB #00                                                          ; угол поворота игрока                          [1 байт]
DeltaCameraX    DB #00                                                          ; дельта камеры по горизонтали                  [1 байт]
DeltaCameraPixX DB #00                                                          ; дельта камеры по горизонтали * 0.125          [1 байт]
                                                                                ; (фактическая) в пикселях
DeltaCameraY    DB #00                                                          ; дельта камеры по вертикали                    [1 байт]
DeltaCameraPixY DB #00                                                          ; дельта камеры по вертикали * 0.125            [1 байт]
                                                                                ; (фактическая) в пикселях
GameTime        FTime                                                           ; внутреннее время игры                         [8 байт]
SessionTime     FTime                                                           ; время сессии игры                             [8 байт]
DebugX          DW #00
DebugY          DW #00
                ends

                endif ; ~_STRUCT_GAME_
