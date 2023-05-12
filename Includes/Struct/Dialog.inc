
                ifndef _STRUCT_DIALOG_
                define _STRUCT_DIALOG_

                struct FDialog
Options         DW #0000                                                        ; адрес массива вариантов                       [2 байт]
                                                                                ; таблица адресов текста
OptionsSize     DB #00                                                          ; количество вариантов в массиве                [1 байт]
Available       DW #0000                                                        ; адрес маски доступных элементов               [2 байт]
FirstElement    DB #00                                                          ; первый отображжаемы элемент                   [1 байт]
                                                                                ; в массиве вариантов
SkipElement     DB #00                                                          ; пропускаемый элемент                          [1 байт]
                                                                                ; если не нужен (устанвить в 0)
Coord           FLocation                                                       ; позиция диалога H - y, L - x                  [2 байт]
                                                                                ; координаты в пикселях
Size            FSize                                                           ; размеры диалогового окна H - y, L - x         [2 байт]
                                                                                ; координаты в пикселях
HeightRow       DB #00                                                          ; высота строки (в пикселях)
                ends

                endif ; ~_STRUCT_DIALOG_
