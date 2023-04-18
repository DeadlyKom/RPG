
                ifndef _MACRO_GAMEPLAY_
                define _MACRO_GAMEPLAY_
; -----------------------------------------
; установка HL на Gameplay флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
GAMEPLAY_FLAGS  macro
                LD HL, GameState.Gameplay
                endm
; -----------------------------------------
; прочитать значения Gameplay флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
GAMEPLAY_FLAGS_A  macro
                LD A, (GameState.Gameplay)
                endm
; -----------------------------------------
; проверка Gameplay флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_GAMEPLAY_FLAG macro FlagBit?
                GAMEPLAY_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка Gameplay флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_GAMEPLAY_FLAGS macro Flags?
                GAMEPLAY_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка Gameplay флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_GAMEPLAY_FLAG_A macro FlagBit?
                GAMEPLAY_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка Gameplay флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_GAMEPLAY_FLAG macro FlagBit?
                GAMEPLAY_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Gameplay флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_GAMEPLAY_FLAG macro FlagBit?
                GAMEPLAY_FLAGS
                RES_FLAG FlagBit?
                endm

                endif ; ~_MACRO_GAMEPLAY_
