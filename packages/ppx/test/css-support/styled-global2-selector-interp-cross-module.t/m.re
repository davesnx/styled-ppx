/* M defines two [%css] bindings that N consumes via selector interp:
   - `marker` mints one class (empty body)
   - `card` mints multiple classes (one per declaration), so the
     consumer's `.$(M.card)` must fan out into a chain at the
     aggregator level. */
let marker = [%css {||}];
let card = [%css {| display: flex; padding: 10px; |}];
