
                ifndef _CORE_MODULE_AI_TASK_WAIT_
                define _CORE_MODULE_AI_TASK_WAIT_

; -----------------------------------------
; ожидать
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Wait:           JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_WAIT_
