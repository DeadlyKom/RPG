
                ifndef _CORE_MODULE_GRAPHICS_WEAPON_UI_INCLUDE_
                define _CORE_MODULE_GRAPHICS_WEAPON_UI_INCLUDE_

                module UI
None            incbin "Core/Module/Graphics/UI/Weapon/Compressed/None.spr.ar"
.Size           EQU $ - None
MachineGun      incbin "Core/Module/Graphics/UI/Weapon/Compressed/MachineGun.spr.ar"
.Size           EQU $ - MachineGun
Mine            incbin "Core/Module/Graphics/UI/Weapon/Compressed/Mine.spr.ar"
.Size           EQU $ - Mine
Rocket          incbin "Core/Module/Graphics/UI/Weapon/Compressed/Rocket.spr.ar"
.Size           EQU $ - Rocket
RepairKit       incbin "Core/Module/Graphics/UI/Weapon/Compressed/RepairKit.spr.ar"
.Size           EQU $ - RepairKit

                endmodule

                endif ; ~_CORE_MODULE_GRAPHICS_WEAPON_UI_INCLUDE_
