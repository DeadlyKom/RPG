
                ifndef _MODULE_GAME_INPUT_HANDLER_PAUSE_
                define _MODULE_GAME_INPUT_HANDLER_PAUSE_
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
                ; JP Z, Game.World.Left
                ; CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                ; JP Z, Game.World.Right
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Selected
                ; CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                ; JP Z, $
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                JR Z, Menu

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
Menu:           LD BC, Game.World.Loop
                LD (Game.MainLoop.Handler), BC
                SetUserHendler Game.World.Interrupt
                RET
Up:             LD HL, Game.Render.Pause.Cursor
                LD A, (HL)
                OR A
                RET Z
                DEC (HL)
                RET
Down:           LD HL, Game.Render.Pause.Cursor
                LD A, (HL)
                INC A
                INC HL
                CP (HL)
                RET NC
                DEC HL
                INC (HL)
                RET
Selected:       LD A, (Game.Render.Pause.Cursor)
                CP #00
                JR Z, .ToggleParticle
                CP #01
                JR Z, Menu
                RET

.ToggleParticle SWAP_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                RET

                endif ; ~_MODULE_GAME_INPUT_HANDLER_PAUSE_
