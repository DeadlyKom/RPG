
                ifndef _CORE_MODULE_UTILS_TIME_TICK_
                define _CORE_MODULE_UTILS_TIME_TICK_
; -----------------------------------------
; тик времени
; In:
;   IX - адрес структуры FTime
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Tick:           ; 1/50 секунды
                LD A, (IX + FTime.Interrupt)
                ADD A, #01
                DAA
                LD (IX + FTime.Interrupt), A

                CP #50
                RET NZ
                LD (IX + FTime.Interrupt), #00

                ; секунды
                LD A, (IX + FTime.Seconds)
                ADD A, #01
                DAA
                LD (IX + FTime.Seconds), A

                CP #60
                RET NZ
                LD (IX + FTime.Seconds), #00

                ; минуты
                LD A, (IX + FTime.Minutes)
                ADD A, #01
                DAA
                LD (IX + FTime.Minutes), A

                CP #60
                RET NZ
                LD (IX + FTime.Minutes), #00

                ; часы
                LD A, (IX + FTime.Hour)
                ADD A, #01
                DAA
                LD (IX + FTime.Hour), A

                CP #24
                RET NZ
                LD (IX + FTime.Hour), #00

                ; день
                LD A, (IX + FTime.Years)
                AND #03
                LD HL, .DayTable
                JR NZ, $+5
                LD HL, .LeapDayTable

                LD A, (IX + FTime.Month)
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                LD C, (HL)
                LD A, (IX + FTime.Day)
                ADD A, #01
                DAA
                LD (IX + FTime.Day), A

                CP C
                RET NZ
                LD (IX + FTime.Day), #00
                
                ; месяц
                LD A, (IX + FTime.Month)
                ADD A, #01
                DAA
                LD (IX + FTime.Month), A

                CP #12
                RET NZ
                LD (IX + FTime.Month), #00

                ; год
                LD HL, (IX + FTime.Years)
                INC HL
                LD (IX + FTime.Years), HL

                RET

.DayTable       DB 31, 28, 31, 30, 31, 30, 31
                DB 31, 30, 31, 30, 31
.LeapDayTable   DB 31, 29, 31, 30, 31, 30, 31
                DB 31, 30, 31, 30, 31

                endif ; ~_CORE_MODULE_UTILS_TIME_TICK_
