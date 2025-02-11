;; Auxiliary material for PI2 lecture, University of Mannheim
;;
;; Run with: nasm -f elf64 errorbits.s && gcc -no-pie -znoexecstack errorbits.o
;; && ./a.out
;;
;; This assembler program targets the x86-64 architecture (Intel/AMD) and uses
;; x86-64 ABI (Linux). It won't work with other processors or other operating
;; systems.
;;
;; Author: Rainer Gemulla

;; The text section contains code.
section .text
extern printf                  ; from the C standard library
global main

;; Function that adds the two 32-bit integers given in edi (1st argument) and
;; esi (2nd argument). Prints information about the result, including carry and
;; overflow flag, the operands and result in hexadecimal representation, in
;; decimal representation when interpreted unsigned, and in decimal
;; representation when interpreted signed.
add32:
  ; Push all callee-saved registers that we change below. We are not allowed to
  ; modify these registers in a function per x86-64 ABI calling convention.
  push r12

  ; clear out some registers that we use below (i.e., set them to 0)
  xor r8, r8
  xor r9, r9
  xor r10, r10
  xor rax, rax
  xor rbx, rbx

  ; Perform the add operation and store operands, result, and flags in
  ; registers. The e prefix / d postfix in the code below refers to the lower 32
  ; bits. Observe that the add operation is performed only once.
  mov r8d, edi                 ; r8 = 1st operand
  mov r9d, esi                 ; r9 = 2nd operand
  mov r10d, edi                ; r10 = result
  add r10d, r9d                ; this is the add operation
  setc al                      ; r11 = carry flag
  mov r11, rax
  seto bl                      ; r12 = overflow flag
  mov r12, rbx

  ; r8-r10 are caller-saved and may be modified by the call to printf below.
  ; Save them on the stack.
  push r8
  push r9
  push r10

  ; print the flags (calls printf from the C standard library)
  lea rdi, [rel flags_format]   ; rdi = first argument (format string)
  mov rsi, r11                  ; rsi = second argument (carry flag)
  mov rdx, r12                  ; rdx = third argument (overflow flag)
  xor al, al                    ; sets al = 0 = no variable arguments
  call printf

  ; restore r8-r10
  pop r10
  pop r9
  pop r8

  ; Print the operation. Observe that we provide exactly three numbers (the two
  ; input operands and the result), but interpret them in different ways via the
  ; format string in add_format (which see).
  lea rdi, [rel add_format]     ; rdi = first argument (format string)
  mov rsi, r8                   ; rsi = second argument (first operand)
  mov rdx, r9                   ; rdx = third argument (second operand)
  mov rcx, r10                  ; rcx = fourth argument (result)
  xor al, al                    ; sets al = 0 = no variable arguments
  call printf

  ; restore callee-saved registers
  pop r12

  ; all done
  ret

;; main function
main:
  ; signed OK, unsigned OK
  mov edi, 123
  mov esi, 45
  call add32

  ; signed BAD, unsigned OK
  mov edi, 0x07FFFFFFF
  mov esi, 1
  call add32

  ; signed OK, unsigned BAD
  mov edi, -1
  mov esi, 5
  call add32

  ; signed BAD, unsigned BAD
  mov edi, -1
  mov esi, 0x80000000
  call add32

  ; return
  retn

;; The data section contains data.
section .data
;; The format strings we use in printf above, as zero-terminated ASCII strings.
;; Here we use:
;; - %n$ to refer to the n-th variable argument to printf
;; - d for signed representation
;; - u for unsigned representation
;; - x for hexadecimal representation
;; - 10 for newline character
;; - 0 for the end-of-string marker
flags_format: db 'Flags after operation: carry bit=%d overflow bit=%d', 10, 0
add_format: db \
  '  hexadecimal:  %1$#010x +  %2$#010x =  %3$#010x', 10, \
  '  unsigned   : %1$11u + %2$11u = %3$11u', 10, \
  '  signed     : %1$11d + %2$11d = %3$11d', 10, 10, 0
