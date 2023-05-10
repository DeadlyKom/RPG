
                ifndef _CORE_MODULE_UTILS_STRING_COPY_
                define _CORE_MODULE_UTILS_STRING_COPY_
; -----------------------------------------
; копирование строки
; In:
;   HL - адрес места назначения
;   DE - адрес источника (включая завершающий нулевой символ)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Copy:           LD A, (HL)
                LDI
                OR A
                RET Z
                JR Copy

                endif ; ~_CORE_MODULE_UTILS_STRING_COPY_
