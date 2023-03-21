    
                ifndef _BUILDER_PACK_
                define _BUILDER_PACK_

                ifndef _DEBUG
                emptytap TAP_FILENAME
                endif

                display "Packing..."

                include "Bootloader/Pack.inc"                                   ; упаковка boot загрузчика
                include "Kernel/Pack.inc"                                       ; упаковка кернеля
                include "Game/Pack.inc"                                         ; упаковка игрового кода
                include "Graphics/Pack.inc"                                     ; упаковка графики

                display "-------------------------------------------------------------------------------------------------------------------------------"

                labelslist "C:/Work/spectrum/unreal/user.l"

                ifdef _DEBUG
                savesna SNA_FILENAME, Bootloader.StartBoot
                ifdef _DEBUG_EXECUTE
                shellexec  "C:/Work/spectrum/unreal/unreal.exe RPG.sna"	        ; путь UNREAL эмулятора и путь запускаемого файла
                endif
                else
                shellexec  "C:/Work/spectrum/unreal/unreal.exe RPG.tap"	        ; путь UNREAL эмулятора и путь запускаемого файла
                endif

                endif ; ~_BUILDER_PACK_
