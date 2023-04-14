
                ifndef _MODULE_GAME_RENDER_SORT_QUICKSORT_
                define _MODULE_GAME_RENDER_SORT_QUICKSORT_
; -----------------------------------------
; сортировка
; In:
;   C - количествой элементов в массиве (обязательно > 0)
; Out:
; Corrupt:
; Note:
;  не устойчив к прерыванию
; -----------------------------------------
Quicksort:      LD A, C
                DEC A
                RET Z

                ; инициализация
                LD (.ContainerSP), SP
                LD HL, SortBuffer
                LD B, #01                                                       ; текущий элемент

                ; инициализация
                LD SP, HL
                LD A, B
                INC A
                EX AF, AF'

                ; s     = C  - размер массива
                ; i     = B  - текущий элемент
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
                ; DEC C
                ; JR NZ, .Loop
                DJNZ .Loop

.Next           ; i = j, j++
                EX AF, AF'
                LD B, A
                INC A
                EX AF, AF'

                ; 
                LD A, B
                DEC A
                ADD A, A
                LD L, A
                LD H, HIGH SortBuffer
                LD SP, HL

                ; i < size
                LD A, B
                CP C
                JP C, .Loop

.ContainerSP    EQU $+1
                LD SP, #0000

                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_QUICKSORT_
