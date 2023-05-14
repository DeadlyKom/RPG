
                ifndef _MODULE_GAME_INITIALIZE_CORE_
                define _MODULE_GAME_INITIALIZE_CORE_
; -----------------------------------------
; базовая инициализация
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Base:           ; -----------------------------------------
                ; установка бордюра
                ; -----------------------------------------
                BORDER BLACK

                ; -----------------------------------------
                ; подготовка теневого экрана
                ; -----------------------------------------
                LD HL, .CLS
                LD DE, Adr.SharedBuffer
                LD BC, .SizeCLS
                CALL Memcpy.FastLDIR
                CALL Adr.SharedBuffer

                ; -----------------------------------------
                ; подготовка основного экрана
                ; -----------------------------------------
                SHOW_SHADOW_SCREEN                                              ; отобразить теневой экран
                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                ; -----------------------------------------
                ; установка дефолтной конфигурации
                ; -----------------------------------------
                LD HL, .DefaultConfig
                LD DE, Adr.GameConfig
                LD BC, Size.GameConfig
                CALL Memcpy.FastLDIR

                ; -----------------------------------------
                ; очистка состояний игры
                ; -----------------------------------------
                LD HL, Adr.GameState + Size.GameState
                LD DE, #0000
                CALL SafeFill.b32

                ; -----------------------------------------
                ; инициализация таблиц
                ; -----------------------------------------
                CALL Packs.Tables.Gen_ScrAdr                                    ; генерация адресов экрана
                CALL Packs.Tables.Gen_PRNG                                      ; генерация PRNG карты мира
                CALL Packs.Tables.Gen_ShiftTable                                ; генерация таблицы сдвигов
                JP Packs.Tables.Gen_MulSprTable                                 ; генерация таблицы умножения для спрайтов

.CLS            ; -----------------------------------------
                ; блок кода очистки теневого экрана
                ; -----------------------------------------
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                CLS_C000
                ATTR_C000_IPB WHITE, BLACK, 0
                SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                RET
.SizeCLS        EQU $-.CLS

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
                #E901,                                                          ; seed
                #41,                                                            ; frequency
                #C0                                                             ; старший адрес экрана
                {#00, #00},
                #00,
                #0000, #0000,
                #00
                }

                endif ; ~_MODULE_GAME_INITIALIZE_CORE_
