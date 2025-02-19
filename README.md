# asm-tutorial-io (LINUX)
ASM tutorial in file input and output operations. <br>
I wish that I could make pretty readme's

## How to compile:
We will be using NASM and GCC for this example (Intel syntax) (X86-64) <br>
NASM to make object file, GCC to compile object file, RM to delete object file (obsolete once we have our executable)
```cmd
nasm -f elf64 main.asm -o main.o
gcc main.o -o main -nostdlib -no-pie
rm main.o
```
## Explanation within ASM comments:
uncommented code can be found in main.asm file <br>
main.asm:
```asm
;
; ASM INPUT TUTORIAL
;

; nasm -f elf64 main.asm -o main.o
; gcc main.o -o main -nostdlib -no-pie
; rm main.o

; Explaining "mov"
; "mov" means "move". It simply moves a value 
; into a register. For example, "mov rdi, 1"
; will move the value of 1 into the "rdi" 
; register.

global _start 

section .bss 
  ; input1: Create buffer for input.
  input1 resb 16

section .text
  ; dialogue1: Creates a string to later 
  ; print.
  
  ; dialogue1_len: Initializes the length to
  ; pass as an argument for sys_write.
  
  dialogue1 db "INPUT: ", 0
  dialogue1_len equ $ - dialogue1

  dialogue2 db "YOU SAID: ", 10
  dialogue2_len equ $ - dialogue2

_start:
  ; This is a syscall named sys_write that 
  ; will communicate to the Linux kernel 
  ; that it wants to print. 

  ; The value you place in the "rax" register
  ; will determine what syscall you will be
  ; asking the kernel for. In x86-64 ASM, if
  ; you move the value of 1 into the "rax"
  ; register, you are asking the Linux kernel
  ; to perform sys_write.

  ; For the second register argument in sys_write,
  ; "rdi", it's the "file descriptor". By passing
  ; 1 to it, we are specifically writing to the 
  ; stdout section of the system, which is the 
  ; console. You can also pass 2 to "rdi" for 
  ; stderr (errors).

  ; The third argument, "rsi", is what the 
  ; kernel will accept as what to print; in
  ; our case, it's "dialogue1", which is defined
  ; just above.

  ; The "rdx" argument, while annoying, is
  ; essential for the intended operation of your 
  ; code. Here, the kernel asks, "To what length
  ; would you have me print the previously stated
  ; string?"

  mov rax, 1             ; specifies sys_write
  mov rdi, 1             ; specifies stdout
  mov rsi, dialogue1     ; specifies what to print
  mov rdx, dialogue1_len ; specifies how long to print it
  syscall                ; performs sys_write

  ; This syscall, sys_read, requests input from 
  ; the user via the Linux kernel.

  ; To obtain sys_read, place 0 into the rax register. 
  
  ; The argument rdi is also a file descriptor. You will
  ; pass 0 to it for console input.

  ; For "rsi", we pass our "input1" buffer to store input 
  ; to use for later. Note that the data within the buffer
  ; is not quite ready for arithmetic operations yet.

  ; And finally, we have "rdx", which is the size of the 
  ; input that we will be writing to our buffer "input1".

  mov rax, 0             ; specifies sys_read
  mov rdi, 0             ; specifies stdin
  mov rsi, input1        ; specifies input1 as input buffer
  mov rdx, 16            ; specifies stdin write size
  syscall                ; performs sys_read

  ; This code will print what we just took in as input.

  mov rax, 1             ; specifies sys_write
  mov rdi, 1             ; specifies stdout
  mov rsi, input1        ; specifies that we print what's in the input buffer
  mov rdx, 16            ; specifies how long to print 
  syscall                ; performs sys_write

  ; sys_exit tells the Linux kernel to exit with
  ; a code. The code, when sys_exit is called,
  ; will return the value stored in the "rdi"
  ; register.
  
  mov rax, 60            ; specifies sys_exit
  mov rdi, 0             ; will return 0
  syscall                ; performs sys_exit


```
