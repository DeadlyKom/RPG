
                ifndef _MODULE_GAME_RENDER_WORLD_
                define _MODULE_GAME_RENDER_WORLD_
; -----------------------------------------
; отображение карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          ; скрол карты мира в зависимости от состояний флагов
                CHECK_WORLD_FLAG WORLD_LEFT_BIT
                CALL NZ, Game.World.MoveLeft
                CHECK_WORLD_FLAG WORLD_RIGHT_BIT
                CALL NZ, Game.World.MoveRight
                CHECK_WORLD_FLAG WORLD_UP_BIT
                CALL NZ, Game.World.MoveUp
                CHECK_WORLD_FLAG WORLD_DOWN_BIT
                CALL NZ, Game.World.MoveDown

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                
                RestoreBC                                                       ; защита от повреждения данных во время прерывания
                CALL Draw.World
                CALL Draw.Minimap
                CALL Object.Draw

                ; show position
                ifdef _DEBUG
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                LD DE, #0000
                CALL Console.SetCursor
                LD HL, PlayerState.CameraPosX+3
                CALL Console.DrawWordFrom
                LD HL, PlayerState.CameraPosX+1
                CALL Console.DrawWordFrom
                LD HL, World.Shift_X
                LD A, (HL)
                CALL Console.DrawByte

                LD DE, #0100
                CALL Console.SetCursor
                LD HL, PlayerState.CameraPosY+3
                CALL Console.DrawWordFrom
                LD HL, PlayerState.CameraPosY+1
                CALL Console.DrawWordFrom
                LD HL, World.Shift_Y
                LD A, (HL)
                CALL Console.DrawByte
                
                LD DE, #0200
                CALL Console.SetCursor
                LD A, (PlayerState.RotationAngle)
                AND #7F
                CALL Console.DrawByte
                LD A, (PlayerState.Speed)
                CALL Console.DrawByte

                LD DE, #0300
                CALL Console.SetCursor
                LD A, (PlayerState.DeltaCameraX)
                CALL Console.DrawByte
                LD A, (PlayerState.DeltaCameraY)
                CALL Console.DrawByte
                ; LD A, (PlayerState.Debug)
                ; CALL Console.DrawByte
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки

                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                RET

                endif ; ~_MODULE_GAME_RENDER_WORLD_
