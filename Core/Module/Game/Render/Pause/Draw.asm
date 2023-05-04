
                ifndef _MODULE_GAME_RENDER_PAUSE_MENU_
                define _MODULE_GAME_RENDER_PAUSE_MENU_

                define TEXT_INC BLACK
                define TEXT_PAPER WHITE
                define TEXT_BRIGHT 0
                define TEXT_FLASH 0
COLOR_TEXT       EQU ((TEXT_FLASH << 7) | (TEXT_BRIGHT << 6) | (TEXT_PAPER << 3) | TEXT_INC)

; -----------------------------------------
; отображение меню паузы игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ;
.First          EQU $
                OR A                ; B7
                JR C, .ShowMenu

                CALL Screen.SetPageShadow
                CALL FadeoutScreen

                CALL Screen.Swap
                LD HL, MemBank_03_SCR
                LD DE, MemBank_01_SCR
                AND PAGE_MASK
                CP 5
                JR NZ, .SkipSwap
                EX DE, HL
                CALL Screen.SetPageShadow
.SkipSwap       LD BC, ScreenSize
                LDIR

                LD A, #37           ; SCF
                LD (.First), A

                ; инициализация текущего состояния
                LD A, (PlayerState.Slot)
                LD (SelectSlot.Selected), A
                CALL SelectSlot.Calc

.Rendered       ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.ShowMenu       CALL InitVariables

                LD A, COLOR_TEXT
                CALL Console.SetAttribute
                
                ; рисование пустоты
                LD DE, #0508
                CALL Console.SetCursor
                LD BC, Space
                CALL Console.DrawString

                ; рисование опции инпута
                LD DE, #0608
                CALL Console.SetCursor
.InputText      EQU $+1
                LD BC, Keyboard_WASD
                CALL Console.DrawString

                ; рисование слот оружия
                LD DE, #0708
                CALL Console.SetCursor
.SlotText       EQU $+1
                LD BC, Slot_None
                CALL Console.DrawString

                ; рисование опции VFX частиц
                LD DE, #0808
                CALL Console.SetCursor
                LD BC, Particle
                CALL Console.DrawString

                ; рисование продолжить
                LD DE, #0908
                CALL Console.SetCursor
                LD BC, Resume_Text
                CALL Console.DrawString

                ; рисование пустоты
                LD DE, #0A08
                CALL Console.SetCursor
                LD BC, Space
                CALL Console.DrawString

                LD A, (Cursor)
                ADD A, #06
                LD D, A
                LD E, #08
                CALL Console.SetCursor
                LD A,'>'
                CALL Console.DrawChar

                JR .Rendered

FadeoutScreen:  LD HL, #C000
                LD DE, #AA55
                LD BC, #0018

.Loop           LD A, D
                LD D, E
                LD E, A
            
.LoopRow        LD A, (HL)
                AND E
                LD (HL), A
                INC HL
                DJNZ .LoopRow

                DEC C
                JR NZ, .Loop

                RET
InitVariables   ; -----------------------------------------
                ; инициализация переменных
                ; -----------------------------------------
                CHECK_CONFIG_GRAPHIC_FLAG G_PARTICLE_BIT
                LD A, '-'
                JR Z, .L1
                LD A, '+'
.L1             LD (Particle.Value), A

                LD A, (Cursor.Dir)
                OR A
                RET Z
                LD C, A

                ;сброс направления
                XOR A
                LD (Cursor.Dir), A

                LD A, (Cursor)
                CP #00                                                          ; Input
                JR Z, SelectInput
                CP #01                                                          ; Slot
                JR Z, SelectSlot
                RET

SelectInput     LD A, (.Selected)
                ADD A, C
                RET M

                CP #03
                RET NC

                LD (.Selected), A

                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                ADD A, A    ; x16

                ADD A, LOW Keyboard_WASD
                LD E, A
                ADC A, HIGH Keyboard_WASD
                SUB E
                LD D, A

                LD HL, Menu.InputText
                LD (HL), E
                INC HL
                LD (HL), D

                RET
.Selected       DB #00

SelectSlot      LD A, (.Selected)
                ADD A, C
                RET M

                CP #05
                RET NC

                LD (.Selected), A

.Calc           ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                ADD A, A    ; x16

                ADD A, LOW Slot_None
                LD E, A
                ADC A, HIGH Slot_None
                SUB E
                LD D, A

                LD HL, Menu.SlotText
                LD (HL), E
                INC HL
                LD (HL), D

                RET

.Selected       DB #00

Space           BYTE "               \0"
Keyboard_WASD   BYTE " Keyboard WASD \0"
Keyboard_QAOP   BYTE " Keyboard QAOP \0"
Kempston        BYTE " Kempston 8but \0"
Slot_None       BYTE " None          \0"
Slot_MachineGun BYTE " Machine Gun   \0"
Slot_Mine       BYTE " Mine          \0"
Slot_Rocket     BYTE " Rocket        \0"
Slot_RepairKit  BYTE " Repair Kit    \0"
Particle        BYTE " Particle  [ ] \0"
.Value          EQU $-4
Resume_Text     BYTE " Resume        \0"
Cursor          DB #00
.Num            DB #04
.Dir            DB #00

                endif ; ~_MODULE_GAME_RENDER_PAUSE_MENU_
