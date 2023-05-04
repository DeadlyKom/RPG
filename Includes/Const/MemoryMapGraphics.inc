
                ifndef _CONST_MEMORY_MAP_GRAPHICS_
                define _CONST_MEMORY_MAP_GRAPHICS_

                module Page
                module Graphics
Pack1           EQU PAGE_3                                                      ; страница пакета спрайтов "Пакет 1"
Pack2           EQU PAGE_4                                                      ; страница пакета спрайтов "Пакет 2"

                endmodule
                endmodule

                module Adr
                module Graphics
Pack1:          EQU MemBank_03                                                  ; адрес пакета спрайтов "Пакет 1"
Pack2:          EQU MemBank_03                                                  ; адрес пакета спрайтов "Пакет 2"

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_GRAPHICS_
