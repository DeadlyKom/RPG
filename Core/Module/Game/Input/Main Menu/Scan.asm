
                ifndef _MODULE_GAME_INPUT_MAIN_MENU_SCAN_
                define _MODULE_GAME_INPUT_MAIN_MENU_SCAN_
; -----------------------------------------
; сканирование устроиств ввода
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scan:           ; опрос виртуальных клавиш
                LD DE, InputHandler
; -----------------------------------------
; обработчик нажатия/отжатия виртуальной клавиши
; In :
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
                LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
; -----------------------------------------
; вызов обработчика виртуальных клавиш при нажатии/отжатии
; In :
;   HL  - адрес массива состояний виртуальных клавиш
;   DE' - адрес массива виртуальных клавиш
;   B'  - количество виртуальных клавиш в массиве
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
.Loop           LD A, (DE)
                INC DE
                EX AF, AF'
                LD A, (DE)
                INC DE
                EX AF, AF'
                PUSH DE                                                         ; сохранение, адрес массива виртуальных клавиш
                PUSH BC                                                         ; сохранение, количество опрашиваемых клавиш
                EXX
                PUSH HL                                                         ; сохранение, адрес массива состояний виртуальных клавиш
                PUSH DE                                                         ; сохранение, адрес обработчика виртуальных клавиш
                CALL Input.JumpHandlerKey
                POP DE                                                          ; восстановление, адрес обработчика виртуальных клавиш
                POP HL                                                          ; восстановление, адрес массива состояний виртуальных клавиш
                INC HL
                EXX
                POP BC                                                          ; восстановление, количество опрашиваемых клавиш
                POP DE                                                          ; восстановление, адрес массива виртуальных клавиш
                RET NC                                                          ; выход, если обработчик не желает дальнеший опрос
                DJNZ .Loop
                RET

.KeyLastState   DS 9, 0
.ArrayVKNum     DB VK_9,            KEY_ID_SELECT_9                             ; клавиша "выбора"
                DB VK_8,            KEY_ID_SELECT_8                             ; клавиша "выбора"
                DB VK_7,            KEY_ID_SELECT_7                             ; клавиша "выбора"
                DB VK_6,            KEY_ID_SELECT_6                             ; клавиша "выбора"
                DB VK_5,            KEY_ID_SELECT_5                             ; клавиша "выбора"
                DB VK_4,            KEY_ID_SELECT_4                             ; клавиша "выбора"
                DB VK_3,            KEY_ID_SELECT_3                             ; клавиша "выбора"
                DB VK_2,            KEY_ID_SELECT_2                             ; клавиша "выбора"
.LastKey        DB VK_1,            KEY_ID_SELECT_1                             ; клавиша "выбора"
.Num            EQU ($-.ArrayVKNum) / 2

                endif ; ~_MODULE_GAME_INPUT_MAIN_MENU_SCAN_
