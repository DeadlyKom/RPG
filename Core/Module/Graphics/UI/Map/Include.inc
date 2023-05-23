
                ifndef _CORE_MODULE_GRAPHICS_MAP_INCLUDE_
                define _CORE_MODULE_GRAPHICS_MAP_INCLUDE_

                module UI
                module Map

                ifdef _REBUILD

                include "Compress.inc"
Frame_0         EQU $
Frame_1         EQU $
                else
Frame_0         EQU $
                incbin "Compressed/Frame_0.spr.ar"
Frame_1         EQU $
                incbin "Compressed/Frame_1.spr.ar"
                endif

                endmodule
                endmodule

                endif ; ~ _CORE_MODULE_GRAPHICS_MAP_INCLUDE_
