
                ifndef _BUILDER_GAME_PACK_
                define _BUILDER_GAME_PACK_

                MMU 1, Page.Module.Game                                         ; 1 bank, Page.Module.Game (5) page
                ORG Adr.Module.Game.Main
                module Game

                display "\'Game Core\':\t\t\t\t\t\t-------------------- [ ", /D, Size, " bytes ]\t [", /D, Page.Module.Game, "]\t ------------------------"
Begin:          EQU $
                include "Core/Module/Game/Include.inc"
Size:           EQU $ - Begin

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin, Size
                endif

                endmodule

                endif ; ~ _BUILDER_GAME_PACK_

