
                ifndef _CORE_MODULE_AI_TASK_IDLE_
                define _CORE_MODULE_AI_TASK_IDLE_

; -----------------------------------------
; поведение - бездействие юнита
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Idle:           JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_IDLE_
