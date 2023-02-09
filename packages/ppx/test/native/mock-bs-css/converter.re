open Values;

let string_of_time = t => Js.Int.toString(t) ++ "ms";

let string_of_content = x =>
  switch (x) {
  | #Content.t as c => Content.toString(c)
  | #Counter.t as c => Counter.toString(c)
  | #Counters.t as c => Counters.toString(c)
  | #Gradient.t as g => Gradient.toString(g)
  | #Url.t as u => Url.toString(u)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_counter_increment = x =>
  switch (x) {
  | #CounterIncrement.t as o => CounterIncrement.toString(o)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_counter_reset = x =>
  switch (x) {
  | #CounterReset.t as o => CounterReset.toString(o)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_counter_set = x =>
  switch (x) {
  | #CounterSet.t as o => CounterSet.toString(o)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_column_gap = x =>
  switch (x) {
  | #ColumnGap.t as gcg => ColumnGap.toString(gcg)
  | #Percentage.t as p => Percentage.toString(p)
  | #Length.t as l => Length.toString(l)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_row_gap = x =>
  switch (x) {
  | #RowGap.t as rg => RowGap.toString(rg)
  | #Percentage.t as p => Percentage.toString(p)
  | #Length.t as l => Length.toString(l)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_gap = x =>
  switch (x) {
  | #Gap.t as rg => Gap.toString(rg)
  | #Percentage.t as p => Percentage.toString(p)
  | #Length.t as l => Length.toString(l)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_position = x =>
  switch (x) {
  | `auto => "auto"
  | #Length.t as l => Length.toString(l)
  | #Var.t as va => Var.toString(va)
  | #Cascading.t as c => Cascading.toString(c)
  };

let string_of_color = x =>
  switch (x) {
  | #Color.t as co => Color.toString(co)
  | #Var.t as va => Var.toString(va)
  };

let string_of_dasharray = x =>
  switch (x) {
  | #Percentage.t as p => Percentage.toString(p)
  | #Length.t as l => Length.toString(l)
  };
