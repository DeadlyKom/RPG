
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
                ; LD DE, InputHandler
                ; CALL Input.JumpKeys

                ; ; проверка необходимости опроса мыши
                ; LD A, (GameConfig.Options)
                ; AND INPUT_MASK
                ; CP INPUT_MOUSE
                ; RET NZ                                                          ; выход, если мышь не оправшивается

                ; ; проверка HardWare ограничения мыши
                ; LD HL, GameFlags.Hardware
                ; BIT HW_MOUSE_BIT, (HL)
                ; CALL Z, Mouse.UpdateCursor                                      ; обновить положение курсора, если мышь доступна
                

                ; move map left
                LD A, VK_A
                CALL Input.CheckKeyState
                CALL Z, RotateLeft

                ; move map right
                LD A, VK_D
                CALL Input.CheckKeyState
                CALL Z, RotateRight

                ; move map up
                LD A, VK_W
                CALL Input.CheckKeyState
                CALL Z, IncreaseSpeed

                ; move map down
                LD A, VK_S
                CALL Input.CheckKeyState
                CALL Z, DecreaseSpeed

                ; турбонаддув
                LD A, VK_SPACE
                CALL Input.CheckKeyState
                CALL Z, TurbochargOn
                CALL NZ, TurbochargOff

                ifdef _DEBUG
                ; move map left
                LD A, VK_J
                CALL Input.CheckKeyState
                CALL Z, Game.World.Left

                ; move map right
                LD A, VK_L
                CALL Input.CheckKeyState
                CALL Z, Game.World.Right

                ; move map up
                LD A, VK_I
                CALL Input.CheckKeyState
                CALL Z, Game.World.Up

                ; move map down
                LD A, VK_K
                CALL Input.CheckKeyState
                CALL Z, Game.World.Down
                endif

                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_SCAN_
