
                ifndef _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_
                define _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_

                module UI
                module Settlement

                ifdef _REBUILD
Frame           EQU $
                include "Compress.inc"

                else
Frame           EQU $
                incbin "Compressed/Frame.spr.ar"

                endif

                endmodule
                endmodule

                endif ; ~ _CORE_MODULE_GRAPHICS_SETTLEMENT_INCLUDE_
