
                ifndef _MODULE_GAME_INPUT_MAP_SCAN_
                define _MODULE_GAME_INPUT_MAP_SCAN_
; -----------------------------------------
; сканирование устроиств ввода
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scan:           ; опрос виртуальных клавиш
                LD DE, InputHandler
                CALL Input.JumpKeys

                ; перемещение карты влево
                LD A, (GameConfig.KeyLeft)
                CALL Input.CheckKeyState
                CALL Z, MovementLeft

                ; перемещение карты вправо
                LD A, (GameConfig.KeyRight)
                CALL Input.CheckKeyState
                CALL Z, MovementRight

                ; перемещение карты вверх
                LD A, (GameConfig.KeyUp)
                CALL Input.CheckKeyState
                CALL Z, MovementUp

                ; перемещение карты вниз
                LD A, (GameConfig.KeyDown)
                CALL Input.CheckKeyState
                CALL Z, MovementDown

                RET

                endif ; ~_MODULE_GAME_INPUT_MAP_SCAN_
