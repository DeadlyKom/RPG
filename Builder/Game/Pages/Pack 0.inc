
                ifndef _BUILDER_PACK_0_
                define _BUILDER_PACK_0_

                MMU 3, Page.Module.Pack0                                        ; 3 bank, Page.Module.Pack0 (0) page
                ORG Adr.Block0.Code
                module Packs

                display "\'Pack 0\':\t\t\t\t\t\t-------------------- [ ", /D, Size0, " bytes ]\t [", /D, Page.Module.Pack0, "]\t ------------------------"

ArrayAddress    EQU Adr.Object
ArraySize       EQU Size.Object + Size.Region + Size.Settlement
                display " - Arrays:\t\t\t\t\t\t", /A, ArrayAddress, " = busy [ ", /D, ArraySize, " bytes ]"
                display "\t- Object:\t\t\t\t\t", /A, Adr.Object, " = busy [ ", /D, Size.Object, " bytes ]"
                display "\t- Settlement:\t\t\t\t\t", /A, Adr.Settlement, " = busy [ ", /D, Size.Settlement, " bytes ]"
                display "\t- Region:\t\t\t\t\t", /A, Adr.Region, " = busy [ ", /D, Size.Region, " bytes ]"
Begin0:         EQU $

                ; open world
                include "Core/Module/OpenWorld/Include.inc"

                ; dialog system
                include "Core/Module/Dialog/Include.inc"

                ; text
                include "Core/Module/Text/Settlement/Include.inc"               ; для поселений
End0:           EQU $
Size0:          EQU End0 - Begin0

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin0, Size0
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_0_

