
                ifndef _MODULE_GAME_INPUT_MAP_MENU_
                define _MODULE_GAME_INPUT_MAP_MENU_
; -----------------------------------------
; обработчик клавиш игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InputHandler:   JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши

                ; CP KEY_ID_UP                                                    ; клавиша "вверх"
                ; JR Z, $
                ; CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                ; JR Z, $
                ; CP KEY_ID_LEFT                                                  ; клавиша "влево"
                ; JP Z, $
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, $
                ; CP KEY_ID_SELECT                                                ; клавиша "выбор"
                ; JP Z, $
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                JP Z, Wasteland

.NotProcessing  SCF
                RET
Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
Wasteland:      ; установка запускаемого блока
                LD A, EXECUTE_ID_WASTELAND
                LD (GameState.ExecuteID), A

                ; установка флага завершения цикла, первичной инициализации, обновления
                SET_MENU_FLAGS MENU_LOOP | MENU_STARTUP | MENU_UPDTAE

                JR Processed

                endif ; ~_MODULE_GAME_INPUT_MAP_MENU_
