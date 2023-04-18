                ifndef _MACRO_CONFIG_GRAPHICS_
                define _MACRO_CONFIG_GRAPHICS_
; -----------------------------------------
; установка HL на Config.Graphics флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
CONFIG_GRAPHIC_FLAGS    macro
                LD HL, GameConfig.Graphics
                endm
; -----------------------------------------
; прочитать значения Config.Graphics флагов в аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CONFIG_GRAPHICFLAGS_A  macro
                LD A, (GameConfig.Graphics)
                endm
; -----------------------------------------
; проверка Config.Graphics флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_CONFIG_GRAPHIC_FLAG macro FlagBit?
                CONFIG_GRAPHIC_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; проверка Config.Graphics флага используя аккумулятор
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_CONFIG_GRAPHIC_FLAG_A macro FlagBit?
                CONFIG_GRAPHIC_FLAGS_A
                CHECK_FLAG_A FlagBit?
                endm
; -----------------------------------------
; установка Config.Graphics флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_CONFIG_GRAPHIC_FLAG macro FlagBit?
                CONFIG_GRAPHIC_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Config.Graphics флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_CONFIG_GRAPHIC_FLAG macro FlagBit?
                CONFIG_GRAPHIC_FLAGS
                RES_FLAG FlagBit?
                endm
; -----------------------------------------
; сменить на противоположный Config.Graphics флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SWAP_CONFIG_GRAPHIC_FLAG macro FlagBit?
                CONFIG_GRAPHIC_FLAGS
                SWAP_FLAG FlagBit?
                endm
                endif ; ~_MACRO_CONFIG_GRAPHICS_
