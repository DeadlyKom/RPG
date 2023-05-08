
                ifndef _CONST_MEMORY_MAP_PACK_6_
                define _CONST_MEMORY_MAP_PACK_6_

                module Page
                module Module
Pack6           EQU PAGE_6                                                      ; страница пакета №6

                endmodule
                endmodule

                module Adr
Font            EQU Module.Pack6                                                ; адрес расположения блока шрифта
MainMenu        EQU Packs.MainMenu.Begin                                        ; адрес расположения блока "главного меню"
Settlement      EQU Packs.Settlement.Begin                                      ; адрес расположения блока "поселение"
                module Module
Pack6:          EQU MemBank_03                                                  ; адрес пакета №6

                endmodule
                endmodule

                endif ; ~_CONST_MEMORY_MAP_PACK_6_
