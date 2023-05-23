
                ifndef _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_
                define _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_

                module UI
                module Settlement

                ifdef _REBUILD
                include "Compress.inc"
Frame           EQU $
ArtFrame_0      EQU $
ArtFrame_1      EQU $
                else
Frame           EQU $
                incbin "Compressed/Frame.spr.ar"
ArtFrame_0      EQU $
                incbin "Compressed/ArtFrame_0.spr.ar"
ArtFrame_1      EQU $
                incbin "Compressed/ArtFrame_1.spr.ar"
                endif

                endmodule
                endmodule

                endif ; ~ _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_
