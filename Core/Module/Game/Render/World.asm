
                ifndef _MODULE_GAME_RENDER_WORLD_
                define _MODULE_GAME_RENDER_WORLD_
; -----------------------------------------
; отображение карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          SET_SCREEN_SHADOW
                
                RestoreBC                                                       ; защита от повреждения данных во время прерывания
                
                CALL Draw.World
                CALL Draw.Minimap

                CALL Game.Input.Gameplay.Scan
                CHECK_WORLD_FLAG WORLD_LEFT_BIT
                CALL NZ, Game.World.MoveLeft
                CHECK_WORLD_FLAG WORLD_RIGHT_BIT
                CALL NZ, Game.World.MoveRight
                ; CHECK_WORLD_FLAG WORLD_DOWN_BIT
                ; CALL NZ, Game.World.MoveDown

                ; show position
                LD DE, #0000
                CALL Console.SetCursor
                LD HL, GameState.PositionX+1
                LD A, (HL)
                CALL Console.DrawByte
                LD DE, #0002
                CALL Console.SetCursor
                LD HL, World.Shift_X
                LD A, (HL)
                CALL Console.DrawByte
                LD DE, #0004
                CALL Console.SetCursor
                LD HL, Game.World.Delta
                LD A, (HL)
                CALL Console.DrawByte

                LD DE, #0100
                CALL Console.SetCursor
                LD HL, GameState.PositionY+1
                LD A, (HL)
                CALL Console.DrawByte
                LD DE, #0102
                CALL Console.SetCursor
                LD HL, World.Shift_Y
                LD A, (HL)
                CALL Console.DrawByte

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки

                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                RET

                endif ; ~_MODULE_GAME_RENDER_WORLD_
