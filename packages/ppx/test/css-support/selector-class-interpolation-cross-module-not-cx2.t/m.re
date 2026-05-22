/* `marker` exists but is a plain string, not a [%css] binding.
   The aggregator can't resolve it (it isn't in the index because the
   index only collects `CSS.make` calls). */
let marker = "some-class-name";
