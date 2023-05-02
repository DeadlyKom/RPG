
                ifndef _MODULE_GAME_OBJECT_UPDATE_DECAL_
                define _MODULE_GAME_OBJECT_UPDATE_DECAL_
; -----------------------------------------
; обновление декали
; In:
;   IX - адрес обрабатываемого объекта FObjectDecal
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Decal:          RES VISIBLE_OBJECT_BIT, (IX + FObjectDecal.Type)                ; сброс флага видимости

                ; -----------------------------------------
                ; расчёт дельт позиции декали
                ; -----------------------------------------

                LD BC, (PlayerState.CameraPosX + 1)
                LD HL, (IX + FObjectDecal.Location.X.Low)
                OR A
                SBC HL, BC
                LD A, L
                EX AF, AF'
                LD BC, ((SCR_MINIMAP_SIZE_X - (SCR_WORLD_SIZE_X << 1)) >> 1) + 2
                ADD HL, BC

                EX AF, AF'
                JP P, $+5
                NEG
                CP (SCR_MINIMAP_SIZE_X >> 1) + 1
                JP NC, Object.Remove

                ; -----------------------------------------
                ;   значение фиксированной точки 12.4 (знаковое)    [от -2^11 до +2^11 в пикселях]
                ;   2 байта на каждую ось X,Y
                ;
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | I11| I10| I9 | I8 | I7 | I6 | I5 | I4 |   | I3 | I2 | I1 | I0 | F0 | F1 | F2 | F3 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;
                ;   I11-I0  [15..4] - целая часть фиксированной точки 12.4
                ;   F0-F3   [3..0]  - дробная часть фиксированной точки 12.4
                ; -----------------------------------------
                LD H, L
                LD A, (PlayerState.CameraPosX + 0)
                CPL
                AND #E0
                LD L, A
                LD (IX + FObjectDecal.Position.X), HL                           ; сохранение позиции по горизонтали

                ; фильтр по горизонтали
                LD A, H
                SUB SCR_CAMERA_RIGH_EDGE >> 1
                RET NC
                ADD A, SCR_WORLD_SIZE_X + 1
                RET NC

                ; -----------------------------------------

                LD BC, (PlayerState.CameraPosY + 1)
                LD HL, (IX + FObjectDecal.Location.Y.Low)
                OR A
                SBC HL, BC
                LD A, L
                EX AF, AF'
                LD BC, ((SCR_MINIMAP_SIZE_Y - ((SCR_WORLD_SIZE_Y + 1) << 1)) >> 1) + 0
                ADD HL, BC

                EX AF, AF'
                JP P, $+5
                NEG
                CP (SCR_MINIMAP_SIZE_Y >> 1) + 1
                JP NC, Object.Remove

                ; -----------------------------------------
                ;   значение фиксированной точки 12.4 (знаковое)    [от -2^11 до +2^11 в пикселях]
                ;   2 байта на каждую ось X,Y
                ;
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;   | I11| I10| I9 | I8 | I7 | I6 | I5 | I4 |   | I3 | I2 | I1 | I0 | F0 | F1 | F2 | F3 |
                ;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;
                ;   I11-I0  [15..4] - целая часть фиксированной точки 12.4
                ;   F0-F3   [3..0]  - дробная часть фиксированной точки 12.4
                ; -----------------------------------------
                LD H, L
                LD A, (PlayerState.CameraPosY + 0)
                AND #E0
                LD L, A
                LD (IX + FObjectDecal.Position.Y), HL                           ; сохранение позиции по вертикали

                ; фильтр по вертикали
                LD A, H
                SUB (SCR_CAMERA_DOWN_EDGE - 1) >> 1
                RET NC
                ADD A, SCR_WORLD_SIZE_Y + 1
                RET NC

                SET VISIBLE_OBJECT_BIT, (IX + FObjectDecal.Type)                ; установка флага видимости

                RET

                display " - Update object 'DECAL':\t\t\t\t", /A, Decal, " = busy [ ", /D, $ - Decal, " bytes  ]"

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_DECAL_
