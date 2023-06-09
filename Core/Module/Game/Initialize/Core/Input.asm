
                ifndef _MODULE_GAME_INITIALIZE_INPUT_
                define _MODULE_GAME_INITIALIZE_INPUT_
; -----------------------------------------
; инициализация управления
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          ; инициализация кемпстон джойстика
                CALL Kempston.Initialize  
                
.Apply          ; настройка обработчика ввода
                LD A, (GameConfig.Options)
                AND INPUT_MASK
                CP INPUT_KEYBOARD
                JR Z, Keyboard_WASD
                CP INPUT_REDEFINE_KEYS
                RET Z

                ; проверка на установку кемстон джойстика
                CHECK_HARDWARE_FLAG HARDWARE_KEMPSTON_BIT
                JR Z, .SetKeyboard                                              ; переход, т.к. кемпстон ранее не был обнаружен
                                                                                ; установка клавиатуры
                ; провкра на инициализацию 5 кнопочного
                CP INPUT_KEMPSTON_5
                JR Z, Kempston_5

                ; провкра наличия 8 кнопочного
                CHECK_FLAG HARDWARE_KEMPSTON_BUTTON_BIT
                JR Z, .SetKempston5                                             ; переход, т.к. кемпстон ранее был обнаружен только 5 кнопочный
                                                                                ; установка 5 кнопочного кемпстона
                ; провкра на инициализацию 8 кнопочного
                CP INPUT_KEMPSTON_8
                JR Z, Kempston_8

.SetKeyboard    ; установка клавиатуры
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_KEYBOARD
                LD (GameConfig.Options), A
                JR Input.Apply

.SetRedefineKeys; установка клавиатуры (переназначеные клавиши)
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_REDEFINE_KEYS
                LD (GameConfig.Options), A
                JR Input.Apply

.SetKempston5   ; установка 5 кнопочного кемстона
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_KEMPSTON_5
                LD (GameConfig.Options), A
                JR Input.Apply

.SetKempston8   ; установка 8 кнопочного кемстона
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_KEMPSTON_8
                LD (GameConfig.Options), A
                JR Input.Apply
; -----------------------------------------
; инициализация управление клавиатурой WASD
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Keyboard_WASD:  LD HL, .PresetKeys
                JR ApplyPresetKeys
.PresetKeys     DB VK_ENTER                                                     ; клавиша по умолчанию "меню/пауза"
                DB VK_CAPS_SHIFT                                                ; клавиша по умолчанию "ускорить"
                DB VK_SYMBOL_SHIFT                                              ; клавиша по умолчанию "oтмена"
                DB VK_SPACE                                                     ; клавиша по умолчанию "выбор"
                DB VK_D                                                         ; клавиша по умолчанию "вправо"
                DB VK_A                                                         ; клавиша по умолчанию "влево"
                DB VK_S                                                         ; клавиша по умолчанию "вниз"
                DB VK_W                                                         ; клавиша по умолчанию "вверх"
; -----------------------------------------
; инициализация управление клавиатурой QAOP
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Keyboard_QAOP:  LD HL, .PresetKeys
                JR ApplyPresetKeys
.PresetKeys     DB VK_ENTER                                                     ; клавиша по умолчанию "меню/пауза"
                DB VK_CAPS_SHIFT                                                ; клавиша по умолчанию "ускорить"
                DB VK_SYMBOL_SHIFT                                              ; клавиша по умолчанию "oтмена"
                DB VK_SPACE                                                     ; клавиша по умолчанию "выбор"
                DB VK_P                                                         ; клавиша по умолчанию "вправо"
                DB VK_O                                                         ; клавиша по умолчанию "влево"
                DB VK_A                                                         ; клавиша по умолчанию "вниз"
                DB VK_Q                                                         ; клавиша по умолчанию "вверх"
; -----------------------------------------
; инициализация управление кемпстон джойстиком 5 клавиш
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Kempston_5:     LD HL, .PresetKeys
                JR ApplyPresetKeys
.PresetKeys     DB VK_ENTER                                                     ; клавиша по умолчанию "меню/пауза"
                DB VK_CAPS_SHIFT                                                ; клавиша по умолчанию "ускорить"
                DB VK_KEMPSTON_B                                                ; клавиша по умолчанию "oтмена"
                DB VK_SPACE                                                     ; клавиша по умолчанию "выбор"
                DB VK_KEMPSTON_RIGHT                                            ; клавиша по умолчанию "вправо"
                DB VK_KEMPSTON_LEFT                                             ; клавиша по умолчанию "влево"
                DB VK_KEMPSTON_DOWN                                             ; клавиша по умолчанию "вниз"
                DB VK_KEMPSTON_UP                                               ; клавиша по умолчанию "вверх"
; -----------------------------------------
; инициализация управление кемпстон джойстиком 8 клавиш
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Kempston_8:     LD HL, .PresetKeys
                JR ApplyPresetKeys
.PresetKeys     DB VK_KEMPSTON_START                                            ; клавиша по умолчанию "меню/пауза"
                DB VK_KEMPSTON_C                                                ; клавиша по умолчанию "ускорить"
                DB VK_KEMPSTON_B                                                ; клавиша по умолчанию "oтмена"
                DB VK_KEMPSTON_A                                                ; клавиша по умолчанию "выбор"
                DB VK_KEMPSTON_RIGHT                                            ; клавиша по умолчанию "вправо"
                DB VK_KEMPSTON_LEFT                                             ; клавиша по умолчанию "влево"
                DB VK_KEMPSTON_DOWN                                             ; клавиша по умолчанию "вниз"
                DB VK_KEMPSTON_UP                                               ; клавиша по умолчанию "вверх"
; -----------------------------------------
; инициализация управление клавиатурой
; In:
;   HL - адрес предустановленных клавиш
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ApplyPresetKeys ; копирование пресета клавиш в конфигурацию
                LD DE, GameConfig.Keys
                rept NUMBER_KEYS_ID
                LDI
                endr

                ; инициализация клавиш клавиатуры
                DEC DE
                EX DE, HL
                LD DE, Input.ArrayKeys

                ; копирование из конфигурации в функцию обработки клавиш
                rept NUMBER_KEYS_ID-1
                LDD
                DEC DE
                endr
                LDD
ResetStateKeys: ; обнуление состояний виртуальных клавиш
                LD H, D
                LD L, E
                DEC DE
                LD (HL), #00
                rept NUMBER_KEYS_ID-1
                LDD
                endr

                RET

                endif ; ~_MODULE_GAME_INITIALIZE_INPUT_
