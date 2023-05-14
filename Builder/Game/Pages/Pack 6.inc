
                ifndef _BUILDER_PACK_6_
                define _BUILDER_PACK_6_

                MMU 3, Page.Module.Pack6                                        ; 3 bank, Page.Module.Pack6 (6) page
                ORG Adr.Module.Pack6
                module Packs

                display "\'Pack 6\':\t\t\t\t\t\t-------------------- [ ", /D, Size6, " bytes ]\t [", /D, Page.Module.Pack6, "]\t ------------------------"
Begin6:         EQU $

                ; graphic
                include "Core/Module/Graphics/Font/Include.inc"
                
                ; draw
                include "Core/Module/Draw/String/DrawChar.asm"

                ; initialize
                include "Core/Module/Game/Initialize/Include.inc"

                ; shared block code
                include "Core/Module/Game/MainMenu/Include.inc"                 ; menu
                include "Core/Module/Game/PlayGame/Include.inc"                 ; play game
                include "Core/Module/Game/Settlement/Include.inc"               ; settlement
                include "Core/Module/Game/Wasteland/Include.inc"                ; wasteland

                ; generator
                include "Core/Module/Table/Gen_ScrAdr.asm"
                include "Core/Module/Table/Gen_ShiftTable.asm"
                include "Core/Module/Table/Gen_WastelandSprite.asm"
                include "Core/Module/Table/Gen_MultiplySpriteTable.asm"
End6:           EQU $
Size6:          EQU End6 - Begin6

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin6, Size6
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_6_

