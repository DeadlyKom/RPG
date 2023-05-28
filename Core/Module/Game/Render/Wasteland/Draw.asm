
                ifndef _MODULE_GAME_RENDER_WASTELAND_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_DRAW_
; -----------------------------------------
; отображение пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; -----------------------------------------
                ; обновление положения
                ; -----------------------------------------
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; скрол карты мира в зависимости от состояний флагов
                CHECK_WORLD_FLAG WORLD_LEFT_BIT
                CALL NZ, Packs.OpenWorld.Wasteland.MoveLeft
                CHECK_WORLD_FLAG WORLD_RIGHT_BIT
                CALL NZ, Packs.OpenWorld.Wasteland.MoveRight
                CHECK_WORLD_FLAG WORLD_UP_BIT
                CALL NZ, Packs.OpenWorld.Wasteland.MoveUp
                CHECK_WORLD_FLAG WORLD_DOWN_BIT
                CALL NZ, Packs.OpenWorld.Wasteland.MoveDown
                
                ; -----------------------------------------
                ; подготовка
                ; -----------------------------------------
                CALL Sort.Object                                                ; сортировка видимых объектов
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                RestoreBC                                                       ; защита от повреждения данных во время прерывания
                
                ; -----------------------------------------
                ; обновление пустоши
                ; -----------------------------------------
                CALL Draw.World

                ; -----------------------------------------
                ; обновление миникарты
                ; -----------------------------------------
                CALL Draw.Minimap

                ; -----------------------------------------
                ; обновление объектов
                ; -----------------------------------------
                CALL OBJ_Draw

                ; -----------------------------------------
                ; обновление стрелки
                ; -----------------------------------------
                CALL Draw.WorldArrow
                
                ; -----------------------------------------
                ; обновление UI 
                ; -----------------------------------------
                CALL UI.Update

                ifdef _DEBUG
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                ; позиция X
                LD DE, #0000
                CALL Console.SetCursor
                LD A, '('
                CALL Console.DrawChar
                LD BC, (PlayerState.CameraPosX + 3)
                CALL Console.DrawWord
                LD BC, (PlayerState.CameraPosX + 1)
                CALL Console.DrawWord
                ; позиция Y
                LD A, ','
                CALL Console.DrawChar
                LD BC, (PlayerState.CameraPosY + 3)
                CALL Console.DrawWord
                LD BC, (PlayerState.CameraPosY + 1)
                CALL Console.DrawWord
                LD A, ')'
                CALL Console.DrawChar
                ; количество объектов
                LD DE, #0014
                CALL Console.SetCursor
                LD A, (GameState.Objects)
                CALL Console.DrawByte
                LD A, '/'
                ; количество видимых объектов
                CALL Console.DrawChar
                LD A, (Packs.Wasteland.Render.OBJ_Draw.Num)
                CALL Console.DrawByte
                endif

                ; -----------------------------------------
                ; готовность экрана
                ; -----------------------------------------

                ifdef _DEBUG
                SET_SCREEN_SHADOW                                               ; включение страницы теневого экрана
                CALL FPS_Counter.Frame
                endif
                
                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_DRAW_
