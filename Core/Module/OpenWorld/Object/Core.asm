
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_CORE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_CORE_
; -----------------------------------------
; обновление позиции мины
; In:
;   IX - адрес обрабатываемого объекта FObjectInteraction
; Out:
; Corrupt:
; Note:
; ----------------------------------------
UpdateOffset:   ; -----------------------------------------
                ; расчёт смещения относительно камеры
                ; -----------------------------------------

                LD A, (PlayerState.DeltaCameraPixX)
                LD DE, (IX + FObject.Position.X)
                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, DE
                LD (IX + FObject.Position.X), HL                                ; сохранение позиции по горизонтали

                ; -----------------------------------------
                ; расчёт смещения по высоте
                ; -----------------------------------------

                LD A, (PlayerState.DeltaCameraPixY)
                LD DE, (IX + FObject.Position.Y)
                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL                                ; сохранение позиции по горизонтали

                RET
; -----------------------------------------
; получить смещение сокета позади машины
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
;   DE - смещение (D - y, E - x)
; Corrupt:
; Note:
; ----------------------------------------
GetBackSocket:  LD HL, .Table
                LD A, (IX + FObject.Direction)
                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | B3 | B2 | B1 | B0 | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [6..3]  - направление
                ;                       0000 - 0.0°     right
                ;                       0001 - 22.5°
                ;                       0010 - 45.0°    up-right
                ;                       0011 - 67.5°
                ;                       0100 - 90.0°    up
                ;                       0101 - 112.5°
                ;                       0110 - 135.0°   up-left
                ;                       0111 - 157.5°
                ;                       1000 - 180.0°   left
                ;                       1001 - 202.5°
                ;                       1010 - 225.0°   down-left
                ;                       1011 - 247.0°
                ;                       1100 - 270.0°   down
                ;                       1101 - 292.5°
                ;                       1110 - 315.0°   down-right
                ;                       1111 - 337.5°
                ; -----------------------------------------
                JP GetSocket
.Table          DW (( 6 - 9) & 0xFF) << 8 | ((-4 + 4) & 0xFF)                           ; 0000 - 0.0°     right
                DW (( 8 - 9) & 0xFF) << 8 | ((-4 + 4) & 0xFF)                           ; 0001 - 22.5°
                DW ((10 - 9) & 0xFF) << 8 | ((-2 + 4) & 0xFF)                           ; 0010 - 45.0°    up-right
                DW ((11 - 9) & 0xFF) << 8 | (( 1 + 4) & 0xFF)                           ; 0011 - 67.5°
                DW ((12 - 9) & 0xFF) << 8 | (( 4 + 4) & 0xFF)                           ; 0100 - 90.0°    up
                DW ((10 - 9) & 0xFF) << 8 | (( 7 + 4) & 0xFF)                           ; 0101 - 112.5°
                DW ((10 - 9) & 0xFF) << 8 | ((10 + 4) & 0xFF)                           ; 0110 - 135.0°   up-left
                DW (( 8 - 9) & 0xFF) << 8 | ((12 + 4) & 0xFF)                           ; 0111 - 157.5°
                DW (( 6 - 9) & 0xFF) << 8 | ((12 + 4) & 0xFF)                           ; 1000 - 180.0°   left
                DW (( 4 - 9) & 0xFF) << 8 | ((14 + 4) & 0xFF)                           ; 1001 - 202.5°
                DW ((-1 - 9) & 0xFF) << 8 | ((12 + 4) & 0xFF)                           ; 1010 - 225.0°   down-left
                DW ((-2 - 9) & 0xFF) << 8 | (( 7 + 4) & 0xFF)                           ; 1011 - 247.0°
                DW ((-5 - 9) & 0xFF) << 8 | (( 4 + 4) & 0xFF)                           ; 1100 - 270.0°   down
                DW ((-3 - 9) & 0xFF) << 8 | (( 0 + 4) & 0xFF)                           ; 1101 - 292.5°
                DW (( 0 - 9) & 0xFF) << 8 | ((-4 + 4) & 0xFF)                           ; 1110 - 315.0°   down-right
                DW (( 3 - 9) & 0xFF) << 8 | ((-4 + 4) & 0xFF)                           ; 1111 - 337.5°
; -----------------------------------------
; получить смещение сокета позади машины
; In:
;   IX - адрес объекта FObject
; Out:
;   DE - смещение (D - y, E - x)
; Corrupt:
; Note:
; ----------------------------------------
GetFireSocket:  
                LD HL, .Table
                LD A, (IX + FObject.MuzzleFlash)
                ADD A, -4 << 4
                RRA
                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | B3 | B2 | B1 | B0 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [7..4]  - направление
                ;                       0000 - 0.0°     right
                ;                       0001 - 22.5°
                ;                       0010 - 45.0°    up-right
                ;                       0011 - 67.5°
                ;                       0100 - 90.0°    up
                ;                       0101 - 112.5°
                ;                       0110 - 135.0°   up-left
                ;                       0111 - 157.5°
                ;                       1000 - 180.0°   left
                ;                       1001 - 202.5°
                ;                       1010 - 225.0°   down-left
                ;                       1011 - 247.0°
                ;                       1100 - 270.0°   down
                ;                       1101 - 292.5°
                ;                       1110 - 315.0°   down-right
                ;                       1111 - 337.5°
                ; -----------------------------------------
                JP GetSocket
.Table          lua allpass

                function calc(angle, radius, offsetX, offsetY)
                    local cos = math.cos(math.rad(angle))
                    local sin = math.sin(math.rad(angle))
                    local valueX = (math.floor(cos * radius))
                    local valueY = (math.floor(sin * radius))
                    local value = (((valueY + offsetY) % 256) * 256) + ((valueX + offsetX) % 256)
                    _pc("DW " .. value)
                    --print (string.format("DW #%.2X%.2X \t(%.1f, %.1f)", valueY % 256, valueX % 256, valueX, valueY))
                end
                
                local radius = 6
                local offsetX = 0
                local offsetY = -3

                for i = 0, 15 do
                    calc(22.5 * i, radius, offsetX, offsetY)
                end

                endlua

                ; DW (( 0) & 0xFF) << 8 | ((10) & 0xFF)                           ; 0000 - 0.0°     right
                ; DW (( 4) & 0xFF) << 8 | (( 9) & 0xFF)                           ; 0001 - 22.5°
                ; DW ((11) & 0xFF) << 8 | (( 0) & 0xFF)                           ; 0010 - 45.0°    up-right
                ; DW ((10) & 0xFF) << 8 | (( 2) & 0xFF)                           ; 0011 - 67.5°
                ; DW ((10) & 0xFF) << 8 | (( 2) & 0xFF)                           ; 0100 - 90.0°    up
                ; DW (( 7) & 0xFF) << 8 | (( 3) & 0xFF)                           ; 0101 - 112.5°
                ; DW (( 7) & 0xFF) << 8 | (( 5) & 0xFF)                           ; 0110 - 135.0°   up-left
                ; DW ((10) & 0xFF) << 8 | (( 5) & 0xFF)                           ; 0111 - 157.5°
                ; DW (( 8) & 0xFF) << 8 | (( 5) & 0xFF)                           ; 1000 - 180.0°   left
                ; DW ((10) & 0xFF) << 8 | ((-2) & 0xFF)                           ; 1001 - 202.5°
                ; DW ((10) & 0xFF) << 8 | (( 0) & 0xFF)                           ; 1010 - 225.0°   down-left
                ; DW (( 9) & 0xFF) << 8 | (( 1) & 0xFF)                           ; 1011 - 247.0°
                ; DW (( 7) & 0xFF) << 8 | (( 2) & 0xFF)                           ; 1100 - 270.0°   down
                ; DW (( 5) & 0xFF) << 8 | (( 3) & 0xFF)                           ; 1101 - 292.5°
                ; DW (( 6) & 0xFF) << 8 | (( 1) & 0xFF)                           ; 1110 - 315.0°   down-right
                ; DW (( 4) & 0xFF) << 8 | (( 2) & 0xFF)                           ; 1111 - 337.5°
                
; -----------------------------------------
; получить смещение сокета
; In:
;   A  - направление
;   HL - адрес таблицы
;   IX - адрес объекта FObject
; Out:
;   DE - смещение (D - y, E - x)
; Corrupt:
; Note:
; ----------------------------------------
GetSocket:      ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | B3 | B2 | B1 | B0 | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [6..3]  - направление
                ;                       0000 - 0.0°     right
                ;                       0001 - 22.5°
                ;                       0010 - 45.0°    up-right
                ;                       0011 - 67.5°
                ;                       0100 - 90.0°    up
                ;                       0101 - 112.5°
                ;                       0110 - 135.0°   up-left
                ;                       0111 - 157.5°
                ;                       1000 - 180.0°   left
                ;                       1001 - 202.5°
                ;                       1010 - 225.0°   down-left
                ;                       1011 - 247.0°
                ;                       1100 - 270.0°   down
                ;                       1101 - 292.5°
                ;                       1110 - 315.0°   down-right
                ;                       1111 - 337.5°
                ; -----------------------------------------
                RRA
                RRA
                AND OBJECT_DIRECTION_MASK >> 2
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; чтение смещения
                LD E, (HL)
                INC HL
                LD D, (HL)
                RET

                display "\t- Core:\t\t\t\t\t\t", /A, UpdateOffset, " = busy [ ", /D, $ - UpdateOffset, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_CORE_
