
                ifndef _MODULE_GAME_INITIALIZE_CORE_
                define _MODULE_GAME_INITIALIZE_CORE_
; -----------------------------------------
; инициализация ядра
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Core:           ; -----------------------------------------
                ; установка бордюра
                ; -----------------------------------------
                BORDER BLACK

                ; -----------------------------------------
                ; установка дефолтной конфигурации
                ; -----------------------------------------
                LD HL, .DefaultConfig
                LD DE, Adr.GameConfig
                LD BC, Size.GameConfig
                LDIR
                
                ; -----------------------------------------
                ; подготовка теневого экрана
                ; -----------------------------------------
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                CLS_C000
                ATTR_C000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_03_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_03_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                ; -----------------------------------------
                ; инициализация таблиц
                ; -----------------------------------------
                CALL Generation.ScrAdr                                          ; генерация адресов экрана
                CALL Generation.PRNG                                            ; генерация PRNG карты мира
                CALL Generation.ShiftTable                                      ; генерация таблицы сдвигов
                CALL Generation.MulSprTable                                     ; генерация таблицы умножения для спрайтов
                CALL Generation.WorldSprite                                     ; генерация спрайтов для карты мира

                ; -----------------------------------------
                ; подготовка основного экрана
                ; -----------------------------------------
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана
                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_01_SCR, SCR_WORLD_POS_X, SCR_WORLD_POS_Y, SCR_WORLD_SIZE_X * 2 - 1, SCR_WORLD_SIZE_Y * 2, BLACK, WHITE, 0
                ATTR_RECT_IPB MemBank_01_SCR, 27, 2, 4, 4, WHITE, BLACK, 0
                ATTR_RECT_IPB MemBank_01_SCR, 28, 3, 2, 2, WHITE, BLACK, 1

                ; -----------------------------------------
                ; инициализация отображения мира
                ; -----------------------------------------
                CALL Game.World.Generate
                CALL Game.Render.World.UI.DrawInit

                ; -----------------------------------------
                ; инициализация обработчика прерываний
                ; -----------------------------------------
                SetUserHendler Game.World.Interrupt
               
                RET

.DefaultConfig  FGameConfig {
                VK_ENTER,                                                       ; клавиша по умолчанию "меню/пауза"
                VK_CAPS_SHIFT,                                                  ; клавиша по умолчанию "ускорить"
                VK_SYMBOL_SHIFT,                                                ; клавиша по умолчанию "oтмена"
                VK_SPACE,                                                       ; клавиша по умолчанию "выбор"
                VK_D,                                                           ; клавиша по умолчанию "вправо"
                VK_A,                                                           ; клавиша по умолчанию "влево"
                VK_S,                                                           ; клавиша по умолчанию "вниз"
                VK_W,                                                           ; клавиша по умолчанию "вверх"
                INPUT_KEYBOARD,                                                 ; флаги
                G_PARTICLE_OFF,
                #006E,                                                          ; seed
                #41,                                                            ; frequency
                {#00, #00},
                #00,
                #0000, #0000,
                #00
                }

                endif ; ~_MODULE_GAME_INITIALIZE_CORE_
