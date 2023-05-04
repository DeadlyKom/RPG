
                ifndef _BUILDER_PACK_5_
                define _BUILDER_PACK_5_

                MMU 1, Page.Module.Game                                         ; 1 bank, Page.Module.Game (5) page
                ORG Adr.Module.Game.Main
                module Game

                display "\'Game Core\':\t\t\t\t\t\t-------------------- [ ", /D, Size, "/", /D, 0x8000 - End, " bytes ]\t [", /D, Page.Module.Game, "]\t ------------------------"
                display " - Stack, Tables:\t\t\t\t\t", /A, Adr.StackTop - Size.Stack, " = busy [ ", /D, Adr.EntryPoint - (Adr.StackTop - Size.Stack), " bytes ]"
                display " * Entry code:\t\t\t\t\t", /A, Adr.EntryPoint, " = free [ ", /D, Size.EntryPoint - Size, " bytes ]"
Begin:          EQU $
                include "Core/Module/Game/Include.inc"
End:            EQU $
Size:           EQU End - Begin

                display " * Shared code:\t\t\t\t\t", /A, Adr.EntryPoint + Size.EntryPoint, " = free [ ", /D, Size.SharedPoint, " bytes ]"

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin, Size
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_5_

