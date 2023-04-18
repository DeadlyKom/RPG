
                ifndef _CORE_MODULE_AI_TASK_ATTACK_
                define _CORE_MODULE_AI_TASK_ATTACK_

; -----------------------------------------
; атака цели
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AttackTo:       JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_ATTACK_
