Extrn podprog: Far
include io.asm
.model small
.stack 100
.data
  array db 100 dup(?)
  msg1 db "Enter size of array: ", 0Ah, 0Dh, '$'
.code
.startup
start:
      mov ah, 9
      lea dx, msg1
      int 21h
      InInt bx
      push bx
      push ds
      mov dx, offset array
      push dx
      call podprog
      pop bx
      mov ah, 9
      lea dx, array
      int 21h
      .exit 0
end
