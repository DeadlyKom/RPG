
                ifndef _MODULE_GAME_INPUT_SETTLEMENT_MENU_
                define _MODULE_GAME_INPUT_SETTLEMENT_MENU_
COLUMN_BUILD    EQU 7 * 8
ROW_BUILD       EQU 18 * 8
LIST_WIDTH      EQU 24 * 8                                                      ; доступная ширина дял списка (в пикселях)
LIST_HEIGHT     EQU 5 * 8                                                       ; доступная высота дял списка (в пикселях)
HEIGHT_ROW      EQU 10                                                          ; высота строки (в пикселях)
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

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; расчёт адреса поселения в котором находится игрок
                LD A, (PlayerState.MetadataID)
                CALL Packs.OpenWorld.Utils.CalcMetadata

                ; текущая позиция
                LD A, (GameState.CursorID + 0)
                LD (GameState.CursorID + 1), A
        
                ; -----------------------------------------
                ; приведение локальной ID к глобальной
                ; -----------------------------------------
                INC A
                LD B, A

                ; подготовка данных для прокрутки
                LD L, (IX + FSettlement.Building)
                LD H, #FF
                LD (.Available), HL
                LD HL, .Available

                ; инициализция
                LD A, -1
                LD C, A

.Loop           INC A
                INC C
                BIT 3, A
                JR Z, $+4
                INC HL
                XOR A
                SRL (HL)
                JR NC, .Loop
                DJNZ .Loop

                LD A, C
                LD (PlayerState.SettlementLocID), A

                CP MENU_ID_WASTELAND
                JR NZ, Processed

                ; установка флага завершения цикла
                SET_MENU_FLAGS MENU_LOOP
                SET_WORLD_FLAG WORLD_NEED_TO_GENERATE_BIT                       ; установка флага, генерации данных

                RET

.Available      DW #0000

                endif ; ~_MODULE_GAME_INPUT_SETTLEMENT_MENU_
