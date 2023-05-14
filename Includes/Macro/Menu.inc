
                ifndef _MACRO_MENU_
                define _MACRO_MENU_
; -----------------------------------------
; установка HL на Menu флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
MENU_FLAGS      macro
                LD HL, GameState.MenuFlags
                endm
; -----------------------------------------
; прочитать значения Menu флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
MENU_FLAGS_A    macro
                LD A, (GameState.MenuFlags)
                endm
; -----------------------------------------
; проверка Menu флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAG macro FlagBit?
                MENU_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка Menu флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAGS macro Flags?
                MENU_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка Menu флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_MENU_FLAG_A macro FlagBit?
                MENU_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка Menu флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_MENU_FLAG   macro FlagBit?
                MENU_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; установка Menu флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_MENU_FLAGS  macro Flags?
                MENU_FLAGS
                SET_FLAGS Flags?
                endm
; -----------------------------------------
; сброс Menu флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_MENU_FLAG   macro FlagBit?
                MENU_FLAGS
                RES_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Menu флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_FLAGS       macro
                MENU_FLAGS
                RES_ALL
                endm

                endif ; ~_MACRO_MENU_
