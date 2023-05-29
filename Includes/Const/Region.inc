
                ifndef _CONST_REGION_
                define _CONST_REGION_
REGION_EMPTY_ELEMENT        EQU #FF                                             ; свобдный элемент массива

REGION_SIZE                 EQU 12                                              ; размер структуры объекта
REGION_ADR                  EQU Adr.Region                                      ; адрес массива структур FRegion
REGION_NUM                  EQU Size.Region / REGION_SIZE                       ; максимальное количество элементов в масиве1

; тип региона
REGION_TYPE_RADIOACTIVE     EQU 0x00                                            ; радиация
REGION_TYPE_HABITATS        EQU 0x01                                            ; места обитания существ
REGION_TYPE_SETTLEMENT      EQU 0x02                                            ; поселение

                endif ; ~_CONST_REGION_
