
                ifndef _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
                define _CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
; -----------------------------------------
; инициализация главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MainMenu:       ; установка бордюра
                BORDER BLACK

                ; инициализация главного цикла
                SetGameLoop Packs.MainMenu.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.MainMenu.Interrupt

                ; инициализация стартового ID меню
                LD A, MENU_ID_MAIN
                LD (GameState.MenuID), A

                ; инициализация структуры генерации мира
                LD HL, .DefaultWorld
                LD DE, Adr.SortBuffer
                PUSH DE
                LD BC, FGenerateWorld
                LDIR
                POP IY

                RET

.DefaultWorld   FGenerateWorld {
                {"Beaver\0"},                                                   ; текстовое представление seed генерации мира
                DIFFICULTY_EASY,                                                ; сложность
                CLIMATE_TEMPERATE,                                              ; климат
                MAP_SIZE_AVERAGE,                                               ; размер карты
                {                                                               ; центр генерируемого мира
                  0x00, 0x00,                                                   ; low.X
                  0x00, 0x80,                                                   ; high.X
                  0x00, 0x00,                                                   ; low.Y
                  0x00, 0x80                                                    ; high.Y
                },                                      
                0x01,                                                           ; общее количество объектов на карте
                0x00,                                                           ; количество радиоактивных зон
                0x00,                                                           ; места обитания существ
                0x00,                                                           ; количество заброшенных/покинутых мест
                0x01,                                                           ; количество поселений
                0x00                                                           ; количество подземелий
                }

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
