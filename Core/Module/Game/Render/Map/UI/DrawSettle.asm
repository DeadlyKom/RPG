
                ifndef _MODULE_GAME_RENDER_MAP_UI_DRAW_SETTLE_
                define _MODULE_GAME_RENDER_MAP_UI_DRAW_SETTLE_
; -----------------------------------------
; отображение UI маркера поселений
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawSettle:     ; количество элементов в массиве
                LD A, (GameState.Region)
                OR A
                RET Z                                                           ; выход, если массив пуст

                ; инициализация
                EX AF, AF'
                SET_PAGE_BLOK_0                                                 ; включение страницы с блоком кода
                LD IX, REGION_ADR                                               ; адрес массива регионов
                EX AF, AF'
                LD B, A

.Loop           PUSH BC
                PUSH IX

                CALL .Draw

.NextElement    ; следующий элемент региона
                POP IX
                LD BC, FRegion
                ADD IX, BC

                POP BC
                DJNZ .Loop

                RET

.Draw           ; -----------------------------------------
                ; подготовка данных о регионе
                ; -----------------------------------------
                LD A, (IX + FRegion.Type)
                AND IDX_REGION_TYPE
                CP IDX_REGION_TYPE
                RET Z                                                           ; выход, если тип региона не валидный
                CP REGION_TYPE_RADIOACTIVE
                RET Z                                                           ; выход, если тип региона не учавствует
                CP REGION_TYPE_HABITATS
                RET Z                                                           ; выход, если тип региона не учавствует
                CP REGION_TYPE_DUNGEON                                          ; ToDo добавить видимость по условию
                RET Z                                                           ; выход, если тип региона не учавствует
                CP REGION_TYPE_SETTLEMENT_ABANDONED
                RET Z                                                           ; выход, если тип региона не учавствует

                ; -----------------------------------------
                ; местоположение поселения по горизонтали
                ; -----------------------------------------

                LD HL, (IX + FRegion.Location.X.Low)
                LD DE, (PlayerState.WorldLeftTopPos + 0)                        ; X.Low
                EXX
                LD HL, (IX + FRegion.Location.X.High)
                LD DE, (PlayerState.WorldLeftTopPos + 2)                        ; X.High
                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32
                RET M                                                           ; выход, если координаты за пределами карты

                ; проверка выхода за пределы окна видимости
                LD A, (PlayerState.MapPosX)
                NEG
                ADD A, H
                RET M                                                           ; выход, если координаты за пределами окна видимости
                SUB SCR_MAP_SIZE_X
                RET NC                                                          ; выход, если координаты за пределами окна видимости
                ADD A, SCR_MAP_SIZE_X
                LD H, A

                ; приведение к знакоместа к пикселям
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8

                ; сохрнить значение по горизонтали
                LD A, H
                EX AF, AF'

                ; -----------------------------------------
                ; местоположение поселения по вертикали
                ; -----------------------------------------

                LD HL, (IX + FRegion.Location.Y.Low)
                LD DE, (PlayerState.WorldLeftTopPos + 4)                        ; Y.Low
                EXX
                LD HL, (IX + FRegion.Location.Y.High)
                LD DE, (PlayerState.WorldLeftTopPos + 6)                        ; Y.High

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32
                RET M                                                           ; выход, если координаты за пределами карты

                ; проверка выхода за пределы окна видимости
                LD A, (PlayerState.MapPosY)
                NEG
                ADD A, H
                RET M                                                           ; выход, если координаты за пределами окна видимости
                SUB SCR_MAP_SIZE_Y
                RET NC                                                          ; выход, если координаты за пределами окна видимости
                ADD A, SCR_MAP_SIZE_Y
                LD H, A

                ; приведение к знакоместа к пикселям
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8

                ; инициалзация позиций
                LD D, H
                EX AF, AF'
                LD E, A

                JP Settle

                endif ; ~_MODULE_GAME_RENDER_MAP_UI_DRAW_SETTLE_
