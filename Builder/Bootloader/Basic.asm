
                ifndef _BUILDER_BOOTLOADER_
                define _BUILDER_BOOTLOADER_
; -----------------------------------------
; boot загрузчик
; In:
; Out:
; Corrupt:
; Note:
;   #5CD0/#5D40
; -----------------------------------------
Basic:          DB #00, #0A                                                     ; номер строки 10
                DW EndBoot - StartBoot + 2                                      ; длина строки
                DB #EA                                                          ; команда REM

StartBoot:      DI
                ; отключение 128 бейсика
                Disable_128k_Basic
                LD SP, StackTop

                ;
                LD IX, Adr.Kernel
                LD DE, Kernel.Size
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки

                ; вызов загрузчика пакета файлов
                JP #8181

EndBoot:        DB #0D                                                          ; конец строки
                DB #00, #14                                                     ; номер строки 20
                DB #2A, #00                                                     ; длина строки 42 байта
                DB #F9                                                          ; RANDOMIZE
                DB #C0                                                          ; USE
                DB #28                                                          ; (
                DB #BE                                                          ; PEEK
                DB #B0                                                          ; VAL
                DB #22                                                          ; "
                DB #32, #33, #36, #33, #36                                      ; 23636
                DB #22                                                          ; "
                DB #2A                                                          ; *
                DB #32, #35, #36                                                ; 256
                DB #0E, #00, #00, #00, #01, #00                                 ; значение 256
                DB #2B                                                          ; +
                DB #BE                                                          ; PEEK
                DB #B0                                                          ; VAL
                DB #22                                                          ; "
                DB #32, #33, #36, #33, #35                                      ; 23635
                DB #22                                                          ; "
                DB #2B                                                          ; +
                DB #35                                                          ; 5
                DB #0E, #00, #00, #05, #00, #00                                 ; значение 5
                DB #29                                                          ; )
                DB #0D                                                          ; конец строки

                display "Basic :\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endif ; ~_BUILDER_BOOTLOADER_
