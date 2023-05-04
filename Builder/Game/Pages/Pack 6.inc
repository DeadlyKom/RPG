
                ifndef _BUILDER_PACK_6_
                define _BUILDER_PACK_6_

                MMU 3, Page.Module.Pack6                                        ; 3 bank, Page.Module.Pack6 (6) page
                ORG Adr.Module.Pack6
                module Packs

                display "\'Pack 6\':\t\t\t\t\t\t-------------------- [ ", /D, Size6, " bytes ]\t [", /D, Page.Module.Pack6, "]\t ------------------------"
Begin6:         EQU $
                include "Core/Module/Game/Main Menu/Include.inc"
End6:           EQU $
Size6:          EQU End6 - Begin6

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin6, Size6
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_6_

