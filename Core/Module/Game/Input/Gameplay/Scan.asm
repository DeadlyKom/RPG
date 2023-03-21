
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

                ; ; проверка необходимости опроса мыши
                ; LD A, (GameConfig.Options)
                ; AND INPUT_MASK
                ; CP INPUT_MOUSE
                ; RET NZ                                                          ; выход, если мышь не оправшивается

                ; ; проверка HardWare ограничения мыши
                ; LD HL, GameFlags.Hardware
                ; BIT HW_MOUSE_BIT, (HL)
                ; CALL Z, Mouse.UpdateCursor                                      ; обновить положение курсора, если мышь доступна
                
                RES_RENDER_FLAG INERT_BIT                                    ; установка флага завершения отрисовки

                ; move map left
                LD A, VK_A
                CALL Input.CheckKeyState
                CALL Z, Game.World.Left

                ; move map right
                LD A, VK_D
                CALL Input.CheckKeyState
                CALL Z, Game.World.Right

                CHECK_RENDER_FLAG INERT_BIT
                JR Z, .RES

                LD HL, .Counter
                DEC (HL)
                RET NZ
                LD (HL), #50


                LD HL, Game.World.Delta
                LD A, (HL)
                ADD A, #22
                RET C
                LD (HL), A


                ; ; move map up
                ; LD A, VK_W
                ; CALL Input.CheckKeyState
                ; CALL Z, Up

                ; ; move map down
                ; LD A, VK_S
                ; CALL Input.CheckKeyState
                ; CALL Z, Down

                RET
.Counter        DB #50

.RES            LD HL, Game.World.Delta
                LD (HL), #22
                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_SCAN_
