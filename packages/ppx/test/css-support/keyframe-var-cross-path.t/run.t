Regression guard: the SAME [%keyframe] compiled from two different file paths
must mint the SAME `keyframe-…` name and the SAME internal `var(--…)` names.

[%keyframe] shares the `Hash_class.scoped_namespace` recipe with
[%styled.global], so it carries the identical cross-build invariant. The
internal height variables are namespaced on the compilation-unit module name
(`Anim_Css`), not the physical path; the keyframe name is then content-hashed
from the already-substituted body, so once the vars agree the name agrees too.
The runtime `CSS.Types.AnimationName.make ~vars:[…] "keyframe-X"` therefore
references the same names the statically extracted `@keyframes keyframe-X`
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
  $ standalone --impl native/Anim_Css.ml -o native/Anim_Css.ml
  $ refmt --parse re --print ml js/Anim_Css.re > js/Anim_Css.ml
  $ standalone --impl js/Anim_Css.ml -o js/Anim_Css.ml

The extracted @keyframes rule is byte-identical across both paths:

  $ grep -h 'keyframes' native/Anim_Css.ml
    "@keyframes keyframe-l72inm{0%{height:var(--var-hftwzv);}100%{height:var(--var-14y9cfq);}}"]
  $ grep -h 'keyframes' js/Anim_Css.ml
    "@keyframes keyframe-l72inm{0%{height:var(--var-hftwzv);}100%{height:var(--var-14y9cfq);}}"]

The keyframe name matches across paths:

  $ grep -o -- 'keyframe-[a-z0-9]*' native/Anim_Css.ml | sort -u
  keyframe-l72inm
  $ grep -o -- 'keyframe-[a-z0-9]*' js/Anim_Css.ml | sort -u
  keyframe-l72inm

And the internal vars match across paths (the runtime `~vars` list references
the same names the static @keyframes block defines):

  $ grep -o -- '--var-[a-z0-9]*' native/Anim_Css.ml | sort -u
  --var-14y9cfq
  --var-hftwzv
  $ grep -o -- '--var-[a-z0-9]*' js/Anim_Css.ml | sort -u
  --var-14y9cfq
  --var-hftwzv
