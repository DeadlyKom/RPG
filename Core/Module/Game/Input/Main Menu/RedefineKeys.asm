
                ifndef _MODULE_GAME_INPUT_MAIN_MENU_REDEFINE_KEYS_
                define _MODULE_GAME_INPUT_MAIN_MENU_REDEFINE_KEYS_
ScanRedefine:   LD HL, .Table
                LD B, NUMBER_KEYS_ID
.Loop           PUSH BC
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                PUSH HL
                EX DE, HL
                LD A, (HL)
                RES 7, A
                CP VK_NONE
                CALL Z, .Redefine
                POP HL
                POP BC
                DJNZ .Loop
                RET

.Table          DW GameConfig.KeyUp
                DW GameConfig.KeyDown
                DW GameConfig.KeyLeft
                DW GameConfig.KeyRight
                DW GameConfig.KeySelect
                DW GameConfig.KeyBack
                DW GameConfig.KeyAcceleration
                DW GameConfig.KeyMenu

; -----------------------------------------
; опрос клавиш
; In:
;   HL - адрес опрашиваемой клавиши в конфигурации
; Out:
; Corrupt:
; Note:
; -----------------------------------------
.Redefine       CALL Keyboard.GetPressedKey
                JR C, .Pressed
                CALL Kempston.GetPressedKey
                RET NC

.Pressed        LD C, E
                
                ; проверка коллизии клавиш
                LD DE, GameConfig.Keys
                LD B, NUMBER_KEYS_ID
.CollisionLoop  LD A, E
                CP L
                JR Z, .Next
                LD A, (DE)
                RES 7, A
                CP C
                JR Z, .IsCollision
.Next           INC E
                DJNZ .CollisionLoop

                ; установка нажатой клавиши
                SET 7, C
                LD (HL), C

                ; ожидание отпускание ранее нажатой клавиши
.WaitKeyboard   CALL Keyboard.GetPressedKey
                JR C, .WaitKeyboard
                ; проверка наличия кемстон джойстика
                CHECK_HARDWARE_FLAG HARDWARE_KEMPSTON_BIT
                JR Z, .Skip
.WaitKempston   CALL Kempston.GetPressedKey
                JR C, .WaitKempston
.Skip
                ; сброс флага опроса клавиш
                LD HL, RedefineFlag
                LD (HL), #00
                RET

.IsCollision    JP SFX.BEEP.Fail

                endif ; ~_MODULE_GAME_INPUT_MAIN_MENU_REDEFINE_KEYS_
