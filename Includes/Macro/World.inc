                ifndef _MACRO_WORLD_
                define _MACRO_WORLD_
; -----------------------------------------
; установка HL на World флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
WORLD_FLAGS     macro
                LD HL, GameState.World
                endm
; -----------------------------------------
; прочитать значения World флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
WORLD_FLAGS_A   macro
                LD A, (GameState.World)
                endm
; -----------------------------------------
; проверка World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_WORLD_FLAG macro FlagBit?
                WORLD_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка World флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_WORLD_FLAGS macro Flags?
                WORLD_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка World флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_WORLD_FLAG_A macro FlagBit?
                WORLD_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_WORLD_FLAG macro FlagBit?
                WORLD_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; установка World флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_WORLD_FLAGS macro Flags?
                WORLD_FLAGS
                SET_FLAGS Flags?
                endm
; -----------------------------------------
; сброс World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_WORLD_FLAG macro FlagBit?
                WORLD_FLAGS
                RES_FLAG FlagBit?
                endm

                endif ; ~_MACRO_WORLD_
