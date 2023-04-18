
                ifndef _CORE_MODULE_AI_TASK_MOVE_TO_
                define _CORE_MODULE_AI_TASK_MOVE_TO_

; -----------------------------------------
; перемещение к цели
; In:
;   IX - указывает на структуру FObject
; Out:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveTo:         JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_MOVE_TO_
