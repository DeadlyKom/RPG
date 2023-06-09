
                ifndef _CONST_SETTLEMENT_
                define _CONST_SETTLEMENT_
METADATA_EMPTY_ELEMENT          EQU #FF                                         ; свобдный элемент массива

METADATA_SIZE                   EQU 4                                           ; размер структуры поселения
METADATA_ADR                    EQU Adr.Metadata                                ; адрес массива метаданных (структур FSettlement/FHabitats/FDungeon)
METADATA_NUM                    EQU Size.Metadata / METADATA_SIZE               ; максимальное количество элементов в масиве

; тип постройки
BUILDING_ENTRANCE_BIT           EQU 0x00                                        ; главный вход, наличие ограждённого периметра
BUILDING_RESIDENTIAL_AREA_BIT   EQU 0x01                                        ; жилой район
BUILDING_WAREHOUSE_BIT          EQU 0x02                                        ; склад и сборщик лома
BUILDING_SHOPPING_AREA_BIT      EQU 0x03                                        ; торговый район
BUILDING_BAR_BIT                EQU 0x04                                        ; бар
BUILDING_WORKSHOP_BIT           EQU 0x05                                        ; мастерская
BUILDING_PRISON_BIT             EQU 0x06                                        ; тюрьма
BUILDING_RADIO_TOWER_BIT        EQU 0x07                                        ; радио вышка

BUILDING_ENTRANCE               EQU 1 << BUILDING_ENTRANCE_BIT                  ; главный вход, наличие ограждённого периметра
BUILDING_RESIDENTIAL_AREA       EQU 1 << BUILDING_RESIDENTIAL_AREA_BIT          ; жилой район
BUILDING_WAREHOUSE              EQU 1 << BUILDING_WAREHOUSE_BIT                 ; склад и сборщик лома
BUILDING_SHOPPING_AREA          EQU 1 << BUILDING_SHOPPING_AREA_BIT             ; торговый район
BUILDING_BAR                    EQU 1 << BUILDING_BAR_BIT                       ; бар
BUILDING_WORKSHOP               EQU 1 << BUILDING_WORKSHOP_BIT                  ; мастерская
BUILDING_PRISON                 EQU 1 << BUILDING_PRISON_BIT                    ; тюрьма
BUILDING_RADIO_TOWER            EQU 1 << BUILDING_RADIO_TOWER_BIT               ; радио вышка

                endif ; ~_CONST_SETTLEMENT_
