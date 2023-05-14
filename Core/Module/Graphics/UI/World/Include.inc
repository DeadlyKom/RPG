
                ifndef _CORE_MODULE_GRAPHICS_WORLD_UI_INCLUDE_
                define _CORE_MODULE_GRAPHICS_WORLD_UI_INCLUDE_

                module UI

Bar             incbin "Core/Module/Graphics/UI/World/Original/Bar.spr"
                DW #0000
.Size           EQU $ - Bar

Frame           incbin "Core/Module/Graphics/UI/World/Original/Frame.spr"
                DW #0000, #0000
.Size           EQU $ - Frame
Heart
._0             incbin "Core/Module/Graphics/UI/World/Original/Heart_0.spr"
._1             incbin "Core/Module/Graphics/UI/World/Original/Heart_1.spr"
.SizeAll        EQU $ - Heart._0
.Size           EQU $ - Heart._1
Gas             incbin "Core/Module/Graphics/UI/World/Original/Gas.spr"
.Size           EQU $ - Gas
Turbo
._0             incbin "Core/Module/Graphics/UI/World/Original/Turbo_0.spr"
._1             incbin "Core/Module/Graphics/UI/World/Original/Turbo_1.spr"
.SizeAll        EQU $ - Turbo._0
.Size           EQU $ - Turbo._1
                endmodule

                endif ; ~_CORE_MODULE_GRAPHICS_WORLD_UI_INCLUDE_
