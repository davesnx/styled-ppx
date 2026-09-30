A block's own sibling `@media` rewrite must not change what `CSS.merge`
sees as its atoms' merge context. `a` is a single, never-rewritten
`@media (min-width: 600px)` atom; `b`'s own block has a second,
overlapping `@media (min-width: 900px)` for the same property, so `b`'s
600px atom's printed condition gets `and (not (min-width: 900px))`
folded in - but its merge context must still read as plain
`(min-width: 600px)`, exactly like `a`'s.

  $ ../media_merge_repro/print_merge.exe
  a: label:a _id_10wtvz1 _a_izob04e698n
  b: label:b _id_4tp6cw _a_izob04e8zzv _a_mp5mk4el0bp
  merged: label:a _id_10wtvz1 label:b _id_4tp6cw _a_izob04e8zzv _a_mp5mk4el0bp
  a's atom survives the merge: false
