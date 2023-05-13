
                ifndef _CORE_MODULE_DIALOG_GET_ID_
                define _CORE_MODULE_DIALOG_GET_ID_
; -----------------------------------------
; отображение скрола
; In:
;   A  - пункт опции
;   IY - указатель на структуру FDialog
; Out:
;   C  - уникальный ID пункта
; Corrupt:
; Note:
; -----------------------------------------
GetID:          ; инициализация
                LD HL, (IY + FDialog.Available)
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

                RET

                endif ; ~_CORE_MODULE_DIALOG_GET_ID_

