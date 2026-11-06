A block without a binding cannot write a sibling scope: it has no id to print.

  $ refmt --parse re --print ml input.re > input.ml
  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  File "input.ml", line 1, characters 15-20:
  1 | let _ = [%css "& + & { margin-top: 3px }"]
                     ^^^^^
  Error: The selector `& + &` matches a sibling of the same component, so it needs a binding id. Write it in a named `let` binding.
  [1]
  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  File "input.ml", line 1, characters 15-20:
  1 | let _ = [%css "& + & { margin-top: 3px }"]
                     ^^^^^
  Error: The selector `& + &` matches a sibling of the same component, so it needs a binding id. Write it in a named `let` binding.
  [1]
