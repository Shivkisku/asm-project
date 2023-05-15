; Define the node structure
struc node
  .key: resd 1
  .degree: resd 1
  .mark: resd 1
  .parent: resq 1
  .child: resq 1
  .left: resq 1
  .right: resq 1
endstruc

; Define the heap structure
struc heap
  .min: resq 1
  .n: resd 1
endstruc

; Implement the necessary heap operations
; ...

; Implement the necessary node operations
; ...

; Define a function to display the contents of the heap
display_heap:
  push rbp
  mov rbp, rsp

  ; Traverse the heap and print each node
  ; ...

  mov rsp, rbp
  pop rbp
  ret
