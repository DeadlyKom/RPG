                ifndef _MACRO_PLAYER_
                define _MACRO_PLAYER_
; -----------------------------------------
; установка HL на World флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
PLAYER_FLAGS    macro
                LD HL, PlayerState.InputFlags
                endm
; -----------------------------------------
; прочитать значения World флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
PLAYER_FLAGS_A  macro
                LD A, (PlayerState.InputFlags)
                endm
; -----------------------------------------
; проверка World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_FLAG macro FlagBit?
                PLAYER_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка World флагов
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_FLAGS macro Flags?
                PLAYER_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка World флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_FLAG_A macro FlagBit?
                PLAYER_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_PLAYER_FLAG macro FlagBit?
                PLAYER_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс World флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_PLAYER_FLAG macro FlagBit?
                PLAYER_FLAGS
                RES_FLAG FlagBit?
                endm

                endif ; ~_MACRO_PLAYER_
