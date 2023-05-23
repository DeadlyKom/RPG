
                ifndef _CORE_MODULE_GAME_LOOP_MAP_
                define _CORE_MODULE_GAME_LOOP_MAP_
; -----------------------------------------
; игровой цикл поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Loop:           
.Render         ; ************ RENDER ************
                CHECK_RENDER_FLAG FINISHED_BIT
                RET NZ

                ; проверка завершение цикла главного меню
                CHECK_MENU_FLAG MENU_LOOP_BIT
                JP Z, Render.Draw

                ; сброс флага завершение цикла
                RES_MENU_FLAG MENU_LOOP_BIT

                ; -----------------------------------------
                ; запуск блока по завершению цикла отрисовки
                ; -----------------------------------------

                ; выбор запускаемого блока
                LD A, (GameState.ExecuteID)
                CP EXECUTE_ID_WASTELAND                                         ; идентификатор запуска "пустошь"
                JP Z, Execute.Wasteland                                         ; цикл завершён, запуска блока "пустошь"

                ; цикл завершён
                JR$

                endif ; ~_CORE_MODULE_GAME_LOOP_MAP_
