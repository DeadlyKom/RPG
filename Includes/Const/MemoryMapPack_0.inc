
                ifndef _CONST_MEMORY_MAP_PACK_0_
                define _CONST_MEMORY_MAP_PACK_0_

                module Page
                module Module
Pack0           EQU PAGE_0                                                      ; страница пакета №0

                endmodule
                endmodule

                module Adr
                module Module
Pack0:          EQU MemBank_03                                                  ; адрес пакета №0

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_PACK_0_
