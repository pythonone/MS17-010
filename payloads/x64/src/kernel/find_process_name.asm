;
; Windows x64 Kernel Find Process by Name Shellcode
;
; Author: Sean Dillon <sean.dillon@risksense.com> (@zerosum0x0)
; Copyright: (c) 2017 RiskSense, Inc.
; License: Apache 2.0
;
; Arguments: r11d = process hash
; Clobbers: RAX, RCX, RDX, R8, R9, R10, R11
;

[BITS 64]
[ORG 0]

find_process_name:
  xor ecx, ecx

_find_process_name_loop_pid:

  add cx, 0x4
  cmp cx, 0x1000
  jb  _find_process_name_loop_pid

  xor rax, rax
  ret
