
                ifndef _BUILDER_PACK_1_
                define _BUILDER_PACK_1_

                MMU 3, Page.Module.Pack1                                        ; 3 bank, Page.Module.Pack1 (1) page
                ORG Adr.Block1.Code
                module Packs

                display "\'Pack 1\':\t\t\t\t\t\t-------------------- [ ", /D, Size1, " bytes ]\t [", /D, Page.Module.Pack1, "]\t ------------------------"
Begin1:         EQU $
                ; include "Core/Module/Game/Include.inc"
                DB #00
End1:           EQU $
Size1:          EQU End1 - Begin1

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin1, Size1
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_1_

