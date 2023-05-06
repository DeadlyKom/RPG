
                ifndef _CONST_CONGIF_
                define _CONST_CONGIF_
INPUT_KEYBOARD      EQU 0x00
INPUT_REDEFINE_KEYS EQU 0x01
INPUT_KEMPSTON_5    EQU 0x02
INPUT_KEMPSTON_8    EQU 0x03
INPUT_MASK          EQU %00000011
INPUT_MASK_INV      EQU (~INPUT_MASK) & 0xFF

G_PARTICLE_BIT      EQU 0x00                                                    ; бит вкл/выкл VFX частиц
G_PARTICLE_ON       EQU 1 << G_PARTICLE_BIT                                     ; флаг вкл VFX частиц
G_PARTICLE_OFF      EQU 0 << G_PARTICLE_BIT                                     ; флаг выкл VFX частиц

                endif ; ~_CONST_CONGIF_
