
                ifndef _CONST_REGION_
                define _CONST_REGION_
REGION_EMPTY_ELEMENT        EQU #FF                                             ; свобдный элемент массива

REGION_SIZE                 EQU 12                                              ; размер структуры объекта
REGION_ADR                  EQU Adr.Region                                      ; адрес массива структур FRegion
REGION_NUM                  EQU Size.Region / REGION_SIZE                       ; максимальное количество элементов в масиве

IDX_REGION_TYPE             EQU %00001111
IDX_REGION_TYPE_INV         EQU (~IDX_REGION_TYPE) & 0xFF

; тип региона
REGION_TYPE_RADIOACTIVE                 EQU 0x00                                ; радиация
REGION_TYPE_HABITATS                    EQU 0x01                                ; места обитания существ
REGION_TYPE_SETTLEMENT_BEGIN            EQU 0x02                                ; поселение "начальный/стартовый"
REGION_TYPE_SETTLEMENT_NEUTRAL          EQU 0x03                                ; поселение "нейтральный"
REGION_TYPE_SETTLEMENT_FRIENDLY         EQU 0x04                                ; поселение "дружественный"
REGION_TYPE_SETTLEMENT_HOSTILE          EQU 0x05                                ; поселение "враждебный"


; цвет региона
REGION_TYPE_EMPTY                       EQU YELLOW                              ; свободный
REGION_TYPE_RADIOACTIVE_COLOR           EQU CYAN                                ; радиоактивный
REGION_TYPE_SETTLEMENT_BEGIN_COLOR      EQU BLUE                                ; начальный/стартовый
REGION_TYPE_SETTLEMENT_NEUTRAL_COLOR    EQU WHITE                               ; нейтральный
REGION_TYPE_SETTLEMENT_FRIENDLY_COLOR   EQU GREEN                               ; дружественный
REGION_TYPE_SETTLEMENT_HOSTILE_COLOR    EQU RED                                 ; враждебный

                endif ; ~_CONST_REGION_
