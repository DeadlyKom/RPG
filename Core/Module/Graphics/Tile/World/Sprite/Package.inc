
                ifndef _BUILDER_GRAPHICS_PACKAGE_TILE_
                define _BUILDER_GRAPHICS_PACKAGE_TILE_

                MMU 3, Page.Graphics.Pack1                                      ; 3 bank, Page.Graphics.Pack1 (3) page
                ORG Adr.Graphics.Pack1
                module Package
                module Tile
Begin:          EQU $

                ; 32 тайла максимум
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_0.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_1.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_2.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_3.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_4.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_5.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_6.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_7.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_8.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_9.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_A.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_B.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_C.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_D.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_E.spr"
                incbin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground_F.spr"
Size:           EQU $ - Begin

                savebin "Core/Module/Graphics/Tile/World/Sprite/Original/Ground/Ground.pack", Begin, Size

                endmodule
                endmodule

                endif ; ~ _BUILDER_GRAPHICS_PACKAGE_TILE_
