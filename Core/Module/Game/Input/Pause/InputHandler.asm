
                ifndef _MODULE_GAME_INPUT_HANDLER_PAUSE_
                define _MODULE_GAME_INPUT_HANDLER_PAUSE_
INPUT           EQU 0x00
INPUT_WASD      EQU 0x00
INPUT_QAOP      EQU 0x01
INPUT_KEMPSTON  EQU 0x02
SLOT            EQU 0x01
PARTICLE        EQU 0x02
RESUME          EQU 0x03
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
                CP KEY_ID_LEFT                                                  ; клавиша "влево"
                JP Z, Left
                CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                JP Z, Right
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
                
                CALL Game.Render.World.UI.DrawInit
                
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
Left:           LD HL, Game.Render.Pause.Cursor.Dir
                LD (HL), #FF
                RET
Right:          LD HL, Game.Render.Pause.Cursor.Dir
                LD (HL), #01
                RET
Selected:       LD A, (Game.Render.Pause.Cursor)
                CP INPUT
                JR Z, .ApplyInput
                CP SLOT
                JR Z, .ApplySlot
                CP PARTICLE
                JR Z, .ToggleParticle
                CP RESUME
                JR Z, Menu
                RET

.ApplyInput     LD A, (Game.Render.Pause.SelectInput.Selected)
                CP INPUT_WASD
                JP Z, Game.Initialize.Keyboard_WASD
                CP INPUT_QAOP
                JP Z, Game.Initialize.Keyboard_QAOP
                CP INPUT_KEMPSTON
                JP Z, Game.Initialize.Kempston_8
                RET

.ApplySlot      LD A, (Game.Render.Pause.SelectSlot.Selected)
                LD (PlayerState.Slot), A
                RET

.ToggleParticle SWAP_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                RET

                endif ; ~_MODULE_GAME_INPUT_HANDLER_PAUSE_
