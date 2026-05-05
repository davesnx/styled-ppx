/* M defines two [%cx2] bindings that N consumes via selector interp:
   - `marker` mints one class (empty body)
   - `card` mints multiple classes (one per declaration), so the
     consumer's `.$(M.card)` must fan out into a chain at the
     aggregator level. */
let marker = [%cx2 {||}];
let card = [%cx2 {| display: flex; padding: 10px; |}];
