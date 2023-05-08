
                ifndef _MACRO_MENU_
                define _MACRO_MENU_
; -----------------------------------------
; установка обработчика игрового цикла
; In:
; Out:
; Corrupt:
; -----------------------------------------
SetMainLoop:    macro Func?
                LD BC, Func?
                LD (Game.MainLoop.Address), BC
                endm
; -----------------------------------------
; установка HL на Game флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
MENU_FLAGS      macro
                LD HL, GameState.MenuFlags
                endm
; -----------------------------------------
; прочитать значения Game флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
MENU_FLAGS_A    macro
                LD A, (GameState.MenuFlags)
                endm
; -----------------------------------------
; проверка Game флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAG macro FlagBit?
                MENU_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка Game флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAGS macro Flags?
                MENU_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка Game флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAG_A macro FlagBit?
                MENU_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка Game флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_MENU_FLAG   macro FlagBit?
                MENU_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Game флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_MENU_FLAG   macro FlagBit?
                MENU_FLAGS
                RES_FLAG FlagBit?
                endm

                endif ; ~_MACRO_MENU_
