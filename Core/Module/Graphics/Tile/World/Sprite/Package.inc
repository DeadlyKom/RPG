
                ifndef _BUILDER_GRAPHICS_PACKAGE_
                define _BUILDER_GRAPHICS_PACKAGE_

                MMU 3, Page.Graphics.Pack1                                      ; 3 bank, Page.Graphics.Pack1 (3) page
                ORG Adr.Graphics.Pack1
                module Package
Begin:          EQU $

                ; 23 тайла максимум
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_0.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_1.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_2.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_3.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_4.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_5.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_6.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Sand_7.spr"
Size:           EQU $ - Begin

                savebin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground.pack", Begin, Size

                endmodule

                endif ; ~ _BUILDER_GRAPHICS_PACKAGE_
