
                ifndef _MODULE_GAME_INPUT_HANDLER_GAMEPLAY_
                define _MODULE_GAME_INPUT_HANDLER_GAMEPLAY_
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
                ; JP Z, Game.World.Up
                ; CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                ; JP Z, Game.World.Down
                ; CP KEY_ID_LEFT                                                  ; клавиша "влево"
                ; JP Z, Game.World.Left
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, Game.World.Right
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Spawn
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                JP Z, Menu

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
Menu:           LD A, #B7       ; OR A
                LD (Game.Render.Pause.Menu.First), A
                LD BC, Game.Pause.Loop
                LD (Game.MainLoop.Handler), BC
                SetUserHendler Game.Pause.Interrupt
                RET
Spawn:          LD IX, PLAYER_ADR
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD A, (PlayerState.Slot)
                CP Game.Render.World.UI.SLOT_MINE
                JP Z, Object.Spawn_Mine
                RET

                endif ; ~_MODULE_GAME_INPUT_HANDLER_GAMEPLAY_
