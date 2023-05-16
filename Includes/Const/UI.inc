
                ifndef _CONST_UI_
                define _CONST_UI_
HEALTH_BAR      EQU 0x01
GAS_BAR         EQU 0x02
TURBO_BAR       EQU 0x03

SLOT_NONE       EQU 0x00
SLOT_MACHINEGUN EQU 0x01
SLOT_MINE       EQU 0x02
SLOT_ROCKET     EQU 0x03
SLOT_REPAIRKIT  EQU 0x03

RENDER_HEALTH_BIT   EQU 0x07                                                    ; флаг необходимости отрисовки UI значка "сердце"
RENDER_GAS_BIT      EQU 0x05                                                    ; флаг необходимости отрисовки UI значка "канистра"
RENDER_TURBO_BIT    EQU 0x03                                                    ; флаг необходимости отрисовки UI значка "нагнетатель"
RENDER_SLOT_BIT     EQU 0x01                                                    ; флаг необходимости отрисовки UI значка "слот"

RENDER_SHIFT_MASK   EQU %10101010
RENDER_HEALTH_FORCE EQU %11000000
RENDER_GAS_FORCE    EQU %00110000
RENDER_TURBO_FORCE  EQU %00001100
RENDER_SLOT_FORCE   EQU %00000011

VISIBLE_HEALTH_BIT  EQU 0x07                                                    ; флаг видимости UI значка "сердце"
VISIBLE_GAS_BIT     EQU 0x06                                                    ; флаг видимости UI значка "канистра"
VISIBLE_TURBO_BIT   EQU 0x05                                                    ; флаг видимости UI значка "нагнетатель"
VISIBLE_SLOT_BIT    EQU 0x04                                                    ; флаг видимости UI значка "слот"

SPRITE_HEALTH_BIT   EQU 0x01                                                    ; номер спрайта UI значка "сердце"
SPRITE_TURBO_BIT    EQU 0x00                                                    ; номер спрайта UI значка "нагнетатель"

VISIBLE_HEALTH      EQU 1 << VISIBLE_HEALTH_BIT
VISIBLE_GAS         EQU 1 << VISIBLE_GAS_BIT
VISIBLE_TURBO       EQU 1 << VISIBLE_TURBO_BIT
VISIBLE_SLOT        EQU 1 << VISIBLE_SLOT_BIT

SPRITE_HEALTH       EQU 1 << SPRITE_HEALTH_BIT
SPRITE_TURBO        EQU 1 << SPRITE_TURBO_BIT

                endif ; ~_CONST_UI_
