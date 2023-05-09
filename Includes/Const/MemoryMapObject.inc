
                ifndef _CONST_MEMORY_MAP_OBJECT_
                define _CONST_MEMORY_MAP_OBJECT_

                module Page
                module Module
Object          EQU PAGE_0                                                      ; модуль "работы с объектами"
                endmodule
                endmodule

                module Size
Object          EQU #0400                                                       ; максимально доступный размер для массива объектов
Settlement      EQU #0400                                                       ; максимально доступный размер для массива поселений

                module Module
                endmodule
                endmodule

                module Adr
Object          EQU MemBank_03                                                  ; адрес массива объектов
Settlement      EQU Adr.Object + Size.Object                                    ; адрес массива поселений

                endmodule

                endif ; ~_CONST_MEMORY_MAP_OBJECT_
