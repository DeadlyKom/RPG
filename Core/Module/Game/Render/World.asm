
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
                
                CALL Draw.World
                CALL Game.Input.Gameplay.Scan
                ; CHECK_RENDER_FLAG GEN_BIT
                ; CALL Z, Game.World.Generate

                ; show position
                LD DE, #0000
                CALL Console.SetCursor
                LD HL, Game.World.Generate.X
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
                LD HL, Game.World.Generate.Y
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
