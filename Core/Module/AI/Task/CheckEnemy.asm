
                ifndef _CORE_MODULE_AI_TASK_CHECK_ENEMY_
                define _CORE_MODULE_AI_TASK_CHECK_ENEMY_

; -----------------------------------------
; проверка врага в радиусе действия
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
CheckEnemy:     JP AI.SetBTS_SUCCESS                                            ; успешное выполнение

                endif ; ~_CORE_MODULE_AI_TASK_CHECK_ENEMY_
 