    
                ifndef _BUILDER_PACK_
                define _BUILDER_PACK_

                emptytap TAP_FILENAME

                display "Packing..."

                include "Bootloader/Pack.inc"                                   ; упаковка boot загрузчика      (1)
                include "Kernel/Pack.inc"                                       ; упаковка кернеля              (2)
                include "Game/Pack.inc"                                         ; упаковка игрового кода

                display "-------------------------------------------------------------------------------------------------------------------------------"

                labelslist "C:/Work/spectrum/unreal/user.l"
                shellexec  "C:/Work/spectrum/unreal/unreal.exe RPG.tap"	        ; путь UNREAL эмулятора и путь запускаемого файла

                endif ; ~_BUILDER_PACK_
