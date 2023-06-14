
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
                {"DeadlyKom\0"},                                                ; текстовое представление seed генерации мира
                DIFFICULTY_EASY,                                                ; сложность
                CLIMATE_TEMPERATE,                                              ; климат
                MAP_SIZE_SMALL,                                                 ; размер карты
                {                                                               ; центр генерируемого мира                      (не заполняется)
                  0x00, 0x00,                                                   ; low.X
                  0x00, 0x00,                                                   ; high.X
                  0x00, 0x00,                                                   ; low.Y
                  0x00, 0x00                                                    ; high.Y
                },                                      
                0x00,                                                           ; общее количество объектов на карте            (не заполняется)
                0x04,                                                           ; количество радиоактивных зон
                0x05,                                                           ; места обитания существ
                0x05,                                                           ; количество заброшенных/покинутых мест
                0x05,                                                           ; количество поселений "нейтральный"
                0x05,                                                           ; количество поселений "дружественный"
                0x05,                                                           ; количество поселений "враждебный"
                0x05                                                            ; количество подземелий
                }

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAIN_MENU_
