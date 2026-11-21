type entry = {
  longident: string,
  class_string: string,
};

let record: (~longident: string, ~class_string: string) => unit;

let drain: unit => list(entry);
