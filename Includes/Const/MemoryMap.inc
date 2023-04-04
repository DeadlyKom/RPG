
                ifndef _CONST_MEMORY_MAP_
                define _CONST_MEMORY_MAP_

; bank 01 (#4000 - #7FFF)
Adr:
.StackTop       EQU MemBank_01 + Size.Stack                                     ; расположение стека
.SharedBuffer   EQU SharedBuffer                                                ; адрес буфера общего назначения
.RenderBuffer   EQU RenderBuffer                                                ; адрес буфера отображения
.Port_7FFD      EQU PORT_7FFD                                                   ; адрес хранения номера странички

; bank 02 (#8000 - #BFFF)
.Interrupt      EQU #8181                                                       ; адрес вектора прерывания
.Kernel         EQU Adr.Interrupt                                               ; адрес блока кернела

; bank 03 (#С000 - #СFFF)
.Screens        EQU MemBank_03_SCR                                              ; адрес экранов 5/7

                endif ; ~_CONST_MEMORY_MAP_
