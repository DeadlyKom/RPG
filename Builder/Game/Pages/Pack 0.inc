
                ifndef _BUILDER_PACK_0_
                define _BUILDER_PACK_0_

                MMU 3, Page.Module.Pack0                                        ; 3 bank, Page.Module.Pack0 (0) page
                ORG Adr.Module.Pack0
                module Packs

                display "\'Pack 0\':\t\t\t\t\t\t-------------------- [ ", /D, Size0, " bytes ]\t [", /D, Page.Module.Pack0, "]\t ------------------------"
Begin0:         EQU $
                ; include "Core/Module/Game/Include.inc"
End0:           EQU $
Size0:          EQU End0 - Begin0

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin0, Size0
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_0_

