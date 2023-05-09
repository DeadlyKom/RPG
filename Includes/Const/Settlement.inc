
                ifndef _CONST_SETTLEMENT_
                define _CONST_SETTLEMENT_
SETTLEMENT_EMPTY_ELEMENT        EQU #FF                                             ; свобдный элемент массива

SETTLEMENT_SIZE                 EQU 16                                              ; размер структуры поселения
SETTLEMENT_NUM                  EQU Size.Settlement / SETTLEMENT_SIZE


; тип поселения
SETTLEMENT_BEGIN                EQU 0x00

; тип постройки
BUILDING_ENTRANCE_BIT           EQU 0x07                                        ; главный вход, наличие ограждённого периметра
BUILDING_RESIDENTIAL_AREA_BIT   EQU 0x06                                        ; жилой район
BUILDING_WAREHOUSE_BIT          EQU 0x05                                        ; склад и сборщик лома
BUILDING_SHOPPING_AREA_BIT      EQU 0x04                                        ; торговый район
BUILDING_BAR_BIT                EQU 0x03                                        ; бар
BUILDING_WORKSHOP_BIT           EQU 0x02                                        ; мастерская
BUILDING_PRISON_BIT             EQU 0x01                                        ; тюрьма
BUILDING_RADIO_TOWER_BIT        EQU 0x00                                        ; радио вышка

BUILDING_ENTRANCE               EQU 1 << BUILDING_ENTRANCE_BIT                  ; главный вход, наличие ограждённого периметра
BUILDING_RESIDENTIAL_AREA       EQU 1 << BUILDING_RESIDENTIAL_AREA_BIT          ; жилой район
BUILDING_WAREHOUSE              EQU 1 << BUILDING_WAREHOUSE_BIT                 ; склад и сборщик лома
BUILDING_SHOPPING_AREA          EQU 1 << BUILDING_SHOPPING_AREA_BIT             ; торговый район
BUILDING_BAR                    EQU 1 << BUILDING_BAR_BIT                       ; бар
BUILDING_WORKSHOP               EQU 1 << BUILDING_WORKSHOP_BIT                  ; мастерская
BUILDING_PRISON                 EQU 1 << BUILDING_PRISON_BIT                    ; тюрьма
BUILDING_RADIO_TOWER            EQU 1 << BUILDING_RADIO_TOWER_BIT               ; радио вышка

                endif ; ~_CONST_SETTLEMENT_