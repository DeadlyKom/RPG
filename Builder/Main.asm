    
                ifndef _BUILDER_MAIN_
                define _BUILDER_MAIN_

                DEVICE ZXSPECTRUM128

                ; define _REBUILD                                                 ; полная пересборка
                define _DEBUG                                                   ; включить отладочный код
                define _OPTIMIZE                                                ; включить оптимизацию (ускорение)
                define _SHOW_DEBUG                                              ; отображение дебажной информации
                ; define _DEBUG_EXECUTE                                           ; запуск отладки

                ifdef _SHOW_DEBUG
                define SHOW_FPS                                                 ; отображать FPS
                ; define SHOW_COLLISION_AABB                                      ; отобразить AABB коллизии
                endif

                define ENABLE_MUSIC                                             ; разрешить музыку
                ; define ENABLE_MOUSE                                             ; разрешить мышь
                define ENABLE_KEMSTON_JOYSTICK_SEGA                             ; разрешить использовать расширенный Кемстон Джойстик (SEGA 8 bits)
                
                include "Includes/Include.inc"

                display "-------------------------------------------------------------------------------------------------------------------------------"
                display "Build version: ", /D, BUILD, ".", /D, MAJOR,".", /D, MINOR
                display "Building the TAP-image of the \'", TAP_FILENAME, "\' project ..."
                display "-------------------------------------------------------------------------------------------------------------------------------"

                include "Pack.inc"

                display "   World sprite size:\t", /D, WORLD_SPRITE_SIZE, "\tAligned: ", /D, WORLD_SPRITE_SIZE_ALIGNED
                
                endif ; ~_BUILDER_MAIN_
