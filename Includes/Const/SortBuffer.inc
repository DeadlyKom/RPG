
                ifndef _CONST_SORT_BUFFER_
                define _CONST_SORT_BUFFER_
SortBuffer      EQU #BD00                                                       ; адрес буфера отсортированных объектов
SortBufSize     EQU #0100                                                       ; размер буфера отсортированных объектов
SORT_BUF_ADR    EQU Adr.SortBuffer

                endif ; ~_CONST_SORT_BUFFER_
