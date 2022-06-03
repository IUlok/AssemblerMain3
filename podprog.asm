include io.asm                              ;
.model small                                ;
.stack 100                                  ; Начало сегмента стека
.data                                       ; Начало сегмента данных
array1 db 100 dup(?)                        ;
.code                                       ; Начало сегмента кода
public podprog                              ; Доступ подпрограммы для других программ
podprog proc far                            ; Сегмент + 16-битное смещение
      push bp                               ; Получение адреса возврата из стека. Выше bp располагаются - параметры. Ниже bp располагаются локальные переменные. Ещё ниже временные переменные.
      mov bp, sp                            ; Запись Stack pointer в bp
      mov cx, [bp+8]                        ;
      mov bx, [bp+6]                        ;
      mov si, 0                             ; Обнуление счетчика si, отвечающего за индекс элемента строки
starting:                                   ; Метка starting                             ; ]
      mov al, ' '                           ;
      mov dx, [bx]                          ;
      cmp dl, al                            ; Сравнение введенного символа с пробелом
      jne ifelse                            ; Если не пробел - переход на метку ifelse
      jmp cycle                             ; Иначе (т.е. если пробел) - переход на метку cycle
ifelse:                                     ; Метка ifelse
      mov array1[si], dl                    ; Запись введенного символа в массив по текущему индексу
      inc si                                ; Увеличение счетчика индекса массива
cycle:                                      ; Метка cycle
      inc bx                                ;
      loop starting                         ; Новая итерация цикла
      mov al, '$'                           ; Запись символа конца строки в al
      mov array1[si], al                    ; Запись в конец строки символа конца строки
      mov bx, offset array1                 ;
      newline                               ;
      mov sp, bp                            ;
      pop bp                                ;
      ret                                   ;
podprog endp                                ;
end                                         ;
