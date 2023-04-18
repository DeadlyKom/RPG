
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
Menu:           ;
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

.Rendered       ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.ShowMenu       CALL InitVariables

                LD A, COLOR_TEXT
                CALL Console.SetAttribute
                
                LD DE, #0508
                CALL Console.SetCursor
                LD BC, Space
                CALL Console.DrawString
                LD DE, #0608
                CALL Console.SetCursor
                LD BC, Particle
                CALL Console.DrawString
                LD DE, #0708
                CALL Console.SetCursor
                LD BC, Resume_Text
                CALL Console.DrawString
                LD DE, #0808
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
                RET
Space           BYTE "               \0"
Particle        BYTE " Particle  [ ] \0"
.Value          EQU $-4
Resume_Text     BYTE " Resume        \0"
Cursor          DB #00
.Num            DB #02

                endif ; ~_MODULE_GAME_RENDER_PAUSE_MENU_
