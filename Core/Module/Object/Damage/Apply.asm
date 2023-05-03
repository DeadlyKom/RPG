
                ifndef _CORE_MODULE_OBJECT_DAMAGE_APPLY_
                define _CORE_MODULE_OBJECT_DAMAGE_APPLY_
; -----------------------------------------
; применить урон и проверка уничтожения
; In:
;   IX - адрес объекта FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Apply:          JR NC, .IsLive
                JP Object.Remove

.IsLive         LD (IX + FObject.Character.Health), A
                RET

                endif ; ~ _CORE_MODULE_OBJECT_DAMAGE_APPLY_
