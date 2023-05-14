
                ifndef _CONST_MEMORY_MAP_PACK_1_
                define _CONST_MEMORY_MAP_PACK_1_

                module Page
                module Module
Pack1           EQU PAGE_1                                                      ; страница пакета №1

                endmodule
                endmodule

                module Adr
                module Block1
Code            EQU MemBank_03                                                  ; адрес блока "..."

                endmodule
                module Module
Pack1:          EQU MemBank_03                                                  ; адрес пакета №0

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_PACK_1_
