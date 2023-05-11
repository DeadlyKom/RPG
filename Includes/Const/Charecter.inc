
                ifndef _CONST_CHARECTER_
                define _CONST_CHARECTER_
CHAR_STATE_NONE     EQU 0x00
CHAR_STATE_IDLE     EQU 0x00
CHAR_STATE_TOLK     EQU 0x00


; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | F1 | F0 | .. | .. | S3 | S2 | S1 | S0 |
;   +----+----+----+----+----+----+----+----+
;
;   F1,F0   [7,6]   - фрейм анимации персонажа
;   S3-S0   [3..0]  - тип состояния персонажа
; -----------------------------------------
CHAR_STATE_MASK     EQU %00001111
CHAR_FRAME_MASK     EQU %00000011

                endif ; ~_CONST_CHARECTER_
