
                    ifndef _CONST_GAME_
                    define _CONST_GAME_
GameConfig          EQU Adr.GameConfig                                          ; адрес структуры конфигурации игры
.Seed               EQU GameConfig + FGameConfig.Seed                           ; адрес seed текущей сессии
.Frequency          EQU GameConfig + FGameConfig.Frequency                      ; частота шума перлина
.SpriteRef          EQU GameConfig + FGameConfig.Sprite                         ; данные спрайта
.SpriteOffsetRef    EQU GameConfig + FGameConfig.Sprite.Data.Low                ; флаги спрайта (смещение)
.SpriteFlagRef      EQU GameConfig + FGameConfig.Sprite.Data.High               ; флаги спрайта
.OffsetY            EQU GameConfig + FGameConfig.CompositeY                     ; смещение по вертикали для композитного спрайта
.Array              EQU GameConfig + FGameConfig.Animation                      ; массив анимаций
.Element_0          EQU GameConfig + FGameConfig.Animation + 0                  ; 1 элемент массив анимаций
.Element_1          EQU GameConfig + FGameConfig.Animation + 1                  ; 2 элемент массив анимаций
.Element_2          EQU GameConfig + FGameConfig.Animation + 2                  ; 3 элемент массив анимаций
.Element_3          EQU GameConfig + FGameConfig.Animation + 3                  ; 4 элемент массив анимаций
.SpriteCounter      EQU GameConfig + FGameConfig.SpriteCounter                  ; флаги композитного спрайта/счётчика спрайтов

GameState           EQU Adr.GameState                                           ; адрес структуры состояния игры
.Render             EQU GameState + FGameState.Render                           ; флаги отрисовки
.World              EQU GameState + FGameState.World                            ; флаги отрисовки мира
.Gameplay           EQU GameState + FGameState.Gameplay                         ; флаги геймплея
.Hardware           EQU GameState + FGameState.Hardware                         ; флаги железа
.Objects            EQU GameState + FGameState.Objects                          ; количество объектов в массиве

PlayerState         EQU Adr.PlayerState
.CameraPosX         EQU PlayerState + FPlayerState.CameraPosX                   ; позиция карты мира по горизонтали
.CameraPosY         EQU PlayerState + FPlayerState.CameraPosY                   ; позиция карты мира по вертикали
.CameraShiftX       EQU PlayerState + FPlayerState.CameraShiftX                 ; смещение карты мира по горизонтали
.CameraShiftY       EQU PlayerState + FPlayerState.CameraShiftY                 ; смещение карты мира по вертикали
.Speed              EQU PlayerState + FPlayerState.Speed                        ; скорость игрока
.RotationAngle      EQU PlayerState + FPlayerState.RotationAngle                ; угол поворота игрока
.DeltaCameraX       EQU PlayerState + FPlayerState.DeltaCameraX                 ; дельта камеры по горизонтали
.DeltaCameraY       EQU PlayerState + FPlayerState.DeltaCameraY                 ; дельта камеры по вертикали

.Debug              EQU PlayerState + FPlayerState.Debug                        ; отладочная

                    endif ; ~_CONST_GAME_
