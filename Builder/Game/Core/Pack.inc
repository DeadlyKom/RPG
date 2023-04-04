
                ifndef _BUILDER_GAME_PACK_
                define _BUILDER_GAME_PACK_

                MMU 1, Page.Module.Game                                         ; 1 bank, Page.Module.Game (5) page
                ORG Adr.Module.Game.Main
                module Game

                display "\'Game Core\':\t\t\t\t\t\t-------------------- [ ", /D, Size, "/", /D, 0x8000 - End, " bytes ]\t [", /D, Page.Module.Game, "]\t ------------------------"
                display " * Entry Point:\t\t\t\t\t", /A, Adr.EntryPoint
                display " - Stack, Tables:\t\t\t\t\t", /A, Adr.StackTop - Size.Stack, " = busy [ ", /D, Adr.EntryPoint - (Adr.StackTop + Size.Stack), " bytes ]"
Begin:          EQU $
                include "Core/Module/Game/Include.inc"
End:            EQU $
Size:           EQU End - Begin

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin, Size
                endif

                endmodule

                endif ; ~ _BUILDER_GAME_PACK_

