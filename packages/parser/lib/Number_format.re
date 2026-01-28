let float_to_string = value => {
  let raw = string_of_float(value);
  let has_dot = String.contains(raw, '.');
  if (!has_dot) {
    raw;
  } else {
    let len = String.length(raw);
    let rec drop_zeros = idx =>
      idx > 0 && String.get(raw, idx - 1) == '0'
        ? drop_zeros(idx - 1)
        : idx;
    let trimmed_len = drop_zeros(len);
    let trimmed_len =
      trimmed_len > 0 && String.get(raw, trimmed_len - 1) == '.'
        ? trimmed_len - 1
        : trimmed_len;
    trimmed_len == len ? raw : String.sub(raw, 0, trimmed_len);
  };
};
