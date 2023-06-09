
                ifndef _CORE_MODULE_GAME_LOOP_WASTELAND_
                define _CORE_MODULE_GAME_LOOP_WASTELAND_
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
.FuncDraw       EQU $+1
                JP Z, $

                ; сброс флага завершение цикла
                RES_MENU_FLAG MENU_LOOP_BIT

                ; -----------------------------------------
                ; запуск блока по завершению цикла отрисовки
                ; -----------------------------------------

                ; выбор запускаемого блока
                LD A, (GameState.ExecuteID)
                CP EXECUTE_ID_MAP                                               ; идентификатор запуска "карта"
                JP Z, Execute.Map                                               ; цикл завершён, запуска блока "карта"

                ; цикл завершён
                JR$

                endif ; ~_CORE_MODULE_GAME_LOOP_WASTELAND_
