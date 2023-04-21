
                ifndef _MATH_ATAN_SECTOR_
                define _MATH_ATAN_SECTOR_

                module Math
; -----------------------------------------
; определение сектора
; In :
;   DE - дельта значений знаковое число (D - y, E - x)
; Out :
;   A  - номер сектора [0..15] << 3
; Corrupt :
;   HL
; Note:
;   https://stackoverflow.com/a/68913345
;
;
;                 349.75d         11.25d, tan=0.2034523
;                    \             /
;                     \   Sector  /      
;                      \    0    /  22.5d tan = ?2 - 1
;                   15      |      1   33.75
;                           |         /   45d, tan = 1
;              14           |            2 _56.25
;                           |             /  67.5d, tan = 1 + ?2
;           13              |               3
;                           |                __ 78.75
;                           |                
;          12---------------+----------------4 90d tan = infty
;                           |                __ 101.25
;                           |                
;           11              |               5
;                           |               
;              10           |            6
;                           |          
;                   9       |      7
;                           8
;
; // use signs to map sectors:
; static const int8_t map[4][5] = {  /* +n means n >= 0, -n means n < 0 */
;   /* 0: +x +y */ {0, 1, 2, 3, 4},
;   /* 1: +x -y */ {8, 7, 6, 5, 4},
;   /* 2: -x +y */ {0, 15, 14, 13, 12},
;   /* 3: -x -y */ {8, 9, 10, 11, 12}
; };

; int8_t sector(int8_t x, int8_t y) { // x,y signed in range -128:127, result 0:15 from north, clockwise.
;   int16_t tangent; // 16 bits
;   int8_t quadrant = 0;
;   if (x > 0) x = -x; else quadrant |= 2; // make both negative avoids issue with negating -128 
;   if (y > 0) y = -y; else quadrant |= 1;
;   if (y != 0) {
;     // The primary cost of this algorithm is five 16-bit multiplies.
;     tangent = (int16_t)x*32;   // worst case y = 1, tangent = 255*32 so fits in 2 bytes.
;     /*
;        determine base sector using abs(x)/abs(y).
;        in segment:
;            0 if         0 <= x/y < tan 11.25   -- centered around 0     N
;            1 if tan 11.25 <= x/y < tan 33.75   --                 22.5  NxNE
;            2 if tan 33.75 <= x/y < tan 56.25   --                 45    NE
;            3 if tan 56.25 <= x/y < tan 78.75   --                 67.5  ExNE
;            4 if tan 78.75 <= x/y < tan 90      --                 90    E
;     */
;     if (tangent > y*6  ) return map[quadrant][0]; // tan(11.25)*32
;     if (tangent > y*21 ) return map[quadrant][1]; // tan(33.75)*32
;     if (tangent > y*47 ) return map[quadrant][2]; // tan(56.25)*32
;     if (tangent > y*160) return map[quadrant][3]; // tan(78.75)*32
;     // last case is the potentially infinite tan(90) but we don't need to check that limit.
;   }
;   return map[quadrant][4];
; }
; -----------------------------------------
Atan_Sector:    ; int8_t quadrant = 0;
                LD C, #03
                LD B, D

                ; if (x > 0) x = -x; else quadrant |= 2;
                LD A, E
                OR A
                JP M, $+7
                NEG
                RES 1, C                ; else quadrant |= 2;
                LD L, A

                ; приведение к 16-битному значению
                ADD A, A
                SBC A, A
                LD H, A

                EX DE, HL

                ; if (y > 0) y = -y; else quadrant |= 1;
                LD A, B
                OR A
                JP M, $+7
                NEG
                RES 0, C                ; else quadrant |= 1;
                LD L, A

                ; приведение к 16-битному значению
                ADD A, A
                SBC A, A
                LD H, A

                ; if (y != 0)
                LD A, B
                OR A
                LD A, C                                                         ; сохранить в аккумуляторе 'quadrant'
                JR Z, .Quadrant_4

                ; tangent = (int16_t)x*32;   // worst case y = 1, tangent = 255*32 so fits in 2 bytes.
                EX DE, HL
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32

                ; if (tangent > y*6  ) return map[quadrant][0]; // tan(11.25)*32
                EX DE, HL
                LD B, H     ; BC = x1
                LD C, L
                LD (.x1), HL

                ADD HL, HL  ; x2
                LD (.x2), HL
                ADD HL, BC  ; x3
                LD B, H     ; BC = x3
                LD C, L
                ADD HL, HL  ; x6

                OR A
                SBC HL, DE
                JP M, .Quadrant_0
                ADD HL, DE

                ; if (tangent > y*21 ) return map[quadrant][1]; // tan(33.75)*32
                ADD HL, HL  ; x12
                ADD HL, HL  ; x24
                LD (.x24), HL
                OR A
                SBC HL, BC  ; x21

                OR A
                SBC HL, DE
                JP M, .Quadrant_1

                ; if (tangent > y*47 ) return map[quadrant][2]; // tan(56.25)*32
.x24            EQU $+1
                LD HL, #0000
                ADD HL, HL  ; x48
.x1             EQU $+1
                LD BC, #0000
                OR A
                SBC HL, BC  ; x47

                OR A
                SBC HL, DE
                JP M, .Quadrant_2

                ; if (tangent > y*160) return map[quadrant][3]; // tan(78.75)*32
.x2             EQU $+1
                LD HL, #0000
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x32
                LD B, H     ; BC = x32
                LD C, L
                ADD HL, HL  ; x64
                ADD HL, HL  ; x128
                ADD HL, BC  ; x160

                OR A
                SBC HL, DE
                JP M, .Quadrant_3

.Quadrant_4     ADD A, #04
.Quadrant_3     ADD A, #04
.Quadrant_2     ADD A, #04
.Quadrant_1     ADD A, #04
.Quadrant_0     LD C, A
                SRL C
                SRL C

.Read           ; return map[quadrant][.];
                AND %00000011
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8

                ADD A, C

                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ; чтение сектора
                LD A, (HL)
                RET

.Table          
                DB #04 << 3, #03 << 3, #02 << 3, #01 << 3, #00 << 3,     #00, #00, #00  ; 0
                DB #0C << 3, #0D << 3, #0E << 3, #0F << 3, #00 << 3,     #00, #00, #00  ; 1
                DB #04 << 3, #05 << 3, #06 << 3, #07 << 3, #08 << 3,     #00, #00, #00  ; 2
                DB #0C << 3, #0B << 3, #0A << 3, #09 << 3, #08 << 3                     ; 3

                display " - Atan 'sector': \t\t\t\t\t", /A, Atan_Sector, " = busy [ ", /D, $ - Atan_Sector, " bytes  ]"

                endmodule

                endif ; ~_MATH_ATAN_SECTOR_
