
                    ifndef _CONST_GAME_
                    define _CONST_GAME_
GameConfig          EQU Adr.GameConfig                                          ; адрес структуры конфигурации игры
.Seed               EQU GameConfig + FGameConfig.Seed                           ; адрес seed текущей сессии
.Frequency          EQU GameConfig + FGameConfig.Frequency                      ; частота шума перлина
GameState           EQU Adr.GameState                                           ; адрес структуры состояния игры
.Render             EQU GameState + FGameState.Render                           ; флаги отрисовки
.World              EQU GameState + FGameState.World                            ; флаги отрисовки мира
.Gameplay           EQU GameState + FGameState.Gameplay                         ; флаги геймплея
.Hardware           EQU GameState + FGameState.Hardware                         ; флаги железа
.PositionX          EQU GameState + FGameState.PositionX                        ; позиция карты мира по горизонтали
.PositionY          EQU GameState + FGameState.PositionY                        ; позиция карты мира по вертикали

                    endif ; ~_CONST_GAME_
