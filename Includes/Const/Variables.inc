
                    ifndef _CONST_GAME_VARIABLES_
                    define _CONST_GAME_VARIABLES_
GameConfig          EQU Adr.GameConfig                                          ; адрес структуры конфигурации игры
.Keys               EQU GameConfig + FGameConfig.KeyMenu                        ; массив клавиш
.KeyUp              EQU GameConfig + FGameConfig.KeyUp                          ; клавиша по умолчанию "Вверх"
.KeyDown            EQU GameConfig + FGameConfig.KeyDown                        ; клавиша по умолчанию "Вниз"
.KeyLeft            EQU GameConfig + FGameConfig.KeyLeft                        ; клавиша по умолчанию "Влево"
.KeyRight           EQU GameConfig + FGameConfig.KeyRight                       ; клавиша по умолчанию "Вправо"
.KeySelect          EQU GameConfig + FGameConfig.KeySelect                      ; клавиша по умолчанию "выбор"
.KeyBack            EQU GameConfig + FGameConfig.KeyBack                        ; клавиша по умолчанию "Отмена"
.KeyAcceleration    EQU GameConfig + FGameConfig.KeyAcceleration                ; клавиша по умолчанию "ускорить"
.KeyMenu            EQU GameConfig + FGameConfig.KeyMenu                        ; клавиша по умолчанию "меню/пауза"

.Options            EQU GameConfig + FGameConfig.Options                        ; флаги опций
.Graphics           EQU GameConfig + FGameConfig.Graphics                       ; флаги графики
.Screen             EQU GameConfig + FGameConfig.Screen                         ; текущий адрес рабочего окна
.SpriteRef          EQU GameConfig + FGameConfig.Sprite                         ; данные спрайта
.SpriteOffsetRef    EQU GameConfig + FGameConfig.Sprite.Data.Low                ; флаги спрайта (смещение)
.SpriteFlagRef      EQU GameConfig + FGameConfig.Sprite.Data.High               ; флаги спрайта
.UpEdgeChar         EQU GameConfig + FGameConfig.UpEdgeChar                     ; верхняя граница вывода спрайтов (в знакоместах)
.DownEdgeChar       EQU GameConfig + FGameConfig.DownEdgeChar                   ; нижняя граница вывода спрайтов (в знакоместах)
.LeftEdgeChar       EQU GameConfig + FGameConfig.LeftEdgeChar                   ; левая граница вывода спрайтов (в знакоместах)
.RightEdgeChar      EQU GameConfig + FGameConfig.RightEdgeChar                  ; правая граница вывода спрайтов (в знакоместах)
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
.Setting            EQU GameState + FGameState.Setting                          ; флаги настройки игры
.Objects            EQU GameState + FGameState.Objects                          ; количество объектов в массиве
.Region             EQU GameState + FGameState.Region                           ; количество регионов в массиве
.Metadata           EQU GameState + FGameState.Metadata                         ; количество метаданные в массиве
.ExecuteID          EQU GameState + FGameState.ExecuteID                        ; идентификатор запуска блока
.CharacterID        EQU GameState + FGameState.CharacterID                      ; ID отображаемого персонажа
.CharacterState     EQU GameState + FGameState.CharacterState                   ; состояние отображаемого персонажа
.MenuID             EQU GameState + FGameState.MenuID                           ; тип меню
.MenuFlags          EQU GameState + FGameState.MenuFlags                        ; флаги меню
.CursorID           EQU GameState + FGameState.CursorID                         ; ID пункта
.Cursor             EQU GameState + FGameState.Cursor                           ; позиция курсора (в режиме выбора)
.Cursor.Old         EQU GameState + FGameState.Cursor.Old                       ; прошлая позиция курсора (в режиме выбора) 
.Cursor.Top         EQU GameState + FGameState.Cursor.Top                       ; верхняя граница курсора
.Cursor.Num         EQU GameState + FGameState.Cursor.Num                       ; количество позиций выбора
.Cursor.Coord.X     EQU GameState + FGameState.Cursor.Coord + 0                 ; позиция курсора по горизонтали (в пикселях)
.Cursor.Coord.Y     EQU GameState + FGameState.Cursor.Coord + 1                 ; позиция курсора по вертикали (в пикселях)
.Cursor.Avail       EQU GameState + FGameState.Cursor.Avail                     ; доступная высота
.Cursor.Dir         EQU GameState + FGameState.Cursor.Dir                       ; направление движения (для инпута)
                                                                                ;   #01 - вперёд (+1 позиция)
                                                                                ;   #FF - назда (-1 позиция)
PlayerState         EQU Adr.PlayerState
.MetadataID         EQU PlayerState + FPlayerState.MetadataID                   ; ID метаданных в котором находится игрок
.SettlementLocID    EQU PlayerState + FPlayerState.SettlementLocID              ; ID места в котором находится игрок
.CharacterID        EQU PlayerState + FPlayerState.CharacterID                  ; ID персонажа
.InputFlags         EQU PlayerState + FPlayerState.InputFlags                   ; флаги управления игроком
.Health             EQU PlayerState + FPlayerState.Health                       ; уровень очков здоровья
.Gas                EQU PlayerState + FPlayerState.Gas                          ; уровень очков бензина
.Turbo              EQU PlayerState + FPlayerState.Turbo                        ; уровень очков ускорения
.Wasteland_RF       EQU PlayerState + FPlayerState.UI.Wasteland_RF              ; флаги отображени элементов UI
.Wasteland_SF       EQU PlayerState + FPlayerState.UI.Wasteland_SF              ; состояние элементов UI
.NearestObject      EQU PlayerState + FPlayerState.NearestObject                ; адрес ближайшего противника
.Slot               EQU PlayerState + FPlayerState.Slot                         ; номер расходника в слоте
.MapPosX            EQU PlayerState + FPlayerState.MapPosX                      ; позиция (левого-верхнего края) карты по горизонтали
.MapPosY            EQU PlayerState + FPlayerState.MapPosY                      ; позиция (левого-верхнего края) карты по вертикали
.WorldLeftTopPos    EQU PlayerState + FPlayerState.WorldLeftTopPos              ; позиция левого-верхнего края карты мира
.CameraPosX         EQU PlayerState + FPlayerState.CameraPosX                   ; позиция карты мира по горизонтали
.CameraPosY         EQU PlayerState + FPlayerState.CameraPosY                   ; позиция карты мира по вертикали
.RotationAngle      EQU PlayerState + FPlayerState.RotationAngle                ; угол поворота игрока
.DeltaCameraX       EQU PlayerState + FPlayerState.DeltaCameraX                 ; дельта камеры и игрока по горизонтали в знакоместах
.DeltaCameraPixX    EQU PlayerState + FPlayerState.DeltaCameraPixX              ; дельта камеры по горизонтали * 0.125 (фактическая) в пикселях
.DeltaCameraY       EQU PlayerState + FPlayerState.DeltaCameraY                 ; дельта камеры и игрока по вертикали в знакоместах
.DeltaCameraPixY    EQU PlayerState + FPlayerState.DeltaCameraPixY              ; дельта камеры по вертикали * 0.125 (фактическая) в пикселях
.GameTime           EQU PlayerState + FPlayerState.GameTime                     ; внутреннее время игры
.SessionTime        EQU PlayerState + FPlayerState.SessionTime                  ; время сессии игры

.DebugX             EQU PlayerState + FPlayerState.DebugX                       ; отладочная информация
.DebugY             EQU PlayerState + FPlayerState.DebugY                       ; отладочная информация

                    endif ; ~_CONST_GAME_VARIABLES_
