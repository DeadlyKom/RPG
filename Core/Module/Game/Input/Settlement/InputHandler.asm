
                ifndef _MODULE_GAME_INPUT_SETTLEMENT_MENU_
                define _MODULE_GAME_INPUT_SETTLEMENT_MENU_
COLUMN_BUILD    EQU 7 * 8
ROW_BUILD       EQU 18 * 8
LIST_WIDTH      EQU 24 * 8                                                      ; доступная ширина дял списка (в пикселях)
LIST_HEIGHT     EQU 5 * 8                                                       ; доступная высота дял списка (в пикселях)
HEIGHT_ROW      EQU 9                                                           ; высота строки (в пикселях)
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
                JR Z, Up
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JR Z, Down
                ; CP KEY_ID_LEFT                                                  ; клавиша "влево"
                ; JP Z, $
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, $
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Selected
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                ; CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                ; JR Z,$

.NotProcessing  SCF
                RET
Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
Up:             CALL Cursor.Up
                JR Processed
Down:           CALL Cursor.Down
                JR Processed
Selected:       ; установка флага обновления, необходимости скролить меню вверх
                SET_MENU_FLAGS MENU_UPDTAE

                ; текущая позиция
                LD A, (GameState.CursorID)
                LD (PlayerState.SettlementLocID), A
                
                JR Processed

                endif ; ~_MODULE_GAME_INPUT_SETTLEMENT_MENU_
