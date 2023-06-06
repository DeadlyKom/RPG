    
                ifndef _BUILDER_PACK_
                define _BUILDER_PACK_

                ifndef _DEBUG
                emptytap TAP_FILENAME
                endif

                display "Packing..."

                ;   +-------+--------------+
                ;   |  ROM  |       48/128 |
                ;   +-------+--------------+
                ;   |  RAM  |            5 |
                ;   +-------+--------------+
                ;   |  RAM  |            2 |
                ;   +-------+--------------+
                ;   |  RAM  |  0,1,3,4,6,7 |
                ;   +----------------------+
                ;
                ;   Page:
                ;       0 - массив объектов
                ;           * функции работы с массивом
                ;       1 - 
                ;       2 - адресное пространство 
                ;           * базовые функции "Kernel"
                ;           * рендер буфер
                ;           * общий буфер
                ;           * буфер сортировкм
                ;       3 - графика "Пакет 1"
                ;       4 - рез. под графика "Пакет 2"
                ;       5 - адресное пространство
                ;           * точка входа
                ;           * главный цикл
                ;       6 - 
                ;           * главное меню
                ;           * функция вывода текста на базовый экран
                ;           * графика символов 3х языков
                ;           * рез. под музыку
                ;       7 - теневой экран
                ;           * генерируемые тайлопары карты мира
                ;

                include "Bootloader/Pack.inc"                                   ; упаковка boot загрузчика
                include "Game/Packs.inc"                                        ; упаковка игрового кода

                display "-------------------------------------------------------------------------------------------------------------------------------"

                labelslist "C:/Work/spectrum/unreal/user.l"
                ; labelslist "C:/Work/Spectrum/unreal NS r0170/user.l"

                ifdef _DEBUG
                savesna SNA_FILENAME, Bootloader.StartBoot
                ifdef _DEBUG_EXECUTE
                shellexec  "C:/Work/spectrum/unreal/unreal.exe RPG.sna"	        ; путь UNREAL эмулятора и путь запускаемого файла
                endif
                else
                shellexec  "C:/Work/spectrum/unreal/unreal.exe RPG.tap"	        ; путь UNREAL эмулятора и путь запускаемого файла
                endif

                endif ; ~_BUILDER_PACK_
