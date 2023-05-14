
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
                LD SP, Adr.StackTop

                ; -----------------------------------------
                ; загрузка кернеля                      [2]
                ; -----------------------------------------
                ifndef _DEBUG
                LD IX, Adr.Kernel
                LD DE, Kernel.Size
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; инициализация прерывания
                ; -----------------------------------------
                include "Core/Module/Interrupt/Initialize.asm"

                ; -----------------------------------------
                ; загрузка игры                         [5]
                ; -----------------------------------------
                ifndef _DEBUG
                LD IX, Adr.Module.Game.Main
                LD DE, Game.Size
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; загрузка графики                      [0]
                ; -----------------------------------------
                ifndef _DEBUG
                SET_PAGE_0                                                      ; включить страницу работы с объектами
                LD IX, Adr.Block0.Code
                LD DE, Packs.Size0
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; загрузка графики                      [1]
                ; -----------------------------------------
                ifndef _DEBUG
                SET_PAGE_1                                                      ; включить страницу работы с объектами
                LD IX, Adr.Block1.Code
                LD DE, Packs.Size1
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; загрузка графики                      [3]
                ; -----------------------------------------
                ifndef _DEBUG
                SET_PAGE_3                                                      ; включить страницу графики 1
                LD IX, Adr.Graphics.Pack1
                LD DE, Graphics.Size1
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; загрузка графики                      [4]
                ; -----------------------------------------
                ifndef _DEBUG
                SET_PAGE_4                                                      ; включить страницу графики 2
                LD IX, Adr.Graphics.Pack2
                LD DE, Graphics.Size2
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; -----------------------------------------
                ; загрузка графики                      [6]
                ; -----------------------------------------
                ifndef _DEBUG
                SET_PAGE_6                                                      ; включить страницу работы с объектами
                LD IX, Adr.Module.Pack6
                LD DE, Packs.Size6
                LD A, #FF
                SCF
                CALL BASIC.LD_BYTES
                DEBUG_BREAK_POINT_NC                                            ; ошибка загрузки
                endif

                ; вызов главной функции
                JP Adr.Module.Game.Main
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
