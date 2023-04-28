
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_SCAN_
                define _MODULE_GAME_INPUT_GAMEPLAY_SCAN_
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

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR

                PLAYER_FLAGS
                LD (HL), #00

                ; турбонаддув
                LD A, (GameConfig.KeyAcceleration)
                CALL Input.CheckKeyState
                CALL Z, TurbochargOn
                CALL NZ, TurbochargOff

                ; move map left
                LD A, (GameConfig.KeyLeft)
                CALL Input.CheckKeyState
                CALL Z, RotateLeft

                ; move map right
                LD A, (GameConfig.KeyRight)
                CALL Input.CheckKeyState
                CALL Z, RotateRight

                ; move map up
                LD A, (GameConfig.KeyUp)
                CALL Input.CheckKeyState
                CALL Z, IncreaseSpeed

                ; move map down
                LD A, (GameConfig.KeyDown)
                CALL Input.CheckKeyState
                CALL Z, DecreaseSpeed

                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_SCAN_
