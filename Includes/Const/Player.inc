
                ifndef _CONST_PLAYER_
                define _CONST_PLAYER_

MAX_FORWARD_SPEED       EQU 40
MAX_TURBOCHARGING_SPEED EQU 60
MAX_REVERSE_SPEED       EQU 16

TURBOCHARGING_BIT       EQU 0x00                                                ; флаг включения турбонаддува
ROTATE_LEFT_BIT         EQU 0x01
ROTATE_RIGHT_BIT        EQU 0x02
INCREASE_SPEED_BIT      EQU 0x03
DECREASE_SPEED_BIT      EQU 0x04

TURBOCHARGING           EQU 1 << TURBOCHARGING_BIT                              ; флаг включения турбонаддува
ROTATE_LEFT             EQU 1 << ROTATE_LEFT_BIT
ROTATE_RIGHT            EQU 1 << ROTATE_RIGHT_BIT
INCREASE_SPEED          EQU 1 << INCREASE_SPEED_BIT
DECREASE_SPEED          EQU 1 << DECREASE_SPEED_BIT

                endif ; ~_CONST_PLAYER_
