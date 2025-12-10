  $ refmt --parse re --print ml ./input.re > input.ml
  File "./input.re", line 1, characters 3-7:
  1 | (* Test file for [%spec] extension *)
         ^^^^
  Error: Unclosed "(" (opened line 1, column 0)
  
  [1]
  $ as_standalone --impl input.ml -o output.ml
  $ refmt --parse ml --print re --in-place output.ml
  $ cat output.ml
  

