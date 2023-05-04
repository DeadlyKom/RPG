
                ifndef _BUILDER_PACK_4_
                define _BUILDER_PACK_4_

                MMU 3, Page.Graphics.Pack2                                      ; 3 bank, Page.Graphics.Pack2 (4) page
                ORG Adr.Graphics.Pack2
                module Graphics

                display "\'Graphics Pack\':\t\t\t\t\t-------------------- [ ", /D, Size2, " bytes ]\t [", /D, Page.Graphics.Pack2, "]\t ------------------------"

                ifdef _REBUILD
                endif
Begin2:         EQU $

                ; include "Core/Module/Graphics/Include.inc"
Size2:          EQU $ - Begin2

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin2, Size2
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_4_
