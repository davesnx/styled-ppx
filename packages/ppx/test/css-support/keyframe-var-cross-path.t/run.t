Regression guard: the SAME [%keyframe] compiled from two different file paths
must mint the SAME `k-…` name and the SAME internal `var(--…)` names.

[%keyframe] shares the `Hash_class.scoped_namespace` recipe with
[%styled.global], so it carries the identical cross-build invariant. The
internal height variables are namespaced on the compilation-unit module name
(`Anim_Css`), not the physical path; the keyframe name is then content-hashed
from the already-substituted body, so once the vars agree the name agrees too.
The runtime `CSS.Types.AnimationName.make ~vars:[…] "k-X"` therefore
references the same names the statically extracted `@keyframes k-X`
block defines, regardless of which toolchain/path compiled it.

Before the fix the physical path was folded into the namespace, so
`native/Anim_Css` and `js/Anim_Css` produced different internal vars and thus
different keyframe names.

Compile the byte-identical source under two distinct paths sharing the
basename:

  $ mkdir -p native js
  $ cp Anim_Css.re native/Anim_Css.re
  $ cp Anim_Css.re js/Anim_Css.re
  $ refmt --parse re --print ml native/Anim_Css.re > native/Anim_Css.ml
  $ ../../standalone.exe --impl native/Anim_Css.ml -o native/Anim_Css.ml
  $ refmt --parse re --print ml js/Anim_Css.re > js/Anim_Css.ml
  $ ../../standalone.exe --impl js/Anim_Css.ml -o js/Anim_Css.ml

The runtime `~vars` list references the same names the static @keyframes block
defines, and the PPX output is byte-identical across both paths:

  $ refmt --parse ml --print re native/Anim_Css.ml
  [@css
    "@keyframes _k_t5c4er{0%{height:var(--h0-hftwzv);}100%{height:var(--h1-14y9cfq);}}"
  ];
  let h0 = `px(0);
  let h1 = `px(100);
  let grow =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--h0-hftwzv", CSS.Types.Height.toString(h0)),
        ("--h1-14y9cfq", CSS.Types.Height.toString(h1)),
      ],
      "_k_t5c4er",
    );
  $ diff native/Anim_Css.ml js/Anim_Css.ml
