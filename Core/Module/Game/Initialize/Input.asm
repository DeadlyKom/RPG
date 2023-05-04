
                ifndef _MODULE_GAME_INITIALIZE_INPUT_
                define _MODULE_GAME_INITIALIZE_INPUT_
; -----------------------------------------
; инициализация управления
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          ; настройка обработчика ввода
                LD A, (GameConfig.Options)
                AND INPUT_MASK
                CP INPUT_KEYBOARD
                JR Z, Keyboard_WASD
                CP INPUT_KEMPSTON_8
                JR Z, Kempston_8

.SetKeyboard    ; установка клавиатуры
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_KEYBOARD
                LD (GameConfig.Options), A
                JR Input

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
