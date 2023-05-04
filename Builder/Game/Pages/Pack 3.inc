
                ifndef _BUILDER_PACK_3_
                define _BUILDER_PACK_3_

                MMU 3, Page.Graphics.Pack1                                      ; 3 bank, Page.Graphics.Pack1 (3) page
                ORG Adr.Graphics.Pack1
                module Graphics

                display "\'Graphics Pack\':\t\t\t\t\t-------------------- [ ", /D, Size1, " bytes ]\t [", /D, Page.Graphics.Pack1, "]\t ------------------------"

                ifdef _REBUILD
                ; tile
                include "Core/Module/Graphics/Tile/World/Sprite/Package.inc"
                include "Core/Module/Graphics/Tile/World/Sprite/Compress.inc"

                ; weapon UI
                include "Core/Module/Graphics/UI/Weapon/Compress.inc"
                endif
Begin1:         EQU $

                include "Core/Module/Graphics/Include.inc"
Size1:          EQU $ - Begin1

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin1, Size1
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_3_
