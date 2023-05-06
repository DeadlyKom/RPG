
                ifndef _INPUT_MENPSTON_INITIALIZE_
                define _INPUT_MENPSTON_INITIALIZE_
; -----------------------------------------
; инициализация кемпстон джойстика
; In :
; Out :
;   флаг переполнения Carry сброшен, если кемпстон обнаружен
; Corrupt :
;   HL, E, BC, AF
; Note:
;   благодарность от https://t.me/Jerri1977 (C)
; -----------------------------------------
Initialize:     ; проверка наличия 5 кнопочного (класического)
                LD BC, #001F
                LD L, B
                LD E, B

.Loop           IN A, (C)
                OR E
                LD E, A
                DEC L
                JR NZ, .Loop

                LD A, E
                AND C
                JR NZ, .Error

                SET_HARDWARE_FLAG HARDWARE_KEMPSTON_BIT

                ; проверка возможности наличия 8 кнопочного
                IN A, (C)
                AND %11100000
                JR Z, .Button_8

.Button_5       RES_HARDWARE_FLAG HARDWARE_KEMPSTON_BUTTON_BIT
                ifdef _DEBUG
                LD HL, MemBank_01_SCR + ScreenSize - 1
                LD (HL), %10000100
                endif
                RET

.Button_8       SET_HARDWARE_FLAG HARDWARE_KEMPSTON_BUTTON_BIT
                ifdef _DEBUG
                LD HL, MemBank_01_SCR + ScreenSize - 1
                LD (HL), %10000001
                endif
                RET

.Error          RES_HARDWARE_FLAG HARDWARE_KEMPSTON_BIT
                SCF
                ifdef _DEBUG
                LD HL, MemBank_01_SCR + ScreenSize - 1
                LD (HL), %10000010
                endif
                RET
                
                endif ; ~_INPUT_MENPSTON_INITIALIZE_