
                ifndef _MODULE_GAME_RENDER_WORLD_
                define _MODULE_GAME_RENDER_WORLD_
; -----------------------------------------
; отображение карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
World:          SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; скрол карты мира в зависимости от состояний флагов
                CHECK_WORLD_FLAG WORLD_LEFT_BIT
                CALL NZ, Game.World.MoveLeft
                CHECK_WORLD_FLAG WORLD_RIGHT_BIT
                CALL NZ, Game.World.MoveRight
                CHECK_WORLD_FLAG WORLD_UP_BIT
                CALL NZ, Game.World.MoveUp
                CHECK_WORLD_FLAG WORLD_DOWN_BIT
                CALL NZ, Game.World.MoveDown

				; сортировка видимых объектов
                CALL Sort.Object

                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                
                RestoreBC                                                       ; защита от повреждения данных во время прерывания
                CALL Draw.World
                CALL Draw.Minimap
                CALL Object.Draw

                ; show position
                ifdef _DEBUG
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                ; LD DE, #0000
                ; CALL Console.SetCursor
                ; LD HL, PlayerState.CameraPosX+3
                ; CALL Console.DrawWordFrom
                ; LD HL, PlayerState.CameraPosX+1
                ; CALL Console.DrawWordFrom
                ; LD A, (PlayerState.CameraPosX)
                ; CALL Console.DrawByte
                ; LD HL, World.Shift_X
                ; LD A, (HL)
                ; CALL Console.DrawByte
                ; LD HL, PlayerState.DeltaCameraPixX
                ; LD A, (HL)
                ; CALL Console.DrawByte

                ; LD DE, #0100
                ; CALL Console.SetCursor
                ; LD HL, PlayerState.CameraPosY+3
                ; CALL Console.DrawWordFrom
                ; LD HL, PlayerState.CameraPosY+1
                ; CALL Console.DrawWordFrom
                ; LD A, (PlayerState.CameraPosY)
                ; CALL Console.DrawByte
                ; LD HL, World.Shift_Y
                ; LD A, (HL)
                ; CALL Console.DrawByte
                ; LD HL, PlayerState.DeltaCameraPixY
                ; LD A, (HL)
                ; CALL Console.DrawByte
                
                LD DE, #0200
                CALL Console.SetCursor
                LD A, (PlayerState.RotationAngle)
                AND #7F
                CALL Console.DrawByte
                LD A, (PlayerState.Speed)
                CALL Console.DrawByte

                ; LD DE, #0300
                ; CALL Console.SetCursor
                ; LD A, (PlayerState.DeltaCameraX)
                ; CALL Console.DrawByte
                ; LD A, (PlayerState.DeltaCameraY)
                ; CALL Console.DrawByte
                
                LD DE, #0400
                CALL Console.SetCursor
                LD A, (GameState.Objects)                                       ; количество объектов на карте мира
                CALL Console.DrawByte
                LD A, (Object.Draw.Num)                                         ; количество видимых объектоа на экране
                CALL Console.DrawByte

                LD DE, #0500
                CALL Console.SetCursor
                PLAYER_FLAGS_A
                CALL Console.DrawByte
                endif


                ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

                endif ; ~_MODULE_GAME_RENDER_WORLD_
