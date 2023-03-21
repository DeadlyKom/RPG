
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
                define _MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
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

                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Up
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Down
                ; CP KEY_ID_LEFT                                                  ; клавиша "влево"
                ; JP Z, Left
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, Right
                ; CP KEY_ID_SELECT                                                ; клавиша "выбор"
                ; JP Z, $
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                ; CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                ; JP Z, $

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Up:             CALL Game.World.Left
                JR Processed
Down:           JP Game.World.Right

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_HANDLER_
