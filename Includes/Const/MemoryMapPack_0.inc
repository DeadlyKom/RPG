
                ifndef _CONST_MEMORY_MAP_PACK_0_
                define _CONST_MEMORY_MAP_PACK_0_

                module Page
                module Module
Pack0           EQU PAGE_0                                                      ; страница пакета №0

                endmodule
                endmodule

                module Size
Object          EQU #0400                                                       ; максимально доступный размер для массива объектов
Region          EQU #0300                                                       ; максимально доступный размер для массива регионов
Settlement      EQU #0100                                                       ; максимально доступный размер для массива поселений

                endmodule

                module Adr
Object          EQU MemBank_03                                                  ; адрес массива объектов
Region          EQU Adr.Object + Size.Object                                    ; адрес массива регионов            (выравнен 1024 байт)
Settlement      EQU Adr.Region + Size.Region                                    ; адрес массива поселений

                module Block0
Code            EQU Adr.Settlement + Size.Settlement                            ; адрес блока "генерацией мира"

                endmodule
                module Module
Pack0:          EQU MemBank_03                                                  ; адрес пакета №0

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_PACK_0_
