
                ifndef _CONST_RENDER_BUFFER_
                define _CONST_RENDER_BUFFER_
RenderBuffer    EQU #BF00                                                       ; адрес буфера отображения
RenderBufSize   EQU SCR_WORLD_SIZE_X * (SCR_WORLD_SIZE_Y + 1)                   ; размер буфера отображения (не более 252 байт)
RenderBufPage   EQU PAGE_2                                                      ; страница

                endif ; ~_CONST_RENDER_BUFFER_
