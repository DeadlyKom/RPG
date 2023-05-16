                ifndef _MACRO_PLAYER_INPUT_
                define _MACRO_PLAYER_INPUT_
; -----------------------------------------
; установка HL на инпут флаги игрока флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
PLAYER_INPUT_FLAGS macro
                LD HL, PlayerState.InputFlags
                endm
; -----------------------------------------
; прочитать значения инпут флагов игрока в аккумуляторе
; In:
; Out:
; Corrupt:
; -----------------------------------------
PLAYER_INPUT_FLAGS_A  macro
                LD A, (PlayerState.InputFlags)
                endm
; -----------------------------------------
; проверка инпут флага игрока
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_INPUT_FLAG macro FlagBit?
                PLAYER_INPUT_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка инпут флага игрока
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_INPUT_FLAGS macro Flags?
                PLAYER_INPUT_FLAGS_A
                CHECK_FLAGS Flags?
                endm
; -----------------------------------------
; проверка инпут флага игрока используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_PLAYER_INPUT_FLAG_A macro FlagBit?
                PLAYER_INPUT_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка инпут флага игрока флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_PLAYER_INPUT_FLAG macro FlagBit?
                PLAYER_INPUT_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс инпут флага игрока флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_PLAYER_INPUT_FLAG macro FlagBit?
                PLAYER_INPUT_FLAGS
                RES_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс инпут флагов игрока флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_PLAYER_INPUT_FLAGS macro
                PLAYER_INPUT_FLAGS
                RES_ALL
                endm

                endif ; ~_MACRO_PLAYER_INPUT_
