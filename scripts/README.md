## css-winner-diff

`node scripts/css-winner-diff.ts OLD.css NEW.css [--summary]` compares two
stylesheets emitted by `styled-ppx.generate` in development mode (one CSS
rule per line) and reports which CSS rule pairs — same property, same
specificity, same at-rule wrapper, different selector — had their cascade
winner (the later, and therefore applied, rule) flip between the two files.
Only pairs where both rules are byte-identical (same wrapper, selector,
property and value) in both files are compared, so a flip means the same two
declarations changed relative order, not that either declaration changed.
`--summary` prints per-property flip counts instead of the full pair detail.
The exit code is always `0`; this is a report, not a CI gate. Run
`node scripts/css-winner-diff.ts --self-test` to run its self-checks.
