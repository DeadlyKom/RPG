
                ifndef _MODULE_GAME_RENDER_SORT_OBJECTS_
                define _MODULE_GAME_RENDER_SORT_OBJECTS_
; -----------------------------------------
; сортировка объектов отображения
; In:
; Out:
; Corrupt:
; Note:
;  прерывание небезопасеный
; -----------------------------------------
Sort:           ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                JR Z, .Set                                                      ; переход, если массив пуст
                EX AF, AF'
                 
                ; инициализация
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD (.ContainerSP), SP

                ; -----------------------------------------
                ; копирование в буфер сортировки
                ; -----------------------------------------
                
                LD HL, SortBuffer
                LD DE, Adr.Object                                               ; стартовый адрес обрабатываемого объекта
                EX AF, AF'
                LD B, A
                LD C, B                                                         ; B - размер массива, C - количествой элементов в массиве

.ObjectLoop     ; проверка валидности элемента
                LD A, (DE)
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .NextObject

                ; CP OBJECT_DECAL
                ; JR Z, $+5
                ; DEC C
                ; JR .NextObject

                ; копирование адреса объекта
                INC E                                                           ; FObjectDecal.Position.Y
                LD (HL), E
                DEC E
                INC L
                LD (HL), D
                INC L

.NextObject     ; следующий элемент
                LD A, E
                ADD A, OBJECT_SIZE
                LD E, A
                ADC A, D
                SUB E
                LD D, A

                DJNZ .ObjectLoop

                ; -----------------------------------------

                LD A, C
                DEC A
                JR Z, .RET

                LD HL, SortBuffer
                LD B, C                                                         ; B - размер массива, C - количествой элементов в массиве
                LD C, #00

                ; инициализация
                LD SP, HL
                LD A, C
                INC A
                EX AF, AF'

                ; s     = B  - размер массива
                ; i     = C  - текущий элемент
                ; j     = A' - следующий элемент
                ; a[]   = SP - указатель на массив
                ;
                ; while (i < s)
                ; {
                ;     if (a[i-1] <= a[i])
                ;     {
                ;         i=j;
                ;         j++;
                ;     }
                ;     else
                ;     {
                ;         ex a[i], a[i-1];
                ;         if (--i == 0)
                ;         {
                ;             i=j;
                ;             j++;
                ;         }
                ;     }
                ; }

.Loop           ; SP - [i-1]

                ; элемент [i-1]
                POP HL
                LD E, (HL)
                INC L
                LD D, (HL)

                ; элемент [i]
                POP HL
                PUSH HL

                ; чтение значения
                LD A, (HL)
                INC L
                LD H, (HL)
                LD L, A

                ; проверка [i] >= [i-1]
                OR A
                SBC HL, DE
                JR NC, .Next    ; i = j; j++

                ; меняем местами адреса
                DEC SP
                DEC SP
                POP HL
                EX (SP), HL
                PUSH HL
                DEC SP
                DEC SP

                ; i--; if (i == 0)
                DEC C
                JR NZ, .Loop

.Next           ; i = j, j++
                EX AF, AF'
                LD C, A
                INC A
                EX AF, AF'

                ; 
                LD A, C
                DEC A
                ADD A, A
                LD L, A
                LD H, HIGH SortBuffer
                LD SP, HL

                ; i < size
                LD A, C
                CP B
                JP C, .Loop

                ; -1
                INC L
                INC L
.RET
.ContainerSP    EQU $+1
                LD SP, #0000

                LD A, C
.Set            LD (Draw.Num), A
                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_OBJECTS_
