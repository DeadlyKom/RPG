    
                ifndef _BUILDER_MAIN_
                define _BUILDER_MAIN_

                DEVICE ZXSPECTRUM128

                define _REBUILD                                                 ; полная пересборка
                define _DEBUG                                                   ; включить отладочный код
                define _OPTIMIZE                                                ; включить оптимизацию (ускорение)
                define _SHOW_DEBUG                                              ; отображение дебажной информации

                ifdef _SHOW_DEBUG
                define SHOW_FPS                                                 ; отображать FPS
                endif

                define ENABLE_MUSIC                                             ; разрешить музыку
                define ENABLE_MOUSE                                             ; разрешить мышь
                define ENABLE_KEMSTON_JOYSTICK_SEGA                             ; разрешить использовать расширенный Кемстон Джойстик (SEGA 8 bits)
                
                include "Includes/Include.inc"

                display "-------------------------------------------------------------------------------------------------------------------------------"
                display "Build version: ", /D, BUILD, ".", /D, MAJOR,".", /D, MINOR
                display "Building the TAP-image of the \'", TAP_FILENAME, "\' project ..."
                display "-------------------------------------------------------------------------------------------------------------------------------"

                include "Pack.inc"

                endif ; ~_BUILDER_MAIN_
